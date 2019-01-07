#!/bin/sh

# Find latest firmware @ https://www.ubnt.com/download/unifi/

STATIC_PKG_NAME="unifi_sysvinit_all.deb"

MOST_RECENT_VERSION="5.9.29";

URL_UPDATE="https://dl.ubnt.com/unifi/${MOST_RECENT_VERSION}/${STATIC_PKG_NAME}"

cd "/tmp/";

wget "${URL_UPDATE}";

sudo dpkg -i "${STATIC_PKG_NAME}"

apt -y update;

apt -f -y install;

# apt -y upgrade;

