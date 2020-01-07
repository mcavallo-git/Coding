#!/bin/bash

# Get a list of Enabled services
systemctl list-unit-files | grep '\.service' | grep 'enabled' | sort


# systemctl error while attempting to restart the network service: "Failed to start LSB: Bring up/down networking."
systemctl stop NetworkManager; \
systemctl disable NetworkManager; \

# 1. Remove the file
SystemdNetworkPath="$(find /etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service 2>/dev/null;)";
if [ -z "${SystemdNetworkPath}" ]; then
	SystemdNetworkPath="$(find /etc/systemd/system/dbus-org.freedesktop* 2>/dev/null;)";


fi;
rm -f "/usr/share/dbus-1/system-services/org.freedesktop.NetworkManager.service";

# 2. Comment this line from "/usr/lib/systemd/system/NetworkManager.service";
SystemdNetworkPath="$(find /etc/systemd/system/dbus-org.freedesktop* 2>/dev/null;)"; echo $SystemdNetworkPath;
sed -i".$(date +'%Y%m%d_%H%M%S').bak" -e '/^Alias=dbus-org\.freedesktop\/ s/^#*/#/' "/etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service"; \
sed -i".$(date +'%Y%m%d_%H%M%S').bak" -e '/^Alias=dbus-org\.freedesktop\/ s/^#*/#/' "/usr/lib/systemd/system/NetworkManager-dispatcher.service"; \

# 3.Remove this symlink:
unlink "/etc/systemd/system/dbus-org.freedesktop.NetworkManager.service"


# ------------------------------------------------------------
# Citation(s)
#
#   bbs.archlinux.org |  "[SOLVED] NetworkManager auto restart even though I stop it. / Networking, Server, and Protection / Arch Linux Forums"  |  https://bbs.archlinux.org/viewtopic.php?pid=1207260#p1207260
#
#   unix.stackexchange.com |  "Centos 7: failed to bring up/down networking: configure interface for a trunk interface"  |  https://unix.stackexchange.com/a/220961
#
# ------------------------------------------------------------