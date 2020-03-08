#!/bin/sh
exit 1;
# ------------------------------------------------------------

NEW_DUMPFILE_UUD="NEW_DUMPFILE_DISK_UUID";

OLD_DUMPFILE_DIRNAME="/vmfs/volumes/datastore1/vmkdump/*.dumnpfile";

OLD_DUMPFILE_FILENAME=$(find "/vmfs/volumes/datastore1/vmkdump/" -iname "*.dumnpfile";);


esxcli system coredump file remove -F -f "${OLD_DUMPFILE_DIRNAME}/${OLD_DUMPFILE_FILENAME}";

esxcli system coredump file set -u;

esxcli system coredump file add -d ${NEW_DUMPFILE_UUD}-f coredump;

esxcli system coredump file set --smart --enable true;



# ------------------------------------------------------------
#
# Citation(s)
#
#   kb.vmware.com  |  "Removing the ESXi coredump file (2090057)"  |  https://kb.vmware.com/s/article/2090057
#
# ------------------------------------------------------------