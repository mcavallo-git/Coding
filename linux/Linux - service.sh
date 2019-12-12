#!/bin/bash



# Grab all services into a variable (requires 'sed' package)
ALL_SERVICES=$(service --status-all 2>/dev/null | sed --regexp-extended --quiet --expression='s/^\ \[ (\+|\-) \]\ \ (\S+)$/\2/p');
echo "${ALL_SERVICES}";



# Check if one, specific service exists, locally (requires 'sed' package)
SERVICE_NAME="sshd";
SERVICE_RET_CODE=$(/bin/systemctl status "${SERVICE_NAME}" --no-pager --full 1>'/dev/null' 2>&1; echo $?;);
if [ ${SERVICE_RET_CODE} -eq 0 ]; then
	echo "Service \"${SERVICE_NAME}\" DOES exist as a local service";
else
	echo "Service \"${SERVICE_NAME}\" does NOT exist as a local service";
fi;


