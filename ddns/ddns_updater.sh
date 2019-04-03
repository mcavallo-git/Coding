#!/bin/sh

# DDNS - Namecheap
DDNS_SECRET="${HOME}/.namecheap/secret";
if [ -f ${DDNS_SECRET} ]; then
	curl --max-time 10 --connect-timeout 10 "$(cat ${DDNS_SECRET} | base64 --decode)" && echo "";
fi;

# DDNS - Duck-DNS
DDNS_SECRET="${HOME}/.duck-dns/secret";
if [ -f ${DDNS_SECRET} ]; then
	curl --max-time 10 --connect-timeout 10 "$(cat ${DDNS_SECRET} | base64 --decode)" && echo "";
fi;
