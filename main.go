package main

import (
	"context"
	"errors"
	"fmt"
	"net"
	"net/http"
	"os"
	"sync"
	"time"

	"github.com/cloudflare/cloudflare-go/v3"
	cfdns "github.com/cloudflare/cloudflare-go/v3/dns"
	"github.com/cloudflare/cloudflare-go/v3/option"
	"github.com/cloudflare/cloudflare-go/v3/zones"
	"github.com/miekg/dns"
	"github.com/prometheus/client_golang/prometheus/promhttp"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/attribute"
	"go.opentelemetry.io/otel/metric"
)

const (
	OPENDNS_HOSTNAME      = "myip.opendns.com."
	OPENDNS_NAMESERVER    = "208.67.222.222"
	CLOUDFLARE_NAMESERVER = "1.0.0.1"
	name                  = "github.com/pabrahamsson/cf-dyn-dns"
)

var (
	tracer            = otel.Tracer(name)
	meter             = otel.Meter(name)
	successCnt        metric.Int64Counter
	failureCnt        metric.Int64Counter
	dnsLookupDuration metric.Int64Histogram
	dnsUpdateDuration metric.Int64Histogram
)

type Lookup struct {
	host      string
	name      string
	ipAddress string
}

func (f Lookup) samesies(f2 Lookup) bool {
	return f.ipAddress == f2.ipAddress
}

func init() {
	var err error
	successCnt, err = meter.Int64Counter("dns.success",
		metric.WithDescription("The number of successful DNS requests"),
		metric.WithUnit("{success}"))
	if err != nil {
		panic(err)
	}
	failureCnt, err = meter.Int64Counter("dns.failure",
		metric.WithDescription("The number of failed DNS requests"),
		metric.WithUnit("{failure}"))
	if err != nil {
		panic(err)
	}
	dnsLookupDuration, err = meter.Int64Histogram("dns.lookup.duration",
		metric.WithDescription("The duration of dns lookup."),
		metric.WithUnit("ms"),
	)
	if err != nil {
		panic(err)
	}
	dnsUpdateDuration, err = meter.Int64Histogram("dns.update.duration",
		metric.WithDescription("The duration of dns update."),
		metric.WithUnit("ms"),
	)
	if err != nil {
		panic(err)
	}
}

func dnsQuery(ctx context.Context, lookup *Lookup, wg *sync.WaitGroup, err *error) {
	ctx, span := tracer.Start(ctx, fmt.Sprintf("dnsQuery(%s@%s)", lookup.name, lookup.host))
	defer span.End()
	defer wg.Done()

	var reply *dns.Msg
	nameServer := fmt.Sprintf("%s:53", net.ParseIP(lookup.host).String())

	msg := new(dns.Msg)
	msg.SetQuestion(lookup.name, dns.TypeA)
	c := new(dns.Client)
	start := time.Now()
	reply, _, *err = c.ExchangeContext(ctx, msg, nameServer)
	duration := time.Since(start)
	dnsLookupDuration.Record(ctx, duration.Milliseconds())

	lookupIP, ok := reply.Answer[0].(*dns.A)
	if !ok {
		*err = fmt.Errorf("lookupIP type assertion failed")
	}

	lookup.ipAddress = lookupIP.A.String()

	span.SetAttributes(
		attribute.String("Name", lookup.name),
		attribute.String("Server", lookup.host),
		attribute.String("Result", lookup.ipAddress),
	)
}

func ipLookup(ctx context.Context, dnsLookup *Lookup, hostLookup *Lookup) error {
	ctx, span := tracer.Start(ctx, fmt.Sprintf("ipLookup(%s)", dnsLookup.name))
	defer span.End()

	var err error
	var wg sync.WaitGroup
	wg.Add(2)

	go dnsQuery(ctx, dnsLookup, &wg, &err)
	go dnsQuery(ctx, hostLookup, &wg, &err)
	wg.Wait()

	if err != nil {
		return err
	}

	return nil
}

