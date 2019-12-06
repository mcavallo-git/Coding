#!/bin/bash

systemctl list-unit-files --type service --state enabled,generated


# ------------------------------------------------------------
# 
# Show startup config/options (for a given service)
# 
# 
SVC_NAME="mongod";

systemctl "${SVC_NAME}" status;

cat "/lib/systemd/system/${SVC_NAME}.service";


# ------------------------------------------------------------
# Citation(s)
#
#   askubuntu.com  |  "How to list all enabled services from systemctl?"  |  https://askubuntu.com/a/1060852
#
# ------------------------------------------------------------