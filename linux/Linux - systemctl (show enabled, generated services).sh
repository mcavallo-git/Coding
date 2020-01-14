#!/bin/bash
#
# ------------------------------------------------------------
# List services enabled thru systemctl

systemctl list-unit-files --type service --state enabled,generated;

# ------------------------------------------------------------
# Check one service's status

SVC="nginx"; systemctl is-enabled "${SVC}.service"; systemctl is-active "${SVC}.service"; systemctl status "${SVC}.service";


# ------------------------------------------------------------
# Autostart on bootup (as well as right now)

SVC="nginx";
if \
	[ "$(systemctl is-enabled ${SVC}.service 2>/dev/null;)" != "enabled" ] || \
	[ "$(systemctl is-active ${SVC}.service 2>/dev/null;)" != "active" ] || \
	[ $(systemctl is-enabled ${SVC}.service 1>/dev/null 2>&1; echo $?;) -ne 0 ] || \
	[ $(systemctl is-active ${SVC}.service 1>/dev/null 2>&1; echo $?;) -ne 0 ]; \
then
	echo "Info:  Service \"${SVC}\" is not both \"enabled\" and \"active\", currently";
	echo "Info:  Calling  [ systemctl enable \"${SVC}.service\" --now; ]  ...";
	systemctl enable "${SVC}.service" --now; # "enable --now" autostarts service at bootup && starts service immediately
fi;


# ------------------------------------------------------------
# Get the name of the local network service

/bin/systemctl list-unit-files | grep -i '^network' | grep -v '\-' | grep '.service' | awk '{print $1}' | sed -e 's/.service//' | head -n 1;


# ------------------------------------------------------------
# 
# Show startup config/options for a given service
# 

SERVICE_NAME="mongod"; cat "/lib/systemd/system/${SERVICE_NAME}.service";


# ------------------------------------------------------------
# Citation(s)
#
#   askubuntu.com  |  "systemd - How to list all enabled services from systemctl? - Ask Ubuntu"  |  https://askubuntu.com/a/1060852
#
#   askubuntu.com  |  "systemd - What is the difference between "systemctl start" and "systemctl enable"? - Ask Ubuntu"  |  https://askubuntu.com/a/733510
#
# ------------------------------------------------------------