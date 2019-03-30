#!/bin/bash

### Wi-Fi Disabler 24/7
### Add the following line of code to [ root ]'s cron-jobs (scheduled events) via [ crontab -e ]
@reboot ifdown wlan0

### Show Network Interfaces
# ifconfig -s | grep wlan
# iwconfig
