#!/bin/sh
# ------------------------------
# VMware ESXi - S.M.A.R.T. data (get sata-nvme ssd disk drives smart info, configure smartd polling frequency)
# ------------------------------

# Watch S.M.A.R.T. disk values
watch -n 15 esxcli storage core device smart get --device-name="$(esxcli storage core device list | sed -rne "s/^\s+Other UIDs:\s+(.{1,80})$/\1/p" | head -n 1;)";


# ------------------------------

# Watch a specific drive's min/max temperature
if [[ 1 -eq 1 ]]; then
  STORAGE_DEVICE_NAME="$(esxcli storage core device list | sed -rne "s/^\s+Other UIDs:\s+(.{1,80})$/\1/p" | head -n 1;)";
  # ---
  LOGDIR="/var/log/drive-temps";
  MAX_TEMP_FULLPATH="${LOGDIR}/max_temp";
  MIN_TEMP_FULLPATH="${LOGDIR}/min_temp";
  mkdir -p "${LOGDIR}";
  if [[ ! -f "${MAX_TEMP_FULLPATH}" ]]; then echo -n "0" > "${MAX_TEMP_FULLPATH}"; fi;
  if [[ ! -f "${MIN_TEMP_FULLPATH}" ]]; then echo -n "100" > "${MIN_TEMP_FULLPATH}"; fi;
  DEGREES_CELSIUS="$(echo -e "\\xC2\\xB0";)C";
  # ---
  while [[ 1 -eq 1 ]]; do
    clear; date; echo "";
    LATEST_DRIVE_TEMP_ROW="$(esxcli storage core device smart get --device-name="${STORAGE_DEVICE_NAME}" | grep '^Drive Temperature';)";
    LATEST_TEMP_BASE_VALUE="$(echo "${LATEST_DRIVE_TEMP_ROW}" | sed -rne "s/^Drive Temperature\s+([a-zA-Z0-9\/]+)\s+([a-zA-Z0-9\/]+)\s+([a-zA-Z0-9\/]+)\s+([a-zA-Z0-9\/]+)\s*$/\1/p";)";
    LATEST_TEMP_RAW_VALUE="$(echo "${LATEST_DRIVE_TEMP_ROW}" | sed -rne "s/^Drive Temperature\s+([a-zA-Z0-9\/]+)\s+([a-zA-Z0-9\/]+)\s+([a-zA-Z0-9\/]+)\s+([a-zA-Z0-9\/]+)\s*$/\4/p";)";
    # echo "LATEST_TEMP_BASE_VALUE = [ ${LATEST_TEMP_BASE_VALUE} ]";
    # echo "LATEST_TEMP_RAW_VALUE = [ ${LATEST_TEMP_RAW_VALUE} ]";
    if [[ -z "${LATEST_TEMP_RAW_VALUE}" ]] || [[ "${LATEST_TEMP_RAW_VALUE}" == "N/A" ]]; then
      CURRENT_TEMP="${LATEST_TEMP_BASE_VALUE}";
    else
      CURRENT_TEMP="${LATEST_TEMP_RAW_VALUE}";
    fi;
    # echo "CURRENT_TEMP = [ ${CURRENT_TEMP} ]";
    if [[ "${CURRENT_TEMP}" -gt "$(cat "${MAX_TEMP_FULLPATH}";)" ]]; then echo -n "${CURRENT_TEMP}" > "${MAX_TEMP_FULLPATH}"; fi;
    if [[ "${CURRENT_TEMP}" -lt "$(cat "${MIN_TEMP_FULLPATH}";)" ]]; then echo -n "${CURRENT_TEMP}" > "${MIN_TEMP_FULLPATH}"; fi;
    echo "CURRENT_TEMP  =  ${CURRENT_TEMP} ${DEGREES_CELSIUS}";
    echo "";
    echo "    MAX_TEMP  =  $(cat "${MAX_TEMP_FULLPATH}";) ${DEGREES_CELSIUS}";
    echo "";
    echo "    MIN_TEMP  =  $(cat "${MIN_TEMP_FULLPATH}";) ${DEGREES_CELSIUS}";
    echo "";
    sleep 5;
  done;
fi;


# ------------------------------
#
# Get S.M.A.R.T. disk values for all disks (if they exist)
#

