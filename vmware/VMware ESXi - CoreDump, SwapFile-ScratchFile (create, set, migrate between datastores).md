<!-- ------------------------------------------------------------ -->
<!-- VMware ESXi - Migrate coredump, swapfile-scratchfile, datastore -->
<!-- ------------------------------------------------------------ -->

***
# ESXi > Configure CoreDump to use target Datastore
- Run the following via SSH on the ESXi host:
```bash
if [[ 1 -eq 1 ]]; then
  # VMware ESXi - Configure coredump storage option(s)
  DATASTORE_LIST="$(esxcli storage filesystem list | grep -v '^\(-----\|Mount\)' | grep -v '\s\s\(BOOTBANK\|LOCKER\)';)";
  DATASTORE_COUNT="$(esxcli storage filesystem list | grep -v '^\(-----\|Mount\)' | grep -v '\s\s\(BOOTBANK\|LOCKER\)' | wc -l;)";
  sleep 1;
  if [[ "${DATASTORE_COUNT}" -le 0 ]]; then
    echo -e "\n""ERROR:  No datastore(s) found";
  else
    sleep 1;
    if [[ "${DATASTORE_COUNT}" -eq 1 ]]; then
      # If only one datastore exists, use it by default
      DATASTORE_NAME="$(echo "${DATASTORE_LIST}" | awk '{print $2}';)";
      echo -e "\n""INFO:  Auto-selecting the only available datastore: \"${DATASTORE_NAME}\"";
      sleep 1;
    else
      # Let the user select the desired datastore to be used
      echo -e "\n""INFO:  Listing datastore names...";
      echo "${DATASTORE_LIST}" | awk '{print $2}';
      echo -e "\n";
      read -p "Enter datastore name (to use for coredump):  " -t ${READ_TIMEOUT:-60} <'/dev/tty';
      DATASTORE_NAME="${REPLY}";
      sleep 1;
    fi;
    if [[ -z "${DATASTORE_NAME}" ]]; then
      echo -e "\n""ERROR:  Empty datastore name received";
    else
      DATASTORE_MOUNTPOINT="$(echo "${DATASTORE_LIST}" | grep -i "\s${DATASTORE_NAME}\s" | awk '{print $1}';)";
      DATASTORE_UUID="$(echo "${DATASTORE_LIST}" | grep -i "\s${DATASTORE_NAME}\s" | awk '{print $3}';)";
      sleep 1;
      if [[ -z "${DATASTORE_UUID}" ]] || [[ -z "${DATASTORE_MOUNTPOINT}" ]]; then
        echo -e "\n""ERROR:  Unable to resolve datastore UUID from name \"${DATASTORE_NAME}\"";
      else
        sleep 1;
        # Check if coredump is already set as-intended
        CONFIGURED_COREDUMP_FULLPATH="$(esxcli system coredump file list | grep '^/vmfs' | awk '{print $1}';)";
        FORCE_RECONFIGURE_COREDUMP="0";
        COREDUMP_WAS_UPDATED="0";
        sleep 1;
        CONFIGURED_COREDUMP_DIRNAME="$(dirname "${CONFIGURED_COREDUMP_FULLPATH}";)";
        DATASTORE_COREDUMP_DIRNAME="${DATASTORE_MOUNTPOINT}/vmkdump";
        sleep 1;
        if [[ "${DATASTORE_COREDUMP_DIRNAME}" == "${CONFIGURED_COREDUMP_DIRNAME}" ]]; then
          echo -e "\n""INFO:  (Skipped) CoreDump already configured to use datastore \"${DATASTORE_NAME}\" with path \"${DATASTORE_COREDUMP_DIRNAME}\"";
        else
          sleep 2;
          # Remove old CoreDump file
          if [[ -n "${CONFIGURED_COREDUMP_FULLPATH}" ]] && [[ -f "${CONFIGURED_COREDUMP_FULLPATH}" ]]; then
            esxcli system coredump file set --unconfigure;  # "Unconfigure the current VMFS Dump file."
            esxcli system coredump file remove --file=${CONFIGURED_COREDUMP_FULLPATH};  # "Specify the file name of the Dump File to be removed. If not given, the configured dump file will be removed."
            FORCE_RECONFIGURE_COREDUMP="1";
          fi;
          # Show coredump status & associated value(s)
          echo -e "\n""(Current Configuration)";
          esxcli system coredump file get;
          sleep 2;
          # Update the config
          echo -e "\n""INFO:  Calling [ mkdir -p \"${DATASTORE_COREDUMP_DIRNAME}\"; ]...";
          mkdir -p "${DATASTORE_COREDUMP_DIRNAME}";  # Create the coredump directory on target datastore
          sleep 2;
          echo -e "\n""INFO:  Calling [ esxcli system coredump file add --datastore=${DATASTORE_UUID} --file=coredump; ]...";
          esxcli system coredump file add --datastore=${DATASTORE_UUID} --file=coredump;  # "Create a VMkernel Dump VMFS file for this system. Manually specify the datastore & file name of the created Dump File"
          sleep 2;
          COREDUMP_WAS_UPDATED="1";
        fi;
        # Check if we need to enable the coredump file
        if [[ "${FORCE_RECONFIGURE_COREDUMP}" -eq "1" ]] || [[ "$(esxcli system coredump file list | grep '^/vmfs' | awk '{print $2}';)" != "true" ]]; then
          sleep 1;
          echo -e "\n""INFO:  Calling [ esxcli system coredump file set --enable true --smart; ]...";
          esxcli system coredump file set --enable true --smart;  # "Enable the VMkernel dump file ... to be selected using the smart selection algorithm."
          sleep 1;
        fi;
        if [[ "${COREDUMP_WAS_UPDATED}" -eq "1" ]]; then
          # Show coredump status & associated value(s)
          echo -e "\n""(New Configuration)";
          esxcli system coredump file get;
          sleep 2;
        fi;
      fi;
    fi;
  fi;
  echo -e "";
fi;
```


