#!/bin/sh

if [[ 1 -eq 1 ]]; then
#
# ESXi - Check the VMs startup settings
#
vim-cmd hostsvc/autostartmanager/get_autostartseq

fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   theitbros.com  |  "Configure Autostart of VM on VMware ESXi – TheITBros"  |  https://theitbros.com/config-virtual-machine-auto-startup-vmware-esxi/
#
# ------------------------------------------------------------