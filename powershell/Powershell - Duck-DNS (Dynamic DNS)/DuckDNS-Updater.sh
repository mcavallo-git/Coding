#!/bin/sh

domains="SUBDOMAIN_HERE";

token="TOKEN_HERE";

curl --max-time 1 --connect-timeout 1 "https://www.duckdns.org/update?verbose=true&domains=${domains}&token=${token}&ip=" && echo "";
