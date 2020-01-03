#!/bin/bash


# Replace a Default HTTPS Certificate with a CA-Signed Certificate (onto target [ ESXi ] instance)


cp "/etc/vmware/ssl/rui.crt" "/etc/vmware/ssl/orig.rui.crt"; # Backup the original certificate


cp "/etc/vmware/ssl/rui.key" "/etc/vmware/ssl/orig.rui.key"; # Backup the original private-key


vi "/etc/vmware/ssl/rui.crt";  # Clear file via ":1,$d" -> Enter insert-mode via "i" -> Paste updated, PEM-formatted Certificate + CA-Chain via "Shift+Ins" -> Save/Quit via ":wq!"


vi "/etc/vmware/ssl/rui.key";  # Clear file via ":1,$d" -> Enter insert-mode via "i" -> Paste updated, PEM-formatted Private-Key via "Shift+Ins" -> Save/Quit via ":wq!"


/etc/init.d/hostd restart;  # Restart the [ ESXi host daemon ] service (should be accessible again within ~15-30 seconds) Note: Doesn't affect any VMs


/etc/init.d/vpxa restart;   # Restart the [ vCenter Agent ] service (should be accessible again within ~15-30 seconds) Note: Doesn't affect any VMs


# ------------------------------------------------------------
# As a one-liner:


cp "/etc/vmware/ssl/rui.crt" "/etc/vmware/ssl/orig.rui_$(date +'%Y%m%d_%H%M%S').crt"; cp "/etc/vmware/ssl/rui.key" "/etc/vmware/ssl/orig.rui_$(date +'%Y%m%d_%H%M%S').key"; vi "/etc/vmware/ssl/rui.crt"; vi "/etc/vmware/ssl/rui.key"; /etc/init.d/hostd restart; /etc/init.d/vpxa restart;


# ------------------------------------------------------------
# Citation(s)
#
#   kb.vmware.com  |  "Restarting the Management agents in ESXi (1003490)"  |  https://kb.vmware.com/s/article/1003490
#
#   pubs.vmware.com  |  "Replace a Default ESXi Certificate with a CA-Signed Certificate"  |  https://pubs.vmware.com/vsphere-51/index.jsp?topic=%2Fcom.vmware.vsphere.security.doc%2FGUID-A261E6D8-03E4-48ED-ADB6-473C2DAAB7AD.html
# 
# ------------------------------------------------------------