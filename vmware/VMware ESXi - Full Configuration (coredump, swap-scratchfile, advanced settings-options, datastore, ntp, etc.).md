<!-- ------------------------------------------------------------ -->

# ESXi `7.0`/`8.0` - Full Configuration


<!-- ------------------------------------------------------------ -->

***
## ESXi > Manage > System > Time & Date

- `Autostart`
  - `Edit Settings`
    - `Enabled`: `Yes`
    - `Start delay`: `30` seconds
    - `Stop delay`: `30` seconds
    - `Stop action`: `Shut down`
    - `Wait for heartbeat`: `Yes`

- `Time & Date`
  - `Edit NTP Settings`
    - `Use Network Time Protocal (enable NTP client)` *(Selected)*
      - `NTP service startup policy	`: `Start and stop with host`
      - `NTP servers	`: `pool.ntp.org, time-a-g.nist.gov, time.google.com`


<!-- ------------------------------------------------------------ -->

***
## ESXi > Manage > System > Advanced Settings

- `Key`:     `Net.FollowHardwareMac`
  - `Name`:    `If set to 1, the management interface MAC address will update whenever the hardware MAC address changes.`
  - `Value`:   `1`
  - `Default`: `0`

- `Key`:     `UserVars.HostClientCEIPOptIn`
  - `Name`:    `Whether or not to opt-in for the Customer Experience Improvement Program in Host Client, 0 for ask, 1 for yes, 2 for no`
  - `Value`:   `2`
  - `Default`: `0`

- `Key`:     `UserVars.SuppressShellWarning`
  - `Name`:    `Do not show warning for enabled local and remote shell access`
  - `Value`:   `1`
  - `Default`: `0`

- `Key`:     `VMkernel.Boot.hyperthreadingMitigation`
  - `Name`:    `Restrict the simultaneous use of logical processors from the same hyperthreaded core as necessary to mitigate a security vulnerability.`
  - `Value`:   `True`
  - `Default`: `False`

- `Key`:     `VMkernel.Boot.hyperthreadingMitigationIntraVM`
  - `Name`:    `(ESXi v6.7-U2 and higher, only) Restrict the simultaneous use of logical processors from the same hyperthreaded core as necessary to mitigate a security vulnerability within a single VM.`
  - `Value`:   `False`
  - `Default`: `True`
  

<!-- ------------------------------------------------------------ -->

***
## ESXi > Manage > Services

- `Name`: `ntpd`
  - `Description`: `NTP Daemon`
  - `Status`: `Running` <!-- Start service if not already running -->
  - `Policy`: `Start and stop with host`

- `Name`: `TSM-SSM`
  - `Description`: `SSH`
  - `Status`: `Running` <!-- Start service if not already running -->
  - `Policy`: `Start and stop with host`


<!-- ------------------------------------------------------------ -->

***
## ESXi > Storage > Datastores 

- `New Datastore`
  - `Create new VMFS datastore` &rarr; `Next`
    - `(Enter name for datastore)` &rarr; `Next`
      - `Use full disk` & `VMFS 6` &rarr; `Next`
        - `Finish`


<!-- ------------------------------------------------------------ -->

***
# ESXi > Configure Hostname & Domain Name
- Run the following via SSH on the ESXi host:
```bash
if [[ 1 -eq 1 ]]; then
  # Add a new local admin user to ESXi
  echo -e "\n""INFO:  Calling [ esxcli system account list; esxcli system permission list; ]...";
  esxcli system account list; esxcli system permission list;
  sleep 2;
  echo -e "\n";
  read -p "Enter username (to create & add as a local admin):  " -t ${READ_TIMEOUT:-60} <'/dev/tty';
  if [[ -z "${REPLY}" ]]; then
    echo -e "\n""ERROR:  Empty response received";
  else
    echo -e "\n""INFO:  Calling [ esxcli system account add -d=\"${REPLY}\" -i=\"${REPLY}\" -p -c; ]...";
    # Create a new System Account
    esxcli system account add -d="${REPLY}" -i="${REPLY}" -p -c;
    sleep 2;
    echo -e "\n""INFO:  Calling [ esxcli system permission set --id \"${REPLY}\" --role \"Admin\"; ]...";
    # Assign to the role of "Admin" to target account
    esxcli system permission set --id "${REPLY}" --role "Admin";
    sleep 2;
    echo -e "\n""INFO:  Calling [ esxcli system account list; esxcli system permission list; ]...";
    esxcli system account list; esxcli system permission list;
    sleep 2;
  fi;
  echo "";
fi;
```


<!-- ------------------------------------------------------------ -->

***
# ESXi > Configure Hostname & Domain Name
- Run the following via SSH on the ESXi host:
```bash
if [[ 1 -eq 1 ]]; then
  # Set ESXi host's FQDN (Host/Domain Names) & Restart the [ ESXi host daemon ] service (should be accessible again within ~15-30 seconds)
  read -p "Enter hostname for this ESXi host (domain optionally included):  " -t ${READ_TIMEOUT:-60} <'/dev/tty';
  if [[ -z "${REPLY}" ]]; then
    echo -e "\n""ERROR:  Empty response received";
  else
    echo -e "\n""INFO:  Calling [ esxcfg-advcfg -s \"${REPLY}\" \"/Misc/hostname\"; /etc/init.d/hostd restart; ]...";
    esxcfg-advcfg -s "${REPLY}" "/Misc/hostname"; /etc/init.d/hostd restart;
  fi;
  echo "";
fi;
```


<!-- ------------------------------------------------------------ -->

