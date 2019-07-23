#!/bin/bash



# Grab all services into a variable (requires 'sed' package)
ALL_SERVICES=$(service --status-all 2>/dev/null | sed --regexp-extended --quiet --expression='s/^\ \[ (\+|\-) \]\ \ (\S+)$/\2/p');
echo "${ALL_SERVICES}";



# Check if one, specific service exists, locally (requires 'sed' package)
SERVICE_NAME="nginx";
SERVICE_MATCHES="$(service --status-all 2>/dev/null | sed --regexp-extended --quiet --expression='s/^\ \[ (\+|\-) \]\ \ ('${SERVICE_NAME}')$/\2/p')";
if [ "${SERVICE_NAME}" == "${SERVICE_MATCHES}" ]; then
	echo "Service \"${SERVICE_NAME}\" DOES exist as a local service";
else
	echo "Service \"${SERVICE_NAME}\" does NOT exist as a local service";
fi;


