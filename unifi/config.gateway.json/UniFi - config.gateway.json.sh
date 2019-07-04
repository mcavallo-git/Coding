#!/bin/bash

# ------------------------------------------------------------
#
# Copy/Download current config (in JSON format) from your USG
#

# - SSH into USG-3P device & run the following command:
mca-ctrl -t dump-cfg > "${HOME}/$(hostname).$(date +'%Y%m%d_%H%M%S').config.gateway.json";



# ------------------------------------------------------------
#
# Apply aftermarket config(s) not availble on Unifi dashboard
#

# - SSH into linux machine hosting the unifi controller

# - Create and/or make-edits-to your unifi site's "config.gateway.json" file, located at:
UNIFI_HOMEDIR=$(getent passwd unifi | cut --delimiter=: --fields=6);
vi "${UNIFI_HOMEDIR:-/usr/lib/unifi}/data/sites/default/config.gateway.json";

# - Force a Re-provision on the USG via your method-of-choice
#    |--> you may prefer the browser dashboard method, which is done by selecting:   "Devices" (left) -> [YOUR-USG] -> "Manage" (cog) -> "Provision"
#    |--> you may prefer the cli method directly on the usg:  (NEED METHOD, HERE)



# ------------------------------------------------------------
#
# Citation(s)
#
# 	help.ubnt.com  |  "UniFi - USG Advanced Configuration"  |  https://help.ubnt.com/hc/en-us/articles/215458888
#
# ------------------------------------------------------------