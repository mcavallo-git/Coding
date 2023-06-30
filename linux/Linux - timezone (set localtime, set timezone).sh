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
# Set Time Zone ("/etc/localtime" && "/etc/timezone") for current device:

if [[ 1 -eq 1 ]]; then
  ## Debian/RHEL Linux distros
  SET_TZ="America/New_York";
  ln -snf "/usr/share/zoneinfo/${SET_TZ}" "/etc/localtime";
  echo -n "${SET_TZ}"; > "/etc/timezone";
  timedatectl set-timezone "${SET_TZ}";
fi;

## Alpine Linux distros
if [[ 0 -eq 1 ]]; then
SET_TZ="UTC+4";
ln -snf "/usr/share/zoneinfo/${SET_TZ}" "/etc/localtime";
echo "${SET_TZ}" > "/etc/TZ";
fi;

# ------------------------------------------------------------