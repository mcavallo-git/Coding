#!/bin/bash

# Remove logfiles older than 90 days & make sure that, net, the logfiles don't add up to over 5 GB (otherwise trim them back until they do)
journalctl --vacuum-time=90d --vacuum-size=5G;


# ------------------------------------------------------------
#
# !!! NOTE: You're most likely best off using a cronjob to run the journalctl compression commands than setting journalctl's config settings !!!
#
# Set journalctl's config to enforce the max disk size allowed for logfiles
# if [ -f "/etc/systemd/journald.conf" ]; then
# /etc/systemd/journald.conf
# SystemMaxUse=5G
# MaxRetentionSec=1year
# MaxFileSec=1month
# fi;
#


# ------------------------------------------------------------
#
# Citation(s)
#
#   unix.stackexchange.com  |  "fedora - Can I remove files in /var/log/journal and /var/cache/abrt-di/usr? - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/130802
#
#   unix.stackexchange.com  |  "journalctl - How to configure journald to discard entries older than a certain time span - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/535174
#
# ------------------------------------------------------------