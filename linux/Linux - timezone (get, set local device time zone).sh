#!/bin/sh
# ------------------------------------------------------------
# Linux - timezone (set localtime, set timezone)
# ------------------------------------------------------------
#
# Get Time Zone via  "/etc/timezone"
#

# Get Time Zone for current device
cat '/etc/timezone';

# Get Time Zone for current device (as a variable)
TZ="$(cat '/etc/timezone')";


# ------------------------------------------------------------
#
# Get Time Zone via "/etc/localtime" (symbolic link)
#

# Get Time Zone for current device
realpath '/etc/localtime' | sed -e 's|/usr/share/zoneinfo/||g';

# Get Time Zone for current device (as a variable)
TZ="$(realpath '/etc/localtime' | sed -e 's|/usr/share/zoneinfo/||g';)";


# ------------------------------------------------------------
#
# Set Time Zone for current device

if [[ 1 -eq 1 ]]; then
  # Debian/RHEL Linux distros
  SET_TZ="America/New_York";
  ln -snf "/usr/share/zoneinfo/${SET_TZ}" "/etc/localtime";
  echo -n "${SET_TZ}"; > "/etc/timezone";
  timedatectl set-timezone "${SET_TZ}";
fi;


if [[ 0 -eq 1 ]]; then
  # Alpine Linux distros
  SET_TZ="UTC+4";
  ln -snf "/usr/share/zoneinfo/${SET_TZ}" "/etc/localtime";
  echo "${SET_TZ}" > "/etc/TZ";
fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.tecmint.com  |  "How to Check Timezone in Linux"  |  https://www.tecmint.com/check-linux-timezone/
#
# ------------------------------------------------------------