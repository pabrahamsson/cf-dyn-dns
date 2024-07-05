package main

import (
	"context"
	"fmt"
	"net"
	"os"
	"time"

	"github.com/cloudflare/cloudflare-go"
	"github.com/miekg/dns"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
)

const (
	OPENDNS_HOSTNAME      = "myip.opendns.com."
	OPENDNS_NAMESERVER    = "208.67.222.222"
	CLOUDFLARE_HOSTNAME   = "ph.gtvc.net."
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

func ipLookup() (string, string, error) {
	reply_odns, err := dnsQuery(OPENDNS_HOSTNAME, net.ParseIP(OPENDNS_NAMESERVER))
	if err != nil {
		return "", "", err
	}
	reply_cf, err := dnsQuery(CLOUDFLARE_HOSTNAME, net.ParseIP(CLOUDFLARE_NAMESERVER))
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

func updateDnsRecord(newIPAddress string) error {
	log.Info().Msgf("Found new ip address, setting to %s", newIPAddress)
	CLOUDFLARE_API_TOKEN := os.Getenv("CLOUDFLARE_API_TOKEN")
	CLOUDFLARE_DNS_ZONE := os.Getenv("CLOUDFLARE_DNS_ZONE")
	CLOUDFLARE_DNS_RECORD := os.Getenv("CLOUDFLARE_DNS_RECORD")
	api, err := cloudflare.NewWithAPIToken(CLOUDFLARE_API_TOKEN)
	if err != nil {
		return err
	}

	ctx := context.Background()
	recs, _, err := api.ListDNSRecords(ctx, cloudflare.ZoneIdentifier(CLOUDFLARE_DNS_ZONE), cloudflare.ListDNSRecordsParams{Name: CLOUDFLARE_DNS_RECORD})
	if err != nil {
		return err
	}

	rec, err := api.GetDNSRecord(ctx, cloudflare.ZoneIdentifier(CLOUDFLARE_DNS_ZONE), recs[0].ID)
	if err != nil {
		return err
	}

	rec, err = api.UpdateDNSRecord(ctx, cloudflare.ZoneIdentifier(CLOUDFLARE_DNS_ZONE), cloudflare.UpdateDNSRecordParams{
		ID:      rec.ID,
		Content: newIPAddress,
	})
	if err != nil {
		return err
	}
	return nil
}

func main() {
	zerolog.SetGlobalLevel(zerolog.InfoLevel)
	for {
		oldIPAddress, newIPAddress, err := ipLookup()
		if err != nil {
			log.Error().Msgf("failed to lookup ip addresses, %v", err)
		}

		if oldIPAddress != newIPAddress {
			err := updateDnsRecord(newIPAddress)
			if err != nil {
				log.Error().Msgf("%v", err)
			}
		} else {
			log.Info().Msgf("samesies, %s", oldIPAddress)
		}
		time.Sleep(time.Second * 120)
	}
}
