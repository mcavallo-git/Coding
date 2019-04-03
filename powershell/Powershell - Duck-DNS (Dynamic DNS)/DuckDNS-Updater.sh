#!/bin/sh

if [ -f ~/.duck-dns/secret ]; then curl --max-time 10 --connect-timeout 10 "$(cat ~/.duck-dns/secret | base64 --decode)" && echo ""; fi;
