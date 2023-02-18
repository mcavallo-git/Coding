#!/bin/sh
exit 1;
# ------------------------------------------------------------

NEW_COREDUMP_DATASTORE_NAME="NEW_COREDUMP_DATASTORE_NAME";
NEW_COREDUMP_DATASTORE_UUID="$(esxcli storage filesystem list | grep -i "${NEW_COREDUMP_DATASTORE_NAME}" | awk '{print $3}';)";

OLD_COREDUMP_DATASTORE_NAME="OLD_COREDUMP_DATASTORE_NAME";
OLD_COREDUMP_DATASTORE_UUID="$(esxcli storage filesystem list | grep -i "${OLD_COREDUMP_DATASTORE_NAME}" | awk '{print $3}';)";

OLD_COREDUMP_FULLPATH="$(esxcli system coredump file list | grep '^/vmfs' | awk '{print $1}';)";
if [[ -z "${OLD_COREDUMP_FULLPATH}" ]] || [[ ! -f "${OLD_COREDUMP_FULLPATH}" ]]; then
OLD_COREDUMP_FULLPATH=$(find "/vmfs/volumes/${OLD_COREDUMP_DATASTORE_UUID}/vmkdump/" -iname "*.dumpfile";);
fi;

esxcli system coredump file list;  # Show the current coredump file

esxcli system coredump file set --unconfigure;  # Unconfigure the coredump file

if [[ -n "${OLD_COREDUMP_FULLPATH}" ]] && [[ -f "${OLD_COREDUMP_FULLPATH}" ]]; then
esxcli system coredump file remove -F --file=${OLD_COREDUMP_FULLPATH};  # Remove the coredump file
fi;

esxcli system coredump file add --datastore=${NEW_COREDUMP_DATASTORE_UUID} --file=coredump; # Add the new coredump file

esxcli system coredump file set --smart --enable true;


# ------------------------------------------------------------
#
# Citation(s)
#
#   kb.vmware.com  |  "Removing the ESXi coredump file (2090057)"  |  https://kb.vmware.com/s/article/2090057
#
# ------------------------------------------------------------