func updateDnsRecord(ctx context.Context, dnsName, newIPAddress string) error {
	ctx, span := tracer.Start(ctx, fmt.Sprintf("updateDnsRecord(%s)", newIPAddress))
	defer span.End()
	span.SetAttributes(
		attribute.String("Name", dnsName),
		attribute.String("Value", newIPAddress),
	)

	start := time.Now()
	client := cloudflare.NewClient()

	zones, err := client.Zones.List(ctx, zones.ZoneListParams{})
	if err != nil {
		return err
	}
	if len(zones.Result) != 1 {
		return fmt.Errorf("Unexpected number of zones found: %v", zones.Result)
	}
	zoneId := zones.Result[0].ID
	recs, err := client.DNS.Records.List(ctx, cfdns.RecordListParams{
		ZoneID: cloudflare.F(zoneId),
		Name:   cloudflare.F(dnsName),
	})
	if err != nil {
		return err
	}
	if len(recs.Result) != 1 {
		return fmt.Errorf("Unexpected number of records found: %v", recs.Result)
	}
	recordId := recs.Result[0].ID
	_, err = client.DNS.Records.Update(ctx, recordId, cfdns.RecordUpdateParams{
		ZoneID: cloudflare.F(zoneId),
		Record: cfdns.RecordParam{
			Name: cloudflare.F(dnsName),
		},
	}, option.WithJSONSet("content", newIPAddress), option.WithJSONSet("type", "A"))
	duration := time.Since(start)
	dnsUpdateDuration.Record(ctx, duration.Milliseconds())
	if err != nil {
		return err
	}

	log.Info().Msgf("Found new ip address, dns updated to %s", newIPAddress)

	return nil
}

func serveMetrics() {
	log.Printf("serving metrics at localhost:2223/metrics")
	http.Handle("/metrics", promhttp.Handler())
	err := http.ListenAndServe(":2223", nil) //nolint:gosec
	if err != nil {
		log.Error().Msgf("error serving http: %v", err)
		return
	}
}

func main() {
	zerolog.SetGlobalLevel(zerolog.InfoLevel)
	log.Info().Msg("Schtarrrting!!!")
	if err := run(); err != nil {
		log.Fatal().Msg(err.Error())
	}
}

func run() (err error) {
	_, ok := os.LookupEnv("CLOUDFLARE_API_TOKEN")
	if !ok {
		return fmt.Errorf("CLOUDFLARE_API_TOKEN is not set")
	}
	dnsName, ok := os.LookupEnv("CLOUDFLARE_DNS_RECORD")
	if !ok {
		return fmt.Errorf("CLOUDFLARE_DNS_RECORD is not set")
	}

	// Setup OpenTelemetry.
	otelShutdown, err := setupOTelSDK(context.Background())
	if err != nil {
		return err
	}
	// Handle shutdown properly so nothing leaks.
	defer func() {
		err = errors.Join(err, otelShutdown(context.Background()))
	}()

	// Start the prometheus HTTP server and pass the exporter Collector to it.
	go serveMetrics()

	// Initialize the failure count
	failureCnt.Add(context.Background(), 0)

	for {
		dnsLookup := Lookup{
			host: CLOUDFLARE_NAMESERVER,
			name: fmt.Sprintf("%s.", dnsName),
		}
		hostLookup := Lookup{
			host: OPENDNS_NAMESERVER,
			name: OPENDNS_HOSTNAME,
		}
		ctx, span := tracer.Start(context.Background(), "main")

		err := ipLookup(ctx, &dnsLookup, &hostLookup)
		if err != nil {
			failureValueAttr := attribute.Int("ipLookup", 1)
			span.SetAttributes(failureValueAttr)
			failureCnt.Add(ctx, 1, metric.WithAttributes(failureValueAttr))
			return fmt.Errorf("failed to lookup ip addresses, %v", err)
		}

		if !dnsLookup.samesies(hostLookup) {
			err := updateDnsRecord(ctx, dnsName, hostLookup.ipAddress)
			if err != nil {
				failureValueAttr := attribute.Int("updateDnsRecord", 1)
				span.SetAttributes(failureValueAttr)
				failureCnt.Add(ctx, 1, metric.WithAttributes(failureValueAttr))
				return fmt.Errorf("failed to update DNS record, %v", err)
			}
		} else {
			successValueAttr := attribute.Int("success.value", 1)
			span.SetAttributes(successValueAttr)
			successCnt.Add(ctx, 1, metric.WithAttributes(successValueAttr))
			log.Info().Msgf("samesies, %s", dnsLookup.ipAddress)
		}
		span.End()
		time.Sleep(time.Second * 120)
	}
}
