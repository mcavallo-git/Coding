#!/bin/bash
#
# ------------------------------------------------------------
# List services enabled thru systemctl

systemctl list-unit-files --type service --state enabled,generated;


# ------------------------------------------------------------
# Get the name of the local network service

/bin/systemctl list-unit-files | grep -i '^network' | grep -v '\-' | grep '.service' | awk '{print $1}' | sed -e 's/.service//';


# ------------------------------------------------------------
# 
# Show startup config/options for a given service
# 

SERVICE_NAME="mongod"; cat "/lib/systemd/system/${SERVICE_NAME}.service";


# ------------------------------------------------------------
# Citation(s)
#
#   askubuntu.com  |  "How to list all enabled services from systemctl?"  |  https://askubuntu.com/a/1060852
#
# ------------------------------------------------------------