#!/bin/sh

# ------------------------------------------------------------
#
#   Change the value of wifi.powersave ( located in "/etc/NetworkManager/conf.d/default-wifi-powersave-on.conf" ) from 3 (enabled) to 2 (disabled)
# 

if [ -e "/etc/NetworkManager/conf.d/default-wifi-powersave-on.conf" ]; then
sed -i".$(date +'%Y%m%d_%H%M%S').bak" -e "/^wifi.powersave/c\wifi.powersave = 2" "/etc/NetworkManager/conf.d/default-wifi-powersave-on.conf";
fi;


# ------------------------------------------------------------

### Wi-Fi Disabler 24/7
### Add the following line of code to [ root ]'s cron-jobs (scheduled events) via [ crontab -e ]
@reboot ifdown wlan0

### Show Network Interfaces
# ifconfig -s | grep wlan
# iwconfig


# ------------------------------------------------------------
#
# Citation(s)
#
#   itectec.com  |  "Ubuntu – Disable wifi power management – iTecTec"  |  https://itectec.com/ubuntu/ubuntu-disable-wifi-power-management/
#
# ------------------------------------------------------------