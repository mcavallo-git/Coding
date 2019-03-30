#!/bin/sh

if [ -f ~/.duck-dns/secret ]; then curl --max-time 10 --connect-timeout 10 "$(cat ~/.duck-dns/secret | base64 --decode)" && echo ""; fi;


. "/https://www.namecheap.com/support/knowledgebase/article.aspx/29/11/how-do-i-use-a-browser-to-dynamically-update-the-hosts-ip";



RequestForm="https://dynamicdns.park-your-domain.com/update?host=[host]&domain=[domain_name]&password=[ddns_password]&ip=[your_ip]"
