#!/bin/sh
# ------------------------------------------------------------
#
# VMware ESXi- Add a vmnic to a vswitch via CLI
#
# ------------------------------------------------------------
#
# Error received when attempting to add vmnic to vswitch:
#   "... HostVirtualSwitchBondBridge is not defined ..."
#
# ------------------------------------------------------------

VMNICX="vmnic0";  # Replace with name of target vmnic
VSWITCHX="vSwitch0";  # Replace with name of target vswitch
esxcli network vswitch standard uplink add --uplink-name=${VMNIC} --vswitch-name=${VSWITCHX};


# ------------------------------------------------------------
#
# Citation(s)
#
#   communities.vmware.com  |  "Solved: Issue with adding physical adapter to virtual switch | VMware Communities"  |  https://communities.vmware.com/thread/571543
#
# ------------------------------------------------------------