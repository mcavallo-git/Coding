#!/bin/bash

# ------------------------------------------------------------

read -p "Press any key to continue...  " -n 1 -t 60 -r; # Await single keypress

# ------------------------------------------------------------

READ_TIMEOUT=60;
read -p "Enter a string:  " -t ${READ_TIMEOUT} -r; RETURN_CODE_READ=$?;

echo "";
if [ ${RETURN_CODE_READ} -gt 128 ]; then
	echo -e "Response timed out after ${READ_TIMEOUT}s";
elif [ -z "${REPLY}" ]; then
	echo "Response's string-length is zero (empty/unset)";
else
	echo "Response received: \"${REPLY}\"";
fi;

# ------------------------------------------------------------

READ_TIMEOUT=60;
read -p "Perform action [ xyz ], now? (y/n)  " -n 1 -t 60 -r; RETURN_CODE_READ=$?;
echo "";
if [ ${RETURN_CODE_READ} -gt 128 ]; then
	echo -e "Response timed out after ${READ_TIMEOUT}s";
elif [ -z "${REPLY}" ] && [[ $REPLY =~ ^[Yy]$ ]]; then
	echo "Confirmed - Performing Action [ xyz ] ...";
else
	echo "Denied - Skipping action [ xyz ]";
fi;

# ------------------------------------------------------------
