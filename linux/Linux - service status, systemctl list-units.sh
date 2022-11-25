#!/bin/bash
# ------------------------------------------------------------
# Linux - service status, systemctl list-units
# ------------------------------------------------------------

# List services

service --status-all;

systemctl --type=service;  # For OSes without the "service" command built-in (doesn't work on WSL, as systemctl doesn't work on WSL)


# ------------------------------
#
# Grab all services into a variable (requires 'sed' & 'service' packages)
#
ALL_SERVICES=$(service --status-all 2>'/dev/null' | sed --regexp-extended --quiet --expression='s/^\ \[ (\+|\-) \]\ \ (\S+)$/\2/p');
echo "${ALL_SERVICES}";


# ------------------------------

# Check if one, specific service exists, locally (requires 'sed' package)
SERVICE_NAME="sshd";
SERVICE_RET_CODE=$(/bin/systemctl status "${SERVICE_NAME}" --no-pager --full 1>'/dev/null' 2>&1; echo $?;);
if [ ${SERVICE_RET_CODE} -eq 0 ]; then
  echo "Service \"${SERVICE_NAME}\" DOES exist as a local service";
else
  echo "Service \"${SERVICE_NAME}\" does NOT exist as a local service";
fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.tecmint.com  |  "How to List All Running Services Under Systemd in Linux"  |  https://www.tecmint.com/list-all-running-services-under-systemd-in-linux/
#
# ------------------------------------------------------------