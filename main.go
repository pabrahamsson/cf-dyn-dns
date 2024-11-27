package main

import (
	"context"
	"errors"
	"fmt"
	"net"
	"net/http"
	"os"
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
	tracer     = otel.Tracer(name)
	meter      = otel.Meter(name)
	successCnt metric.Int64Counter
	failureCnt metric.Int64Counter
)

type Lookup struct {
	DnsHost    string
	DnsName    string
	DnsIp      string
	LookupHost string
	LookupName string
	LookupIp   string
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
}

func dnsQuery(ctx context.Context, name string, server net.IP) (string, error) {
	ctx, span := tracer.Start(ctx, fmt.Sprintf("dnsQuery(%s@%s)", name, server.String()))
	defer span.End()

	msg := new(dns.Msg)
	msg.SetQuestion(name, dns.TypeA)
	c := new(dns.Client)
	reply, _, err := c.ExchangeContext(ctx, msg, server.String()+":53")
	if err != nil {
		return "", err
	}

	lookupIP, ok := reply.Answer[0].(*dns.A)
	if !ok {
		return "", fmt.Errorf("lookupIP type assertion failed")
	}

	span.SetAttributes(
		attribute.String("Name", name),
		attribute.String("Server", server.String()),
		attribute.String("Result", lookupIP.A.String()),
	)
	return lookupIP.A.String(), nil
}

func ipLookup(ctx context.Context, lookup *Lookup) error {
	dnsName := fmt.Sprintf("%s.", lookup.DnsName)
	ctx, span := tracer.Start(ctx, fmt.Sprintf("ipLookup(%s)", dnsName))
	defer span.End()

	var err error

	lookup.LookupIp, err = dnsQuery(ctx, lookup.LookupName, net.ParseIP(lookup.LookupHost))
	if err != nil {
		return err
	}
	lookup.DnsIp, err = dnsQuery(ctx, dnsName, net.ParseIP(lookup.DnsHost))
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

	log.Info().Msgf("Found new ip address, setting to %s", newIPAddress)

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
	if err != nil {
		return err
	}

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
	if err := run(); err != nil {
		log.Fatal().Err(err)
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

	for {
		lookup := Lookup{
			DnsHost:    CLOUDFLARE_NAMESERVER,
			DnsName:    dnsName,
			LookupHost: OPENDNS_NAMESERVER,
			LookupName: OPENDNS_HOSTNAME,
		}
		ctx, span := tracer.Start(context.Background(), "main")

		err := ipLookup(ctx, &lookup)
		if err != nil {
			failureValueAttr := attribute.Int("failure.value", 1)
			span.SetAttributes(failureValueAttr)
			failureCnt.Add(ctx, 1, metric.WithAttributes(failureValueAttr))
			return fmt.Errorf("failed to lookup ip addresses, %v", err)
		}

		if lookup.DnsIp != lookup.LookupIp {
			err := updateDnsRecord(ctx, lookup.DnsName, lookup.LookupIp)
			if err != nil {
				failureValueAttr := attribute.Int("failure.value", 1)
				span.SetAttributes(failureValueAttr)
				failureCnt.Add(ctx, 1, metric.WithAttributes(failureValueAttr))
				return fmt.Errorf("failed to update DNS record, %v", err)
			}
		} else {
			successValueAttr := attribute.Int("success.value", 1)
			span.SetAttributes(successValueAttr)
			successCnt.Add(ctx, 1, metric.WithAttributes(successValueAttr))
			log.Info().Msgf("samesies, %s", lookup.DnsIp)
		}
		span.End()
		time.Sleep(time.Second * 120)
	}
}
