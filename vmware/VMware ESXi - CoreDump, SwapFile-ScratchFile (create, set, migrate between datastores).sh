#!/bin/sh
# ------------------------------------------------------------
# VMware ESXi - Migrate coredump, swapfile-scratchfile, datastore
# ------------------------------------------------------------
#
# COREDUMP FILE
#


if [[ 1 -eq 1 ]]; then
  # Remove old coredump file(s)
  echo "------------------------------------------------------------";
  esxcli system coredump file get;  # "Get the dump file path. This command will print the path to the active and/or configured VMFS Dump File."
  OLD_COREDUMP_FULLPATH="$(esxcli system coredump file list | grep '^/vmfs' | awk '{print $1}';)";
  esxcli system coredump file set --unconfigure;  # "Unconfigure the current VMFS Dump file."
  if [[ -n "${OLD_COREDUMP_FULLPATH}" ]] && [[ -f "${OLD_COREDUMP_FULLPATH}" ]]; then
    esxcli system coredump file remove --file=${OLD_COREDUMP_FULLPATH};  # "Specify the file name of the Dump File to be removed.  If not given, the configured dump file will be removed."
  fi;
  sleep 2;
  echo "------------------------------------------------------------";
  esxcli system coredump file get;  # "Get the dump file path. This command will print the path to the active and/or configured VMFS Dump File."
  sleep 2;
  echo "------------------------------------------------------------";
fi;


if [[ 1 -eq 1 ]]; then
  # VMware ESXi - Configure coredump storage option(s)
  DATASTORE_LIST="$(esxcli storage filesystem list | grep -v '^\(-----\|Mount\)' | grep -v '\s\s\(BOOTBANK\|LOCKER\)';)";
  DATASTORE_COUNT="$(esxcli storage filesystem list | grep -v '^\(-----\|Mount\)' | grep -v '\s\s\(BOOTBANK\|LOCKER\)' | wc -l;)";
  if [[ "${DATASTORE_COUNT}" -le 0 ]]; then
    echo -e "\n""ERROR:  No datastore(s) found";
  else
    sleep 2;
    echo -e "\n""INFO:  Listing datastore names...";
    echo "${DATASTORE_LIST}" | awk '{print $2}';
    echo -e "\n";
    read -p "Enter datastore name (to use for coredump):  " -t ${READ_TIMEOUT:-60} <'/dev/tty';
    DATASTORE_NAME="${REPLY}";
    if [[ -z "${DATASTORE_NAME}" ]]; then
      echo -e "\n""ERROR:  Empty response received";
    else
      DATASTORE_MOUNTPOINT="$(echo "${DATASTORE_LIST}" | grep -i "\s${DATASTORE_NAME}\s" | awk '{print $1}';)";
      DATASTORE_UUID="$(echo "${DATASTORE_LIST}" | grep -i "\s${DATASTORE_NAME}\s" | awk '{print $3}';)";
      sleep 2;
      if [[ -z "${DATASTORE_UUID}" ]] || [[ -z "${DATASTORE_MOUNTPOINT}" ]]; then
        echo -e "\n""ERROR:  Unable to resolve datastore UUID from name \"${DATASTORE_NAME}\"";
      else
        sleep 2;
        # Show coredump status & associated value(s)
        echo -e "\n""(Before Configuration Update(s))";
        esxcli system coredump file get;
        sleep 2;
        # Update the config
        echo -e "\n""INFO:  Calling [ mkdir -p \"${DATASTORE_MOUNTPOINT}/vmkdump\"; ]...";
        mkdir -p "${DATASTORE_MOUNTPOINT}/vmkdump";  # Create the coredump directory on target datastore
        sleep 2;
        echo -e "\n""INFO:  Calling [ esxcli system coredump file add --datastore=${DATASTORE_UUID} --file=coredump; ]...";
        esxcli system coredump file add --datastore=${DATASTORE_UUID} --file=coredump;  # "Create a VMkernel Dump VMFS file for this system. Manually specify the datastore & file name of the created Dump File"
        sleep 2;
        echo -e "\n""INFO:  Calling [ esxcli system coredump file set --enable true --smart; ]...";
        esxcli system coredump file set --enable true --smart;  # "Enable the VMkernel dump file ... to be selected using the smart selection algorithm."
        sleep 2;
        # Show coredump status & associated value(s)
        echo -e "\n""(After Configuration Update(s))";
        esxcli system coredump file get;
        sleep 2;
      fi;
    fi;
  fi;
  echo -e "";
