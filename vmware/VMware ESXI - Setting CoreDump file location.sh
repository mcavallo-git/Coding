#!/bin/sh
exit 1;
# ------------------------------------------------------------

NEW_DUMPFILE_DATASTORE_NAME="NEW_DUMPFILE_DATASTORE_NAME";
NEW_DUMPFILE_DATASTORE_UUID="$(esxcli storage filesystem list | grep -i "${NEW_DUMPFILE_DATASTORE_NAME}" |  awk '{print $3}';)";

OLD_DUMPFILE_DATASTORE_NAME="OLD_DUMPFILE_DATASTORE_NAME";
OLD_DUMPFILE_DATASTORE_UUID="$(esxcli storage filesystem list | grep -i "${OLD_DUMPFILE_DATASTORE_NAME}" |  awk '{print $3}';)";

OLD_DUMPFILE_DIRNAME="/vmfs/volumes/${OLD_DUMPFILE_DATASTORE_UUID}/vmkdump/*.dumpfile";
OLD_DUMPFILE_FILENAME=$(find "/vmfs/volumes/${OLD_DUMPFILE_DATASTORE_UUID}/vmkdump/" -iname "*.dumpfile";);

esxcli system coredump file list;  # Show the current coredump file

esxcli system coredump file set --unconfigure;  # Unconfigure the coredump file

esxcli system coredump file remove -F --file=${OLD_DUMPFILE_FILENAME};  # Remove the coredump file

esxcli system coredump file add --datastore=${NEW_DUMPFILE_DATASTORE_UUID} --file=coredump; # Add the new coredump file

esxcli system coredump file set --smart --enable true;


# ------------------------------------------------------------
#
# Citation(s)
#
#   kb.vmware.com  |  "Removing the ESXi coredump file (2090057)"  |  https://kb.vmware.com/s/article/2090057
#
# ------------------------------------------------------------