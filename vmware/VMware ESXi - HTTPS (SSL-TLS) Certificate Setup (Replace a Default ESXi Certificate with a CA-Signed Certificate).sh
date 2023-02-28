#!/bin/sh


# Replace a Default HTTPS Certificate with a CA-Signed Certificate (onto target [ ESXi ] instance)


# Step 1/3 - FULLCHAIN (CERT+CHAIN) - Backup the original certificate, then (in vim) clear the file via ":1,$d" -> Enter insert-mode via "i" -> Paste updated, PEM-formatted Certificate + CA-Chain via "Shift+Ins" -> Save/Quit via ":wq!"
cp "/etc/vmware/ssl/rui.crt" "/etc/vmware/ssl/rui.bak.$(date +'%Y%m%d_%H%M%S').crt"; vi "/etc/vmware/ssl/rui.crt";


# Step 2/3 - PRIVKEY - Backup the original private-key, then (in vim) clear the file via ":1,$d" -> Enter insert-mode via "i" -> Paste updated, PEM-formatted Private-Key via "Shift+Ins" -> Save/Quit via ":wq!"
cp "/etc/vmware/ssl/rui.key" "/etc/vmware/ssl/rui.bak.$(date +'%Y%m%d_%H%M%S').key"; vi "/etc/vmware/ssl/rui.key";


# Step 3/3 - Restart the [ ESXi host daemon ] followed by the [ vCenter Agent ] service (should be accessible again within ~15-30 seconds) Note: Doesn't affect ESXi's hosting of any VMs or their associated network connection(s)
/etc/init.d/hostd restart; /etc/init.d/vpxa restart;


# ------------------------------------------------------------
# As a one-liner:


cp "/etc/vmware/ssl/rui.crt" "/etc/vmware/ssl/rui.bak.$(date +'%Y%m%d_%H%M%S').crt"; cp "/etc/vmware/ssl/rui.key" "rui.bak.$(date +'%Y%m%d_%H%M%S').key"; vi "/etc/vmware/ssl/rui.crt"; chown "root:root" "/etc/vmware/ssl/rui.crt"; chmod 0644 "/etc/vmware/ssl/rui.crt"; vi "/etc/vmware/ssl/rui.key"; chown "root:root" "/etc/vmware/ssl/rui.key"; chmod 0600 "/etc/vmware/ssl/rui.key"; /etc/init.d/hostd restart; /etc/init.d/vpxa restart;

# ------------------------------------------------------------
#
# Citation(s)
#
#   kb.vmware.com  |  "Restarting the Management agents in ESXi (1003490)"  |  https://kb.vmware.com/s/article/1003490
#
#   pubs.vmware.com  |  "Replace a Default ESXi Certificate with a CA-Signed Certificate"  |  https://pubs.vmware.com/vsphere-51/index.jsp?topic=%2Fcom.vmware.vsphere.security.doc%2FGUID-A261E6D8-03E4-48ED-ADB6-473C2DAAB7AD.html
# 
# ------------------------------------------------------------