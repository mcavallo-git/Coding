# ------------------------------------------------------------
# Linux - smartctl (get disk SMART (S.M.A.R.T.) values, remaining disk life, wear leveling count)
# ------------------------------------------------------------

# Install smartctl
sudo apt-get -y update;
sudo apt-get -y install smartmontools;

# Get the version of local smartctl install
smartctl --version | head --lines=1;


# ------------------------------------------------------------

# Get attached disk(s)
fdisk -l | grep -i 'sectors$' | grep -i '^disk' | grep -v '/dev/loop';  # Ignore '/dev/loop*' (Ubuntu Snap) mounted images


# ------------------------------------------------------------
#
# Get S.M.A.R.T. data from disk
#

if [[ 1 -eq 1 ]]; then
  #
  # Ensure SMART support is enabled on target disk
  #
  FIRST_DISK="$(fdisk -l | grep -i 'sectors$' | grep -i '^disk' | grep -v '/dev/loop' | awk '{print $2}' | tr -d ':' | head -n 1;)";
  TARGET_DISK="${TARGET_DISK:-${FIRST_DISK:-"/dev/sda"}}";
  SMART_SUPPORT="$(smartctl --info "${TARGET_DISK}" | grep -i 'SMART support is:';)";
  # If SMART support is available but is currently disabled...
  if [[ -n "$(echo "${SMART_SUPPORT}" | grep -i 'Disabled';)" ]] && [[ -n "$(echo "${SMART_SUPPORT}" | grep -i 'Available';)" ]]; then
    # Enable SMART support on target disk
    echo "Info: Enabling SMART support for disk \"${TARGET_DISK}\"...";
    smartctl --smart=on "${TARGET_DISK}";
  else
    echo "Info: (Skipped) SMART support is already enabled for disk \"${TARGET_DISK}\"";
  fi;
  # ------------------------------
  #
  # Get SMART data from disk
  #
  if [[ "${VERBOSE}" != "1" ]]; then
    smartctl --attributes --info "${TARGET_DISK}";
    #
    #   -i, --info
    #          Prints the device model number, serial number, firmware version, and ATA Standard version/revision information.
    #          Says if the device supports SMART, and if so, whether SMART support is currently enabled or disabled.
    #          If the device supports Logical Block Address mode (LBA mode) print current user drive capacity in bytes.
    #
    #   -A, --attributes
    #          [ATA] Prints only the vendor specific SMART Attributes.
    #
  else
    smartctl --all "${TARGET_DISK}";
    #
    #   -a, --all
    #          Prints all SMART information about the disk, or TapeAlert information about the tape drive or changer.
    #
  fi;
fi;



# ------------------------------------------------------------
#
# Citation(s)
#
#   askubuntu.com  |  "loop device - What is /dev/loopx? - Ask Ubuntu"  |  https://askubuntu.com/a/906685
#
#   superuser.com  |  "smart - Samsung SSD "Wear_Leveling_Count" meaning - Super User"  |  https://superuser.com/a/1615974
#
# ------------------------------------------------------------