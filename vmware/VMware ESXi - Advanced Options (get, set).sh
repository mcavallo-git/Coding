#!/bin/sh
# ------------------------------------------------------------
#
# VMware ESXi - Advanced Options (get, set)
#

# Get the value of an Advanced Option
vim-cmd hostsvc/advopt/view "Net.FollowHardwareMac";  # Get Advanced Option using "vim-cmd"
esxcli system settings advanced list --option="/Net/FollowHardwareMac";  # Get Advanced Option using "esxcli"


# Set the value of an Advanced Option
vim-cmd hostsvc/advopt/update "Net.FollowHardwareMac" long "1";
esxcli system settings advanced set --option="/Net/FollowHardwareMac" --int-value=1;  # Set Advanced Option using "esxcli"


# ------------------------------------------------------------
#
# Citation(s)
#
#   sites.google.com  |  "Fix My ScratchConfig Location - MyTechNotesProject"  |  https://sites.google.com/site/mytechnotesproject/vmware/fix-my-scratchconfig-location
#
# ------------------------------------------------------------