#!/bin/bash

systemctl list-unit-files --type service --state enabled,generated


# ------------------------------------------------------------
# 
# Show startup config/options (for a given service)
# 
#

SVC="mongod"; cat "/lib/systemd/system/${SVC}.service";


# ------------------------------------------------------------
# Citation(s)
#
#   askubuntu.com  |  "How to list all enabled services from systemctl?"  |  https://askubuntu.com/a/1060852
#
# ------------------------------------------------------------