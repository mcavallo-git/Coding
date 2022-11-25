#!/bin/bash
# ------------------------------------------------------------
# Linux - journalctl (logging, set max filesize, age retention policy, cleanup)
# ------------------------------------------------------------

# Keep the latest 1 GB of logs, trim/remove any other logfiles
sudo journalctl --vacuum-size=1G;

# Remove logfiles older than 90 days & make sure that, net, the logfiles don't add up to over 5 GB (trims oldest logs until "--vacuum-size" filesize requirement is met)
sudo journalctl --vacuum-time=90d --vacuum-size=5G;


# ------------------------------------------------------------

# Setup a cronjob to auto-cleanup logfiles every day at 02:00 AM

sudo -i;  # must act as root to perform these actions;

DAT_CRON="/etc/cron.d/CRON_journalctl_logfile_cleanup";
CRON_CONTENTS="0 2 * * * root journalctl --vacuum-time=90d --vacuum-size=5G;"
echo "${CRON_CONTENTS}" > "${DAT_CRON}" && chown "root:root" "${DAT_CRON}" && chmod 0644 "${DAT_CRON}"; SERVICE_NAME="cron"; /usr/sbin/service "${SERVICE_NAME}" restart 2>'/dev/null'; SERVICE_NAME="crond"; /usr/sbin/service "${SERVICE_NAME}" restart 2>'/dev/null';


# ------------------------------------------------------------
#
# !!! NOTE: You're most likely best off using the above cronjob to run the journalctl compression commands than setting journalctl's config settings !!!
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