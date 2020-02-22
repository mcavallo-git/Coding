#!/bin/bash

echo "" > "/tmp/hostsvc-hostsummary.$(hostname).log"; # Save output to a logfile in /tmp

chmod 0600 "/tmp/hostsvc-hostsummary.$(hostname).log";

vim-cmd hostsvc/hostsummary >> "/tmp/hostsvc-hostsummary.$(hostname).log";

lspci -vvv >> "/tmp/hostsvc-hostsummary.$(hostname).log";

esxcli storage nmp device list >> "/tmp/hostsvc-hostsummary.$(hostname).log"; # Get storage array (RAID) info

# SFTP into the box and download the logfile
echo "";
echo "  Hardware info saved to \"/tmp/hostsvc-hostsummary.$(hostname).log\"";
echo "";
echo "  Connect to this host via SFTP to download the file, or move it to a secured/controlled datastore and download via ESXi's vCenter-Agent or Web GUI --> Datastore Browser";
echo "";


# ------------------------------------------------------------
#
# Citation(s)
#
#   communities.vmware.com  |  "Solved: How to get ESXi CPU model through comma... | VMware Communities"  |  https://communities.vmware.com/thread/565296
#
# ------------------------------------------------------------