#!/bin/bash

# ------------------------------------------------------------
#
#   ENABLE STARTUP SERVICE + START IMMEDIATELY
#

SVC="nginx";
if \
  [ "$(systemctl is-enabled ${SVC}.service 2>'/dev/null';)" != "enabled" ] || \
  [ "$(systemctl is-active ${SVC}.service 2>'/dev/null';)" != "active" ] || \
  [ $(systemctl is-enabled ${SVC}.service 1>'/dev/null' 2>&1; echo $?;) -ne 0 ] || \
  [ $(systemctl is-active ${SVC}.service 1>'/dev/null' 2>&1; echo $?;) -ne 0 ]; \
then
  echo "Info:  Service \"${SVC}\" is not both \"enabled\" and \"active\", currently";
  echo "Info:  Calling  [ systemctl enable \"${SVC}.service\" --now; ]  ...";
  systemctl enable "${SVC}.service" --now; # "enable --now" autostarts service at bootup && starts service immediately
fi;


# ------------------------------------------------------------
#
#   DISABLE STARTUP SERVICE + STOP IMMEDIATELY
#

SVC="nginx";
if \
  [ "$(systemctl is-enabled ${SVC}.service 2>'/dev/null';)" == "enabled" ] || \
  [ "$(systemctl is-active ${SVC}.service 2>'/dev/null';)" == "active" ]; \
then
  echo "Info:  Service \"${SVC}\" is either \"enabled\" or \"active\", currently";
  echo "Info:  Calling  [ systemctl disable \"${SVC}.service\" --now; ]  ...";
  systemctl disable "${SVC}.service" --now; # "disable --now" removes service from startup services & stops service immediately
fi;


# ------------------------------------------------------------
# GET SERVICE STATUS

SVC="nginx"; systemctl is-enabled "${SVC}.service"; systemctl is-active "${SVC}.service"; systemctl status "${SVC}.service";


# ------------------------------------------------------------
# 
# GET SERVICE STARTUP CONFIG/OPTIONS
# 

SERVICE_NAME="nginx"; cat "/lib/systemd/system/${SERVICE_NAME}.service";


# ------------------------------------------------------------
# List services enabled thru systemctl

systemctl list-unit-files --type service --state enabled,generated;


# ------------------------------------------------------------
# Get the name of the local network service

/bin/systemctl list-unit-files | grep -i '^network' | grep -v '\-' | grep '.service' | awk '{print $1}' | sed -e 's/.service//' | head -n 1;


# ------------------------------------------------------------
#
# Citation(s)
#
#   askubuntu.com  |  "systemd - How to list all enabled services from systemctl? - Ask Ubuntu"  |  https://askubuntu.com/a/1060852
#
#   askubuntu.com  |  "systemd - What is the difference between "systemctl start" and "systemctl enable"? - Ask Ubuntu"  |  https://askubuntu.com/a/733510
#
#   askubuntu.com  |  "Difference between systemctl and service commands - Ask Ubuntu"  |  https://askubuntu.com/a/903405
#
#   www.reddit.com  |  "What is the relation between update-rc.d and systemctl : linuxquestions"  |  https://www.reddit.com/r/linuxquestions/comments/4sw5dr/what_is_the_relation_between_updatercd_and/
#
# ------------------------------------------------------------