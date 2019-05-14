#!/bin/bash

SUBDOMAIN="dev";

DOMAIN="boneal.net";
FQDN="${SUBDOMAIN}.${DOMAIN}";
TSTAMP="$(date +'%Y%m%d_%H%M%S')";

current_error_log="/home/boneal/public_html/persistent/logfiles/error_log_${SUBDOMAIN}";
archived_error_log="/home/boneal/public_html/persistent/logfiles/archived/error_log_${SUBDOMAIN}_upto_${TSTAMP}";

clear;

echo "";
echo " Archived old logs to:  \"${archived_error_log}\"";
cp -f "${current_error_log}" "${archived_error_log}" && echo "" > "${current_error_log}";

echo "";
echo " Tailing logs for \"${FQDN}\"...";
tail -n 50 -f "${current_error_log}";
