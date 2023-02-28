#!/bin/sh
# ------------------------------------------------------------

# VMware ESXi - Get Status of IPv6 Networking
esxcli network ip get;

# VMware ESXi - Disable IPv6 Networking
esxcli network ip set --ipv6-enabled=false;


# ------------------------------------------------------------

# VMware ESXi - Disable IPv6 System Module
esxcli system module parameters set -m tcpip4 -p ipv6=0;


# ------------------------------------------------------------
#
# Citation(s)
#
#   communities.vmware.com  |  "Re: How do I disable IPv6 in ESXi 6.5? - VMware Technology Network VMTN"  |  https://communities.vmware.com/t5/ESXi-Discussions/How-do-I-disable-IPv6-in-ESXi-6-5/m-p/2753344/highlight/true#M271867
#
#   techexpert.tips  |  "Tutorial - How to Disable IPV6 o Vmware ESXi"  |  https://techexpert.tips/vmware/vmware-esxi-disable-ipv6/
#
# ------------------------------------------------------------