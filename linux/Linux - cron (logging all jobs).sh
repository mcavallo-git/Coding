#!/bin/bash

if [ "$(whoami)" != "root" ]; then
	FAIL_MSG="${FAIL_MSG} Must run ${0} as user 'root'";
fi;

### Use sed to parse-out and remove the comment block in-front of the cron-job logger

RSYSLOG_DEFAULTS_CONF="/etc/rsyslog.d/50-default.conf";
SED_ENABLE_CRON_LOGS='s|^#cron|cron|g';
sed --in-place --expression="${SED_ENABLE_CRON_LOGS}" "${RSYSLOG_DEFAULTS_CONF}";

# "#cron.*                         /var/log/cron.log"