if [[ 1 -eq 1 ]]; then
  esxcli storage core device list | sed -rne "s/^\s+Other UIDs:\s+(.{1,80})$/\1/p" | while read EACH_DEVICE_UUID; do
    EACH_DEVICE_MODEL="$(esxcli storage core device list --device="${EACH_DEVICE_UUID}" | sed -rne "s/^\s+Model:\s+(.+)$/\1/p" | sed -e "s/^[[:space:]]*//" -e "s/[[:space:]]*$//";)";
    echo "";
    echo "------------------------------";
    echo "";
    echo ">>> Device Model:  \"${EACH_DEVICE_MODEL}\"";
    echo "";
    echo ">>> Calling [ esxcli storage core device smart get --device-name=\"${EACH_DEVICE_UUID}\"; ]...";
    echo "";
    esxcli storage core device smart get --device-name="${EACH_DEVICE_UUID}";
    echo "";
    echo ">>> Calling [ esxcli storage core device stats get --device=\"${EACH_DEVICE_UUID}\"; ]...";
    echo "";
    esxcli storage core device stats get --device="${EACH_DEVICE_UUID}";
    echo "";
  done;
  esxcli nvme device list | sed -rne "s/^(vmhba[0-9]+) .*$/\1/p" | sed -e "s/^[[:space:]]*//" -e "s/[[:space:]]*$//" | while read EACH_ADAPTER_NAME; do
    echo "";
    echo "------------------------------";
    echo "";
    echo ">>> NVMe Adapter Name:  \"${EACH_ADAPTER_NAME}\"";
    echo "";
    echo ">>> Calling [ esxcli nvme device log smart get --adapter=\"${EACH_ADAPTER_NAME}\"; ]...";
    echo "";
    esxcli nvme device log smart get --adapter="${EACH_ADAPTER_NAME}";
    echo "";
  done;
  echo "------------------------------";
  echo "";
fi;


# ------------------------------------------------------------
#
# ESXi > Configure S.M.A.R.T. daemon poll-rate
#
#   ❌️ ⚠️ Doesn't work on ESXi v7.0+ hosts due to file privacy lockdowns on `/etc/init.d/smartd` (cannot be overwritten via `sed` or other action(s))

# Open the shellscript in the `vim` editor:
vi "/etc/rc.local.d/local.sh";

# Append the following onto the end of `/etc/rc.local.d/local.sh` just before any `exit ...` line(s):
# ---
# Poll the SMART daemon every 15 minutes (instead of the default of every 30)
SMARTD_POLL_INTERVAL=15
/etc/init.d/smartd stop;
/bin/sleep 2;
if [[ -f /var/run/vmware/smartd.PID ]] && [[ -z "$(/bin/ps | /bin/grep $(/bin/cat /var/run/vmware/smartd.PID;);)" ]]; then
/bin/rm -fv /var/run/vmware/smartd.PID; # Remove the PID file (dangling pointer)
fi;
/bin/sed -r "s/^(.+ -t \"\\\$\{MAX_RETRIES\}\" )(\"\\\$\{SMARTD\}\".+$)/\1-i ${SMARTD_POLL_INTERVAL:-15} \2/g" -i "/etc/init.d/smartd"; EXIT_CODE="${?}";
if [[ "${EXIT_CODE}" -ne 0 ]]; then
/bin/nohup /usr/sbin/smartd -i ${SMARTD_POLL_INTERVAL:-15} > "/tmp/nohup_smartd_$(date +'%Y%m%d%H%M%S').log" 2>&1 &
# while [ 1 ]; do clear; date; echo -e "\n\n"; cat /tmp/nohup_smartd_$(date +'%Y%m%d')*.log; sleep 1; done;
else
/etc/init.d/smartd start;
fi;
# ---
# Save and quit via `:wq` + `Enter`

# Pre-Check - Get the config & service status:
cat /etc/init.d/smartd; ps -c | grep smartd | grep -v grep;  # Show whole file, manually look for "MAX_RETRIES" line - DO NOT grep (for backup reference)

# Run the update for the S.M.A.R.T. daemon:
/etc/rc.local.d/local.sh;

# Post-Check - Verify the config was updated as-intended:
cat /etc/init.d/smartd; ps -c | grep smartd | grep -v grep;  # Show whole file, manually look for "MAX_RETRIES" line - DO NOT grep (for backup reference)


# ------------------------------------------------------------


if [[ 0 -eq 1 ]]; then
  #
  # Hotfix for if smartd's PID is an invalud value or points to a non-existent process (dangling pointer)
  #
  /etc/init.d/smartd stop;  # Stop the service
  cat /var/run/vmware/smartd.PID; # Find the process which is holding up smartd from working as intended
  ps | grep $(cat /var/run/vmware/smartd.PID;);  # No processes found
  rm -fv /var/run/vmware/smartd.PID;  # PID file is a dangling pointer --> remove it
  /etc/init.d/smartd start;  # Start the service
  /etc/init.d/smartd status;  # Check service status
fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   kb.vmware.com  |  "ESXi S.M.A.R.T. health monitoring for hard drives (2040405)"  |  https://kb.vmware.com/s/article/2040405
#
#   williamlam.com  |  "Quick Tip - smartd configurable polling interval in vSphere 6.0"  |  https://williamlam.com/2015/02/quick-tip-smartd-configurable-polling-interval-in-vsphere-6-0.html
#
# ------------------------------------------------------------