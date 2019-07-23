#!/bin/bash

# ------------------------------------------------------------
#
# Copy/Download current config (in JSON format) from your USG
#

# Step 1 - SSH into your Unifi device (USG, for example)

# Step 2 - Export the config to JSON format via the following commands
sudo -i;
EXPORT_FILEPATH="$(getent passwd ${SUDO_USER:-${USER}} | cut -d : -f 6)/$(hostname).$(date +'%Y%m%d_%H%M%S').config.gateway.json";
mca-ctrl -t dump-cfg > "${EXPORT_FILEPATH}";
echo "Export Filepath:   ${EXPORT_FILEPATH}";


# Step 3 - Download the exported JSON file via your SFTP tool of choice (file placed in user's home-directory)


# ------------------------------------------------------------
#
# Apply aftermarket config(s) not availble on Unifi dashboard
#

# - SSH into linux machine hosting the unifi controller

# - Create and/or make-edits-to your unifi site's "config.gateway.json" file, located at:
UNIFI_HOMEDIR=$(getent passwd unifi | cut -d : -f 6);
vi "${UNIFI_HOMEDIR:-/usr/lib/unifi}/data/sites/default/config.gateway.json";

# - Force a Re-provision on the USG via your method-of-choice
#    |--> you may prefer the browser dashboard method, which is done by selecting:   "Devices" (left) -> [YOUR-USG] -> "Manage" (cog) -> "Provision"
#    |--> you may prefer the cli method directly on the usg:  (NEED METHOD, HERE)


mca-ctrl -t dump-cfg > "${HOME}/$(hostname).$(date +'%Y-%m-%d_%H-%M-%S').config.gateway.json";

# ------------------------------------------------------------
#
# Citation(s)
#
# 	help.ubnt.com  |  "UniFi - USG Advanced Configuration"  |  https://help.ubnt.com/hc/en-us/articles/215458888
#
# ------------------------------------------------------------