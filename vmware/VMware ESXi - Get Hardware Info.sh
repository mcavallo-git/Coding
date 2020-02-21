#!/bin/bash

# Save output to a logfile in user-dir
vim-cmd hostsvc/hostsummary > "~/hostsvc-hostsummary.$(hostname).log";
chmod 0600 "~/hostsvc-hostsummary.$(hostname).log";

# SFTP into the box and download said file


# ------------------------------------------------------------
#
# Citation(s)
#
#   communities.vmware.com  |  "Solved: How to get ESXi CPU model through comma... | VMware Communities"  |  https://communities.vmware.com/thread/565296
#
# ------------------------------------------------------------