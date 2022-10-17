#!/bin/sh
# ------------------------------------------------------------

# Get info for ESXi advanced option "Net.FollowHardwareMac"
esxcli system settings advanced list --option "/Net/FollowHardwareMac";

#   Path: /Net/FollowHardwareMac
#   Type: integer
#   Int Value: 0
#   Default Int Value: 0
#   Min Value: 0
#   Max Value: 1
#   String Value:
#   Default String Value:
#   Valid Characters:
#   Description: If set to 1, the management interface MAC address will update whenever the hardware MAC address changes.

# Set advanced option "Net.FollowHardwareMac" to 1 (Enabled)
esxcli system settings advanced set --option "/Net/FollowHardwareMac" --int-value=1;


# ------------------------------------------------------------
# 
# Usage: esxcli system settings advanced list [cmd options]
# 
# Description:
#   list                  List the advanced options available from the VMkernel.
# 
# Cmd options:
#   -d|--delta            Only display options whose values differ from their default.
#   -o|--option=<str>     Only get the information for a single VMkernel advanced option.
#   -t|--tree=<str>       Limit the list of advanced option to a specific sub tree.
# 
# ------------------------------------------------------------
#
# Usage: esxcli system settings advanced set [cmd options]
#
# Description:
#   set                   Set the value of an advanced option.
#
# Cmd options:
#   -d|--default          Reset the option to its default value.
#   -i|--int-value=<long> If the option is an integer value use this option.
#   -o|--option=<str>     The name of the option to set the value of. Example: "/Misc/HostName" (required)
#   -s|--string-value=<str>
#                         If the option is a string use this option.
#
# ------------------------------------------------------------