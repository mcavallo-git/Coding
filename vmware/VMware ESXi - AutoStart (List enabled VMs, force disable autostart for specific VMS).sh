#!/bin/sh
# ------------------------------

#
# ESXi - Get startup settings for all VMs
#
vim-cmd hostsvc/autostartmanager/get_autostartseq


#
# ESXi - Disable autostart for a VM which keeps starting on bootup even though the "AutoStart" option for it is set to "Disabled" (in the ESXi GUI)
#  |
#  |--> Note: Get Vmid (Virtual Machine ID#) from command [ vim-cmd vmsvc/getallvms ]
#
vim-cmd hostsvc/autostartmanager/update_autostartentry [Vmid] "none" "5" "1" "none" "5" "yes"


# Example:  Disable Autostart for VM with Vmid==3
vim-cmd hostsvc/autostartmanager/update_autostartentry 3 "none" "5" "1" "none" "5" "yes"


# ------------------------------------------------------------
#
# Citation(s)
#
#   superuser.com  |  "How can I disable autostart for a VM in ESXi or vSphere? - Super User"  |  https://superuser.com/a/1305659
#
#   theitbros.com  |  "Configure Autostart of VM on VMware ESXi – TheITBros"  |  https://theitbros.com/config-virtual-machine-auto-startup-vmware-esxi/
#
# ------------------------------------------------------------