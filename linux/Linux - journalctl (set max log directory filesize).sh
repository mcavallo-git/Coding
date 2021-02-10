#!/bin/bash

# Remove logfiles older than 90 days & make sure that, net, the logfiles don't add up to over 5 GB (otherwise trim them back until they do)
journalctl --vacuum-time=90d --vacuum-size=5G;


# Set journalctl's config to enforce the max disk size allowed for logfiles
if [ -f "/etc/systemd/journald.conf" ]; then

# /etc/systemd/journald.conf

# SystemMaxUse=5G

fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   unix.stackexchange.com  |  "fedora - Can I remove files in /var/log/journal and /var/cache/abrt-di/usr? - Unix & Linux Stack Exchange"  |  https://unix.stackexchange.com/a/130802
#
# ------------------------------------------------------------