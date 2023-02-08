#!/bin/sh
# ------------------------------------------------------------
#
# VMware ESXi - Advanced Options (get, set)
#


# Get - All Advanced Options
vim-cmd hostsvc/advopt/options;
vim-cmd hostsvc/advopt/settings;
esxcli system settings advanced list;


# Get - Specific Advanced Option
vim-cmd hostsvc/advopt/options "Net.FollowHardwareMac";  # Get Advanced Option using "vim-cmd"
esxcli system settings advanced list --option="/Net/FollowHardwareMac";  # Get Advanced Option using "esxcli"


# Set - Specific Advanced Option
vim-cmd hostsvc/advopt/update "Net.FollowHardwareMac" long "1";
esxcli system settings advanced set --option="/Net/FollowHardwareMac" --int-value=1;  # Set Advanced Option using "esxcli"


# ------------------------------------------------------------
#
# Citation(s)
#
#   wiki.vi-toolkit.com  |  "Category:Vimsh - VI-Toolkit"  |  https://wiki.vi-toolkit.com/index.php/Category:Vimsh
#
#   sites.google.com  |  "Fix My ScratchConfig Location - MyTechNotesProject"  |  https://sites.google.com/site/mytechnotesproject/vmware/fix-my-scratchconfig-location
#
# ------------------------------------------------------------