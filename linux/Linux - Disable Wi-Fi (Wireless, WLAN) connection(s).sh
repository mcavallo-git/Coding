#!/bin/sh


if [ -e "/etc/NetworkManager/conf.d/default-wifi-powersave-on.conf" ]; then
	# Change the value of wifi.powersave ( located in "/etc/NetworkManager/conf.d/default-wifi-powersave-on.conf" ) from 3 (enabled) to 2 (disabled)
  sed -i".$(date +'%Y%m%d_%H%M%S').bak" -e "/^wifi.powersave/c\wifi.powersave = 2" "/etc/NetworkManager/conf.d/default-wifi-powersave-on.conf";
  if [ $(which iwconfig 2>'/dev/null' | wc -l;) -le 0 ]; then
    apt-get update -y;
    apt-get install -y wireless-tools;
  fi;
  iwconfig wlan0 txpower off;
else
	echo "Add the following line of code to [ root ]'s cron-jobs (scheduled events) via [ crontab -e ]:"
	echo "";
	echo "@reboot ifdown wlan0";
	echo "";
fi;
echo "Reboot and verify wlan is disabled using:";
echo "";
echo "ifconfig -s | grep wlan;  # Show Network Interfaces ";
echo "iwconfig;  # Show Network Interfaces";
echo "";



# ------------------------------------------------------------
#
# Citation(s)
#
#   itectec.com  |  "Ubuntu – Disable wifi power management – iTecTec"  |  https://itectec.com/ubuntu/ubuntu-disable-wifi-power-management/
#
# ------------------------------------------------------------