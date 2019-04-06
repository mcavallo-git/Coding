#!/bin/sh
#
# Latest installs @ https://www.ubnt.com/download/unifi/
#
# Script requires to run as sudoer (root)
FAIL_MSG="";if [ "$(whoami)" != "root" ]; then
	FAIL_MSG="${FAIL_MSG} Must run ${0} as root-user.";
fi;

# fail-out if any startup errors were found
if [ -n "${FAIL_MSG}" ]; then
	echo -e "\nERROR: Must run ${0} as root-user. Exiting...";
	exit 1;
fi;

if [ "$(whoami)" != "root" ]; then

	echo

fi;


STATIC_PKG_NAME="unifi_sysvinit_all.deb";

cd "/tmp/";

sudo dpkg -i "${STATIC_PKG_NAME}";





apt-get -y update;

echo "unifi unifi/has_backup boolean true" | debconf-set-selections

DEBIAN_FRONTEND=noninteractive apt-get install --only-upgrade unifi && service unifi restart
