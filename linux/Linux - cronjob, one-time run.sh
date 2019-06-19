#!/bin/bash

#
# Setup cron-job via [ crontab -e ]
#		Note: to ensure this program runs at-least (and no more-than) once, avoid using
#		stars/asterisks in the first TWO cronjob numbers (minute/hour), so that we can be exact
#
# 18 07 * * * /root/finish_upgrade.sh
#


# Run this file only on a given day
if [ "$(date +'%Y-%m-%d %H:%M')" == "2019-06-19 07:18" ]; then # match the cronjob runtime-minute, here

# Enable Logging
LOGFILE="/var/log/finish_upgrade$(date +'%Y-%m-%d_%H-%M-%S')";
exec > >(tee -a "${LOGFILE}" );
exec 2>&1;

# Finish the upgrade
apt-get -y dist-upgrade;

# Cleanup
apt-get -y autoremove && apt-get -y autoclean;

# Verify with
cat /etc/os-release;

fi;