<!-- ------------------------------------------------------------ -->

***
# ESXi > Configure Scratch/Swapfile to use target Datastore
- Run the following via SSH on the ESXi host:
```bash
if [[ 1 -eq 1 ]]; then
  # VMware ESXi - Configure scratch/swapfile storage option(s)
  DATASTORE_LIST="$(esxcli storage filesystem list | grep -v '^\(-----\|Mount\)' | grep -v '\s\s\(BOOTBANK\|LOCKER\)';)";
  DATASTORE_COUNT="$(esxcli storage filesystem list | grep -v '^\(-----\|Mount\)' | grep -v '\s\s\(BOOTBANK\|LOCKER\)' | wc -l;)";
  sleep 1;
  if [[ "${DATASTORE_COUNT}" -le 0 ]]; then
    echo -e "\n""ERROR:  No datastore(s) found";
  else
    sleep 1;
    if [[ "${DATASTORE_COUNT}" -eq 1 ]]; then
      # If only one datastore exists, use it by default
      DATASTORE_NAME="$(echo "${DATASTORE_LIST}" | awk '{print $2}';)";
      echo -e "\n""INFO:  Auto-selecting the only available datastore: \"${DATASTORE_NAME}\"";
      sleep 1;
    else
      # Let the user select the desired datastore to be used
      echo -e "\n""INFO:  Listing datastore names...";
      echo "${DATASTORE_LIST}" | awk '{print $2}';
      echo -e "\n";
      read -p "Enter datastore name (to use for coredump):  " -t ${READ_TIMEOUT:-60} <'/dev/tty';
      DATASTORE_NAME="${REPLY}";
      sleep 1;
    fi;
    if [[ -z "${DATASTORE_NAME}" ]]; then
      echo -e "\n""ERROR:  Empty datastore name received";
    else
      DATASTORE_MOUNTPOINT="$(echo "${DATASTORE_LIST}" | grep -i "\s${DATASTORE_NAME}\s" | awk '{print $1}';)";
      DATASTORE_UUID="$(echo "${DATASTORE_LIST}" | grep -i "\s${DATASTORE_NAME}\s" | awk '{print $3}';)";
      sleep 1;
      if [[ -z "${DATASTORE_UUID}" ]] || [[ -z "${DATASTORE_MOUNTPOINT}" ]]; then
        echo -e "\n""ERROR:  Unable to resolve datastore UUID from name \"${DATASTORE_NAME}\"";
      else
        sleep 1;
        # Show scratch/swapfile status & associated value(s)
        echo -e "\n""(Current Configuration)";
        CURRENT_SCRATCH_LOCATION="$(vim-cmd hostsvc/advopt/view "ScratchConfig.CurrentScratchLocation" | sed -rne "s/^\s*value = \"([^\"]+)\".*$/\1/p" | sed -e "s/^[[:space:]]*//" -e "s/[[:space:]]*$//";)";
        echo -e "\"ScratchConfig.CurrentScratchLocation\":     \"${CURRENT_SCRATCH_LOCATION}\"  (currently in use)";
        sleep 1;
        CONFIGURED_SCRATCH_LOCATION="$(vim-cmd hostsvc/advopt/view "ScratchConfig.ConfiguredScratchLocation" | sed -rne "s/^\s*value = \"([^\"]+)\".*$/\1/p" | sed -e "s/^[[:space:]]*//" -e "s/[[:space:]]*$//";)";
        echo -e "\"ScratchConfig.ConfiguredScratchLocation\":  \"${CONFIGURED_SCRATCH_LOCATION}\"  (used after next reboot)";
        sleep 1;
        # Compare new scratch/swapfile location against existing (configured) location
        DATASTORE_SCRATCH_DIRNAME="${DATASTORE_MOUNTPOINT}/.locker";
        if [[ "${DATASTORE_SCRATCH_DIRNAME}" == "${CONFIGURED_SCRATCH_LOCATION}" ]]; then
          echo -e "\n""INFO:  (Skipped) Scratch location already configured to use datastore \"${DATASTORE_NAME}\" with path \"${DATASTORE_SCRATCH_DIRNAME}\"";
        else
          sleep 1;
          # Create the scratch/swapfile directory
          echo -e "\n""INFO:  Calling [ mkdir -p \"${DATASTORE_SCRATCH_DIRNAME}\"; ]...";
          mkdir -p "${DATASTORE_SCRATCH_DIRNAME}";
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
          echo -e "\n""INFO:  Calling [ vim-cmd hostsvc/advopt/update \"ScratchConfig.ConfiguredScratchLocation\" string \"${DATASTORE_SCRATCH_DIRNAME}\"; ]...";
          vim-cmd hostsvc/advopt/update "ScratchConfig.ConfiguredScratchLocation" string "${DATASTORE_SCRATCH_DIRNAME}"; # Update: "The directory configured to be used for scratch space. Changes will take effect on next reboot."
          sleep 5;
          # Show scratch/swapfile status & associated value(s)
          echo -e "\n""(New Configuration)";
          CURRENT_SCRATCH_LOCATION="$(vim-cmd hostsvc/advopt/view "ScratchConfig.CurrentScratchLocation" | sed -rne "s/^\s*value = \"([^\"]+)\".*$/\1/p" | sed -e "s/^[[:space:]]*//" -e "s/[[:space:]]*$//";)";
          echo -e "\"ScratchConfig.CurrentScratchLocation\":     \"${CURRENT_SCRATCH_LOCATION}\"  (currently in use)";
          sleep 1;
          CONFIGURED_SCRATCH_LOCATION="$(vim-cmd hostsvc/advopt/view "ScratchConfig.ConfiguredScratchLocation" | sed -rne "s/^\s*value = \"([^\"]+)\".*$/\1/p" | sed -e "s/^[[:space:]]*//" -e "s/[[:space:]]*$//";)";
          echo -e "\"ScratchConfig.ConfiguredScratchLocation\":  \"${CONFIGURED_SCRATCH_LOCATION}\"  (used after next reboot)";
          sleep 1;
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
```


<!-- ------------------------------------------------------------ -->

***


<!-- ---------------------------------------------------------
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
---------------------------------------------------------- -->