fi;


# ------------------------------------------------------------
#
# SCRATCH/SWAPFILE
#

if [[ 1 -eq 1 ]]; then
  # VMware ESXi - Configure scratch/swapfile storage option(s)
  DATASTORE_LIST="$(esxcli storage filesystem list | grep -v '^\(-----\|Mount\)' | grep -v '\s\s\(BOOTBANK\|LOCKER\)';)";
  DATASTORE_COUNT="$(esxcli storage filesystem list | grep -v '^\(-----\|Mount\)' | grep -v '\s\s\(BOOTBANK\|LOCKER\)' | wc -l;)";
  sleep 2;
  if [[ "${DATASTORE_COUNT}" -le 0 ]]; then
    echo -e "\n""ERROR:  No datastore(s) found";
  else
    echo -e "\n""INFO:  Listing datastore names...";
    echo "${DATASTORE_LIST}" | awk '{print $2}';
    echo -e "\n";
    read -p "Enter datastore name (to use for scratch/swapfile):  " -t ${READ_TIMEOUT:-60} <'/dev/tty';
    DATASTORE_NAME="${REPLY}";
    if [[ -z "${DATASTORE_NAME}" ]]; then
      echo -e "\n""ERROR:  Empty response received";
    else
      DATASTORE_UUID="$(echo "${DATASTORE_LIST}" | grep -i "\s${DATASTORE_NAME}\s" | awk '{print $3}';)";
      DATASTORE_MOUNTPOINT="$(echo "${DATASTORE_LIST}" | grep -i "\s${DATASTORE_NAME}\s" | awk '{print $1}';)";
      sleep 2;
      if [[ -z "${DATASTORE_UUID}" ]] || [[ -z "${DATASTORE_MOUNTPOINT}" ]]; then
        echo -e "\n""ERROR:  Unable to resolve datastore UUID from name \"${DATASTORE_NAME}\"";
      else
        NEW_SCRATCH_LOCATION="${DATASTORE_MOUNTPOINT}/.locker";
        if [[ "${NEW_SCRATCH_LOCATION}" != "${CONFIGURED_SCRATCH_LOCATION}" ]]; then
          sleep 2;
          # Show scratch/swapfile status & associated value(s)
          echo -e "\n""(Before Configuration Update(s))";
          CURRENT_SCRATCH_LOCATION="$(vim-cmd hostsvc/advopt/view "ScratchConfig.CurrentScratchLocation" | sed -rne "s/^\s*value = \"([^\"]+)\".*$/\1/p" | sed -e "s/^[[:space:]]*//" -e "s/[[:space:]]*$//";)";
          echo -e "\"ScratchConfig.CurrentScratchLocation\":     \"${CURRENT_SCRATCH_LOCATION}\"  (currently in use)";
          sleep 1;
          CONFIGURED_SCRATCH_LOCATION="$(vim-cmd hostsvc/advopt/view "ScratchConfig.ConfiguredScratchLocation" | sed -rne "s/^\s*value = \"([^\"]+)\".*$/\1/p" | sed -e "s/^[[:space:]]*//" -e "s/[[:space:]]*$//";)";
          echo -e "\"ScratchConfig.ConfiguredScratchLocation\":  \"${CONFIGURED_SCRATCH_LOCATION}\"  (used after next reboot)";
          sleep 1;
          # Create the scratch/swapfile directory
          echo -e "\n""INFO:  Calling [ mkdir -p \"${NEW_SCRATCH_LOCATION}\"; ]...";
          mkdir -p "${NEW_SCRATCH_LOCATION}";
          # Perform the update to the scratch/swapfile
          echo -e "\n""INFO:  Configuring scratch location to use datastore \"${DATASTORE_NAME}\" with mount point: \"${DATASTORE_MOUNTPOINT}\"...";
          DATASTORE_ENABLED="$(esxcli sched swap system get | sed -rne "s/^\s*Datastore Enabled: ([^\s]+)$/\1/p" | sed -e "s/^[[:space:]]*//" -e "s/[[:space:]]*$//";)";
          if [[ "${DATASTORE_ENABLED}" == "true" ]]; then
            echo -e "\n""INFO:  Calling [ esxcli sched swap system set --datastore-enabled false; ]...";
            esxcli sched swap system set --datastore-enabled false;  # "Disable the datastore option ... for the system-wide shared swap space."
            sleep 10;
          fi;
          echo -e "\n""INFO:  Calling [ esxcli sched swap system set --datastore-enabled true --datastore-name=${DATASTORE_NAME}; ]...";
          esxcli sched swap system set --datastore-enabled true --datastore-name=${DATASTORE_NAME};  # "Enable the datastore option ... for the system-wide shared swap space."
          sleep 5;
          echo -e "\n""INFO:  Calling [ vim-cmd hostsvc/advopt/update \"ScratchConfig.ConfiguredScratchLocation\" string \"${NEW_SCRATCH_LOCATION}\"; ]...";
          vim-cmd hostsvc/advopt/update "ScratchConfig.ConfiguredScratchLocation" string "${NEW_SCRATCH_LOCATION}"; # Update: "The directory configured to be used for scratch space. Changes will take effect on next reboot."
          sleep 5;
          # Show scratch/swapfile status & associated value(s)
          echo -e "\n""(After Configuration Update(s))";
          CURRENT_SCRATCH_LOCATION="$(vim-cmd hostsvc/advopt/view "ScratchConfig.CurrentScratchLocation" | sed -rne "s/^\s*value = \"([^\"]+)\".*$/\1/p" | sed -e "s/^[[:space:]]*//" -e "s/[[:space:]]*$//";)";
          echo -e "\"ScratchConfig.CurrentScratchLocation\":     \"${CURRENT_SCRATCH_LOCATION}\"  (currently in use)";
          sleep 1;
          CONFIGURED_SCRATCH_LOCATION="$(vim-cmd hostsvc/advopt/view "ScratchConfig.ConfiguredScratchLocation" | sed -rne "s/^\s*value = \"([^\"]+)\".*$/\1/p" | sed -e "s/^[[:space:]]*//" -e "s/[[:space:]]*$//";)";
          echo -e "\"ScratchConfig.ConfiguredScratchLocation\":  \"${CONFIGURED_SCRATCH_LOCATION}\"  (used after next reboot)";
          sleep 1;
        else
          echo -e "\n""INFO:  Scratch location already configured to use datastore \"${DATASTORE_NAME}\" with UUID path: \"${DATASTORE_MOUNTPOINT}\"";
        fi;
      fi;
    fi;
  fi;
  if [[ -n "${CONFIGURED_SCRATCH_LOCATION}" ]] && [[ "${CURRENT_SCRATCH_LOCATION}" != "${CONFIGURED_SCRATCH_LOCATION}" ]]; then
    echo -e "\n""NOTICE:  Reboot of ESXi host is required to update \"ScratchConfig.CurrentScratchLocation\" to equal \"ScratchConfig.ConfiguredScratchLocation\"";
    echo -e     "  |";
    echo -e     "  |--> After reboot, remove old scratch directory:  \"${CURRENT_SCRATCH_LOCATION}\"";
  fi;
  echo "";
fi;


# ------------------------------------------------------------
#
# COREDUMP_FILENAME=$(find "/vmfs/volumes/datastore1/vmkdump/" -iname "*.dumpfile";);
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
#   kb.vmware.com  |  "Removing the ESXi coredump file (2090057)"  |  https://kb.vmware.com/s/article/2090057
#
#   sites.google.com  |  "Fix My ScratchConfig Location - MyTechNotesProject"  |  https://sites.google.com/site/mytechnotesproject/vmware/fix-my-scratchconfig-location
#
# ------------------------------------------------------------