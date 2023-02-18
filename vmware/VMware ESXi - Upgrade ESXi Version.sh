#!/bin/sh
# ------------------------------------------------------------
# VMware ESXi - Upgrade ESXi Version
# ------------------------------------------------------------


# List available ESXi version(s) (sorted)
esxcli software sources profile list --depot=https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml | grep '^ESXi-' | awk '{print $1}' | sort -u;


# Set the values for the version of ESXi to upgrade to
DESIRED_ESXI_VERSION="";


# Update the firewall rules to ALLOW outgoing HTTP requests
esxcli network firewall ruleset set -e true -r httpClient;


# Upgrade to the desired version of ESXi
if [[ -z "${DESIRED_ESXI_VERSION}" ]]; then echo "Error - No ugprade version specified. Please set variable \$DESIRED_ESXI_VERSION to the version of ESXi to upgrade to"; else esxcli software profile update -d "https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml" -p "${DESIRED_ESXI_VERSION}"; fi;


# Upgrade to the desired version of ESXi ! WITHOUT REQUIRING SIGNATURE CHECKING (cross a gap in security to force the update to go through)
if [[ -z "${DESIRED_ESXI_VERSION}" ]]; then echo "Error - No ugprade version specified. Please set variable \$DESIRED_ESXI_VERSION to the version of ESXi to upgrade to"; else esxcli software profile update -d "https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml" -p "${DESIRED_ESXI_VERSION}" --no-sig-check; fi;


# Update the firewall rules to BLOCK outgoing HTTP requests
esxcli network firewall ruleset set -e false -r httpClient;


# Reboot the ESXi host to complete the upgrade
reboot;


# ------------------------------------------------------------
#
# Citation(s)
#
#   miketabor.com  |  "How to upgrade ESXi 6.5 to ESXi 6.7 - Mike Tabor"  |  https://miketabor.com/how-to-upgrade-esxi-6-5-to-esxi-6-7/
#
# ------------------------------------------------------------