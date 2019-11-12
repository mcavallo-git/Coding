#!/bin/bash

# Replacing the default ESXi HTTPS certificate with a CA-signed certificate

cp "/etc/vmware/ssl/rui.crt" "/etc/vmware/ssl/orig.rui.crt"; # Backup the original certificate

cp "/etc/vmware/ssl/rui.key" "/etc/vmware/ssl/orig.rui.key"; # Backup the original private-key

vi "/etc/vmware/ssl/rui.crt";  # Cleared file using Vim command ":1,$d" -> Hit "i" (insert-mode) -> Pasted updated Certificate + CA-Chain (in PEM format)

vi "/etc/vmware/ssl/rui.key";  # Cleared file using Vim command ":1,$d" -> Hit "i" (insert-mode) -> Pasted updated Private-Key (in PEM format)

/etc/init.d/hostd restart; /etc/init.d/vpxa restart;  # Restart the [ ESXi host daemon ] & [ vCenter Agent ] services (Note: Services should be back after about 15-30 seconds) (Note: Restarting these services doesn't stop any currently-running VMs)


# ------------------------------------------------------------
# Citation(s)
#
#   pubs.vmware.com  |  "Replace a Default ESXi Certificate with a CA-Signed Certificate"  |  https://pubs.vmware.com/vsphere-51/index.jsp?topic=%2Fcom.vmware.vsphere.security.doc%2FGUID-A261E6D8-03E4-48ED-ADB6-473C2DAAB7AD.html
#
#   kb.vmware.com  |  "Restarting the Management agents in ESXi (1003490)"  |  https://kb.vmware.com/s/article/1003490
# 
# ------------------------------------------------------------