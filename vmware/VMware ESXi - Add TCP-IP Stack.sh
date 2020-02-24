#!/bin/bash

# Add a new "TCP-IP Stack" to ESXi's "Networking" dashboard
esxcli network ip netstack add -N="TCP-IP-NEW-STACK-NAME";


# ------------------------------------------------------------
#
# Citation(s)
#
#   virtualizationreview.com  |  "How to Configure Multiple TCP/IP Stacks in vSphere 6 -- Virtualization Review"  |  https://virtualizationreview.com/articles/2015/10/26/configure-multiple-tcpip-stacks-in-vsphere-6.aspx
#
# ------------------------------------------------------------