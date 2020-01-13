# ------------------------------------------------------------
#
#   Use this document as a template for new ESXi spin-ups
#
# ------------------------------------------------------------

### Build Image (Networking + RAID Drivers) - Via PowerShell
# ${Home}\Desktop\ESXi-Customizer-PS-v2.6.0.ps1 -v65 -vft -load esxcli-shell,esx-ui,net51-r8169,net51-sky2,net55-r8168,net-e1000e,sata-xahci,scsi-megaraid2,scsi-megaraid-mbox,scsi-megaraid-sas,sata-ahci,sata-ata-piix,sata-sata-nv,sata-sata-promise,sata-sata-sil,sata-sata-sil24,sata-sata-svw,scsi-aacraid,lsu-lsi-megaraid-sas-plugin,ohci-usb-ohci,sata-ahci,xhci-xhci,uhci-usb-uhci,ehci-ehci-hcd -outDir ("${Home}\Desktop")


### Use "Rufus-3.8.exe" (or latest version) to burn .iso image onto USB flash drive --> Format target workstation/server with said USB flash drive


### Apply License-Key
LICEN-SEKEY-LICEN-SEKEY-LICEN


### Enable NTP Service
###  |--> Configure to start/stop with host
time.nist.gov,time.google.com


### Enable TSM-SSH Service
###  |--> Configure to start/stop with host


### Update user-password
[PASSWORD-TO-PASTE-HERE]


### Kill SSH Notifications, Set Hostname
esxcfg-advcfg -s 1 "/UserVars/SuppressShellWarning";
esxcfg-advcfg -s "HOSTNAME.DOMAIN.TLD" /Misc/hostname;
/etc/init.d/hostd restart;