***
# ESXi > Disable IPv6 Networking
- Run the following via SSH on the ESXi host:
```bash
if [[ 1 -eq 1 ]]; then
# VMware ESXi - Disable IPv6 Networking
echo -e "\n""INFO:  Calling [ esxcli network ip set --ipv6-enabled=false;  # VMware ESXi - Disable IPv6 Networking ]...";
esxcli network ip set --ipv6-enabled=false;
# VMware ESXi - Disable IPv6 System Module
echo -e "\n""INFO:  Calling [ esxcli system module parameters set -m tcpip4 -p ipv6=0;  # VMware ESXi - Disable IPv6 System Module ]...";
esxcli system module parameters set -m tcpip4 -p ipv6=0;
fi;
```


<!-- ------------------------------------------------------------ -->

***
# ESXi > Configure HTTPS Certificate
- Run the following via SSH on the ESXi host:
```bash
# Step 1/3 - FULLCHAIN (CERT+CHAIN) - Backup the original certificate, then open it in vim (to manually update it)
cp "/etc/vmware/ssl/rui.crt" "/etc/vmware/ssl/rui.bak.$(date +'%Y%m%d_%H%M%S').crt"; vi "/etc/vmware/ssl/rui.crt";
```
```bash
# Step 2/3 - PRIVKEY - Backup the original private-key, then open it in vim (to manually update it)
cp "/etc/vmware/ssl/rui.key" "/etc/vmware/ssl/rui.bak.$(date +'%Y%m%d_%H%M%S').key"; vi "/etc/vmware/ssl/rui.key";
```
```bash
# Step 3/3 - Restart the [ ESXi host daemon ] followed by the [ vCenter Agent ] service (should be accessible again within ~15-30 seconds)
/etc/init.d/hostd restart; /etc/init.d/vpxa restart;
```


<!-- ------------------------------------------------------------ -->

***
# ESXi > Configure coredump to use target Datastore
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
          echo -e "\n""INFO:  (Skipped) Coredump already configured to use datastore \"${DATASTORE_NAME}\" with path \"${DATASTORE_COREDUMP_DIRNAME}\"";
        else
          sleep 2;
          # Remove old coredump file
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
  echo "";
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
# ESXi > Configure S.M.A.R.T. daemon poll-rate
- ### Update the ESXi startup script:
  - Open the shellscript in the `vim` editor:
    ```bash
    vi "/etc/rc.local.d/local.sh";
    ```
  - Append the following onto the end of `/etc/rc.local.d/local.sh` *just before* any `exit ...` line(s):
    ```bash
    # Poll the SMART daemon every 15 minutes (instead of the default of every 30)
    SMARTD_POLL_INTERVAL=15
    /etc/init.d/smartd stop;
    sed -r "s/^(.+ -t \"\\\$\{MAX_RETRIES\}\" )(\"\\\$\{SMARTD\}\".+$)/\1-i ${SMARTD_POLL_INTERVAL:-15} \2/g" -i "/etc/init.d/smartd";
    /etc/init.d/smartd start;
    ```
  - Save and quit via `:wq` + `Enter`
- ### Update the S.M.A.R.T. daemon config
  - Pre-Check - Get the config & service status:
    ```bash
    cat /etc/init.d/smartd; ps -c | grep smartd | grep -v grep;  # Show whole file, manually look for "MAX_RETRIES" line - DO NOT grep (for backup reference)
    ```
  - Run the update for the S.M.A.R.T. daemon:
    ```bash
    /etc/rc.local.d/local.sh;
    ```
  - Post-Check - Verify the config was updated as-intended:
    ```bash
    cat /etc/init.d/smartd; ps -c | grep smartd | grep -v grep;  # Show whole file, manually look for "MAX_RETRIES" line - DO NOT grep (for backup reference)
    ```


<!-- ------------------------------------------------------------ -->

***
# ESXi > Configure CIM Server & SFCBD
- Run the following via SSH on the ESXi host:
```bash
esxcli system wbem get | sed -rne "s/^\s*Enabled: (false)\s*$/\1/p" | sed -e "s/^[[:space:]]*//" -e "s/[[:space:]]*$//" | while read CIM_ENABLED_SETTING; do
# Get service status:  CIM Server
echo -e "\n""INFO:  Calling [ /etc/init.d/sfcbd-watchdog status; /bin/sleep 2; ]..."; /etc/init.d/sfcbd-watchdog status; /bin/sleep 2;
# "Allow the 'sfcb-HTTPS-Daem' process to start - This process is the TCP Listener that takes CIM requests from probes and returns the health of the hardware." - http://www.squidworks.net/2017/02/vmware-esxi-6-5-cim-data-disabled-by-default/ 
echo -e "\n""INFO:  Calling [ esxcli system wbem set –-enable=\"true\"; /bin/sleep 5; ]..."; esxcli system wbem set –-enable="true"; /bin/sleep 5;
# Start service:  CIM Server
echo -e "\n""INFO:  Calling [ /etc/init.d/sfcbd-watchdog start; /bin/sleep 5; ]..."; /etc/init.d/sfcbd-watchdog start; /bin/sleep 5;
# Get service status:  CIM Server
echo -e "\n""INFO:  Calling [ /etc/init.d/sfcbd-watchdog status; /bin/sleep 2; ]..."; /etc/init.d/sfcbd-watchdog status; /bin/sleep 2;
# Test service:  CIM Server
echo -e "\n""INFO:  Calling [ /etc/init.d/sfcbd-watchdog test; /bin/sleep 2; ]..."; /etc/init.d/sfcbd-watchdog test; /bin/sleep 2;
done;
```


<!-- ------------------------------------------------------------ -->
***
