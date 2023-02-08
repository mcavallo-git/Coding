#!/bin/sh
# ------------------------------------------------------------

# Remove the old coredump file
esxcli system coredump file get;  # "Get the dump file path. This command will print the path to the active and/or configured VMFS Dump File."
esxcli system coredump file list;  # "List the active and configured VMFS Diagnostic Files."
esxcli system coredump file set --unconfigure;  # "Unconfigure the current VMFS Dump file."
esxcli system coredump file remove --file=/vmfs/volumes/DATASTORE_2_ID/vmkdump/DUMPFILE_ID.dumpfile;  # "Specify the file name of the Dump File to be removed.  If not given, the configured dump file will be removed."

# Remove the old scratch/swap file
esxcli sched swap system get;  # "Get current state of the options of the system-wide shared swap space."  (determine if "Datastore Enabled" is set to true or not)
esxcli sched swap system set --datastore-enabled false;  # "Disable the datastore option ... for the system-wide shared swap space."


# Create the new coredump file
COREDUMP_DATASTORE_UUID="COREDUMP_DATASTORE_UUID";
mkdir -p "/vmfs/volumes/${COREDUMP_DATASTORE_UUID}/vmkdump";  # Create the coredump directory on target datastore
esxcli system coredump file add --datastore=${COREDUMP_DATASTORE_UUID} --file=coredump;  # "Create a VMkernel Dump VMFS file for this system. Manually specify the datastore & file name of the created Dump File"
esxcli system coredump file set --enable true --smart;  # "Enable the VMkernel dump file ... to be selected using the smart selection algorithm."

# Create the new scratch/swap file (via GUI)
SCRATCH_DATASTORE_NAME="datastore_nvme";
SCRATCH_DATASTORE_UUID="$(esxcli storage filesystem list | grep -i "${SCRATCH_DATASTORE_NAME}" |  awk '{print $3}';)";
SCRATCH_LOCKER_FULLPATH="/vmfs/volumes/${SCRATCH_DATASTORE_UUID}/.locker";
mkdir -p "${SCRATCH_LOCKER_FULLPATH}";  # Create the scratch/swap directory on target datastore
#
#  ⚠️ Manually update key "ScratchConfig.ConfiguredScratchLocation" to contain the value "${SCRATCH_LOCKER_FULLPATH}" via the ESXi GUI under "Manage" > "System" (tab) > "Advanced Settings"
#
esxcli sched swap system get;  # "Get current state of the options of the system-wide shared swap space."
esxcli sched swap system set --datastore-enabled true --datastore-name=${SCRATCH_DATASTORE_NAME};  # "Enable the datastore option ... for the system-wide shared swap space."


# ------------------------------------------------------------
#
# DUMPFILE_FILENAME=$(find "/vmfs/volumes/datastore1/vmkdump/" -iname "*.dumpfile";);
#
# ------------------------------------------------------------
# 
#   > esxcli system coredump file set --help
#
# Usage: esxcli system coredump file set [cmd options]
# 
# Description:
#   set                   Set the active and configured VMkernel Dump VMFS file for this system.
# 
# Cmd options:
#   -e|--enable           Enable or disable the VMkernel dump file. This option cannot be specified when unconfiguring the dump file.
#   -p|--path=<str>       The path of the VMFS Dump File to use. This must be a pre-allocated file.
#   -s|--smart            This flag can be used only with --enable=true. It will cause the file to be selected using the smart selection algorithm.
#   -u|--unconfigure      Unconfigure the current VMFS Dump file.
# 
# ------------------------------------------------------------
#
#   > esxcli system coredump file add --help
#
# Usage: esxcli system coredump file add [cmd options]
# 
# Description:
#   add                   Create a VMkernel Dump VMFS file for this system.
# 
# Cmd options:
#   -a|--auto             Automatically create a file if none found and autoCreateDumpFile kernel option is set.
#   -d|--datastore=<str>  Manually specify the datastore the Dump File is created in.  If not provided, a datastore of sufficient size will be automatically chosen.
#   -e|--enable           Enable diagnostic file after creation.
#   -f|--file=<str>       Manually specify the file name of the created Dump File.  If not provided, a unique name will be chosen.
#   -s|--size=<long>      Manually set the size in MB of the created Dump File.  If not provided, a default size for the current machine will be calculated.
# 
# ------------------------------------------------------------
# 
#   > esxcli sched swap system set --help
#
# Usage: esxcli sched swap system set [cmd options]
# 
# Description:
#   set                   Change the configuration of system-wide shared swap space.
# 
# Cmd options:
#   -d|--datastore-enabled           If the datastore option should be enabled or not.
#   -n|--datastore-name=<str>        The name of the datastore used by the datastore option.
#   -D|--datastore-order=<long>      The order of the datastore option in the preference of the options
#   -c|--hostcache-enabled           If the host cache option should be enabled or not.
#   -C|--hostcache-order=<long>      The order of the host cache option in the preference of the options.
#   -l|--hostlocalswap-enabled       If the host local swap option should be enabled or not.
#   -L|--hostlocalswap-order=<long>  The order of the host local swap option in the preference of the options.
# 
# ------------------------------------------------------------
#
# Citation(s)
#
#   kb.vmware.com  |  "Configuring ESXi coredump to file instead of partition (2077516)"  |  https://kb.vmware.com/s/article/2077516?lang=en_US
#
#   kb.vmware.com  |  "How to detach a LUN device from ESXi hosts (2004605)"  |  https://kb.vmware.com/s/article/2004605
#
# ------------------------------------------------------------