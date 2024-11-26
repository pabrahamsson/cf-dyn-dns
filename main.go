package main

import (
	"context"
	"fmt"
	"net"
	"os"
	"time"

	"github.com/cloudflare/cloudflare-go/v3"
	cfdns "github.com/cloudflare/cloudflare-go/v3/dns"
	"github.com/cloudflare/cloudflare-go/v3/option"
	"github.com/cloudflare/cloudflare-go/v3/zones"
	"github.com/miekg/dns"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
)

const (
	OPENDNS_HOSTNAME      = "myip.opendns.com."
	OPENDNS_NAMESERVER    = "208.67.222.222"
	CLOUDFLARE_NAMESERVER = "1.0.0.1"
)

func dnsQuery(name string, server net.IP) (*dns.Msg, error) {
	msg := new(dns.Msg)
	msg.SetQuestion(name, dns.TypeA)
	c := new(dns.Client)
	reply, _, err := c.Exchange(msg, server.String()+":53")
	if err != nil {
		return nil, err
	}
	return reply, nil
}

func ipLookup(dnsName string) (string, string, error) {
	dnsName = fmt.Sprintf("%s.", dnsName)
	reply_odns, err := dnsQuery(OPENDNS_HOSTNAME, net.ParseIP(OPENDNS_NAMESERVER))
	if err != nil {
		return "", "", err
	}
	reply_cf, err := dnsQuery(dnsName, net.ParseIP(CLOUDFLARE_NAMESERVER))
	if err != nil {
		return "", "", err
	}
	currentIP, ok := reply_odns.Answer[0].(*dns.A)
	if !ok {
		return "", "", fmt.Errorf("currentIP type assertion failed")
	}
	lookupIP, ok := reply_cf.Answer[0].(*dns.A)
	if !ok {
		return "", "", fmt.Errorf("lookupIP type assertion failed")
	}
	return lookupIP.A.String(), currentIP.A.String(), nil
}

func updateDnsRecord(dnsName, newIPAddress string) error {
	log.Info().Msgf("Found new ip address, setting to %s", newIPAddress)

	client := cloudflare.NewClient()

	ctx := context.Background()
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

func main() {
	zerolog.SetGlobalLevel(zerolog.InfoLevel)
	_, ok := os.LookupEnv("CLOUDFLARE_API_TOKEN")
	if !ok {
		log.Info().Msgf("CLOUDFLARE_API_TOKEN is not set")
		os.Exit(1)
	}
	dnsName, ok := os.LookupEnv("CLOUDFLARE_DNS_RECORD")
	if !ok {
		log.Info().Msgf("CLOUDFLARE_DNS_RECORD is not set")
		os.Exit(1)
	}
	for {
		oldIPAddress, newIPAddress, err := ipLookup(dnsName)
		if err != nil {
			log.Error().Msgf("failed to lookup ip addresses, %v", err)
		}

		if oldIPAddress != newIPAddress {
			err := updateDnsRecord(dnsName, newIPAddress)
			if err != nil {
				log.Error().Msgf("%v", err)
			}
		} else {
			log.Info().Msgf("samesies, %s", oldIPAddress)
		}
		time.Sleep(time.Second * 120)
	}
}
