#!/bin/sh
# ------------------------------------------------------------
# Linux - timezone (get, set time zone, localtime, tz, timedatectl)
# ------------------------------------------------------------
#
# Get time zone via "/etc/localtime" (symbolic link)
#

# Get time zone for current device
realpath '/etc/localtime' | sed -e 's|/usr/share/zoneinfo/||g';

# Get time zone for current device (as a variable)
GET_TZ="$(realpath '/etc/localtime' | sed -e 's|/usr/share/zoneinfo/||g';)";
echo "GET_TZ = \"${GET_TZ}\"";


# ------------------------------------------------------------
#
# Get time zone via  "/etc/timezone"
#

# Get time zone for current device
cat '/etc/timezone';

# Get time zone for current device (as a variable) - Strip whitespace & blank lines
GET_TZ="$(cat '/etc/timezone' | sed -e "s/^[[:space:]]*//" -e "s/[[:space:]]*$//" -e "/^\s*$/d";)";
echo "GET_TZ = \"${GET_TZ}\"";


# ------------------------------------------------------------
#
# Set time zone for target device
#

if [[ 1 -eq 1 ]]; then
  # Debian/RHEL Linux distros
  SET_TZ="America/New_York";
  ln -snf "/usr/share/zoneinfo/${SET_TZ}" '/etc/localtime';
  echo -n "${SET_TZ}" > "/etc/timezone";
  if [[ -n "$(command -v timedatectl 2>'/dev/null';)" ]]; then
    timedatectl set-timezone "${SET_TZ}";
  fi;
fi;


if [[ 1 -eq 1 ]]; then
  # Same as above but using sed (to avoid output redirection (">"))
  SET_TZ="America/New_York";
  SET_TZ_REGEX_ESCAPED="$(echo "${SET_TZ}" | sed 's/\//\\\//g';)";
  ln -snf "/usr/share/zoneinfo/${SET_TZ}" '/etc/localtime';
  sed -re "s/^.+$/${TZ_REGEX_ESCAPED}/g" -i '/etc/timezone';
  if [[ -n "$(command -v timedatectl 2>'/dev/null';)" ]]; then
    timedatectl set-timezone "${SET_TZ}";
  fi;
fi;


if [[ 0 -eq 1 ]]; then
  # Alpine Linux distros
  SET_TZ="UTC+4";
  ln -snf "/usr/share/zoneinfo/${SET_TZ}" '/etc/localtime';
  echo "${SET_TZ}" > "/etc/TZ";
fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.tecmint.com  |  "How to Check Timezone in Linux"  |  https://www.tecmint.com/check-linux-timezone/
#
# ------------------------------------------------------------