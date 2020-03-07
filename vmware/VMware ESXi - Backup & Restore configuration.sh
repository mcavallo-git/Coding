#!/bin/sh
exit 1;
# ------------------------------------------------------------
#
# BACKUP ESXI INSTANCE
#

vim-cmd hostsvc/firmware/backup_config;


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
# ------------------------------------------------------------