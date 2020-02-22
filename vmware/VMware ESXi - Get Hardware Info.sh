#!/bin/bash

# Save output to a logfile in user-dir
echo "" > "/tmp/hostsvc-hostsummary.$(hostname).log";
chmod 0600 "/tmp/hostsvc-hostsummary.$(hostname).log";
vim-cmd hostsvc/hostsummary >> "/tmp/hostsvc-hostsummary.$(hostname).log";
lspci -vvv >> "/tmp/hostsvc-hostsummary.$(hostname).log";


# SFTP into the box and download file @ "/tmp/hostsvc-hostsummary.$(hostname).log"


# ------------------------------------------------------------
#
# Citation(s)
#
#   communities.vmware.com  |  "Solved: How to get ESXi CPU model through comma... | VMware Communities"  |  https://communities.vmware.com/thread/565296
#
# ------------------------------------------------------------