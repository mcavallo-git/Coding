#!/bin/sh
exit 1;
# ------------------------------------------------------------
#
# BACKUP ESXI INSTANCE
#

vim-cmd hostsvc/firmware/backup_config;
# |
# ^-- Copy the link that this command outputs, and replace the "http://*/..." with "http://YOUR_ESXI_HOSTNAME_OR_IP/...", then browse to that URL to download it to your local PC
#


# ------------------------------------------------------------
#
# RESTORE ESXI INSTANCE (FROM A GIVEN BACKUP TGZ FILE)
#

vim-cmd hostsvc/maintenance_mode_enter;
vim-cmd hostsvc/firmware/restore_config "/tmp/configBundle.tgz";


# ------------------------------------------------------------
#
# Citation(s)
#
#   graspingtech.com  |  "How to Backup and Restore the VMware ESXi 6.5 Configuration - GraspingTech"  |  https://graspingtech.com/backup-vmware-esxi-6-5-configuration/
#
#   kb.vmware.com  |  "How to back up ESXi host configuration (2042141)"  |  https://kb.vmware.com/s/article/2042141
#
# ------------------------------------------------------------