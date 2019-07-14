#!/bin/sh
#
# Latest installs @ https://www.ubnt.com/download/unifi/
#
# Script requires to run as sudoer (root)
#
if [ "$(whoami)" != "root" ]; then
	echo -e "\Fail - Must run ${0} as user 'roor'.\nExiting after 60s...";
	sleep 60;
	exit 1;
fi;
#
#
# ---------------------------------------------------------------------------------------------------------------------------------- #
#
#
# if [ "$(which unifi)" == "" ]; then
if [ "1" == "2" ]; then
	#
	#	Install the 'unifi' package
	#
	UNIFI_INSTALL_VERSION="5.10.20";
	UNIFI_INSTALL_SCRIPT="https://get.glennr.nl/unifi/5.10.20/D8/unifi-5.10.20.sh"; # Unifi v5.10.20, Debian 8 (Raspi 3)
	#
	apt-get -y install ca-certificates;
	wget "${UNIFI_INSTALL_SCRIPT}";
	chmod 0700 $(basename "${UNIFI_INSTALL_SCRIPT}");
	./$(basename "${UNIFI_INSTALL_SCRIPT}");
	#
else
	#
	#	Update the 'unifi' package
	#
	UNIFI_UPDATE_SCRIPT="https://get.glennr.nl/unifi/update/unifi-update.sh"; 
	apt-get -y install ca-certificates;
	wget "${UNIFI_UPDATE_SCRIPT}";
	chmod 0700 $(basename "${UNIFI_UPDATE_SCRIPT}");
	./$(basename "${UNIFI_UPDATE_SCRIPT}");
	#
fi;
#
#
# ---------------------------------------------------------------------------------------------------------------------------------- #
#
#	Citation(s)
#
# 	Thanks to user 'AmazedMender16' (on the community.ubnt.com foums) or his awesome Unifi install & update scripts
# 		--> https://community.ubnt.com/t5/UniFi-Wireless/UniFi-Installation-Scripts-UniFi-Easy-Update-Scripts-Ubuntu-18/td-p/2375150
#
# ---------------------------------------------------------------------------------------------------------------------------------- #