#!/bin/sh
exit 1;
# ------------------------------------------------------------

NEW_DUMPFILE_UUD="NEW_DUMPFILE_DISK_UUID";

OLD_DUMPFILE_DIRNAME="/vmfs/volumes/datastore1/vmkdump/*.dumpfile";

OLD_DUMPFILE_FILENAME=$(find "/vmfs/volumes/datastore1/vmkdump/" -iname "*.dumpfile";);


esxcli system coredump file list;  # Show the current coredump file

esxcli system coredump file set --unconfigure;  # Unconfigure the coredump file

esxcli system coredump file remove -F --file=${OLD_DUMPFILE_FILENAME};  # Remove the coredump file

esxcli system coredump file add --datastore=${NEW_DUMPFILE_UUD} --file=coredump; # Add the new coredump file

esxcli system coredump file set --smart --enable true;


# ------------------------------------------------------------
#
# Citation(s)
#
#   kb.vmware.com  |  "Removing the ESXi coredump file (2090057)"  |  https://kb.vmware.com/s/article/2090057
#
# ------------------------------------------------------------