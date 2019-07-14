#!/bin/bash

# Base-directory
THIS_DIR="$(pwd)"
LOGS_DIR="${THIS_DIR}/log_fw" && mkdir -p "${LOGS_DIR}"
LOGFILE="${LOGS_DIR}/log_fw_$(date +'%Y%m%d')"
THIS_SCRIPT=$(basename "${0}")
RUN=/opt/vyatta/bin/vyatta-op-cmd-wrapper

# Requirement lookalike for tarfile
FIRMWARE_FILENAME_REQUIREMENT_1="ER-e100"
FIRMWARE_FILENAME_REQUIREMENT_2=".tar"

# Setup Auto-Logging (via "exec" commands) for this script
exec > >(tee -a "${LOGFILE}" )
exec 2>&1

# Welcome the User
echo "Starting ${THIS_SCRIPT} as user (whoami) [$(whoami)]   -   $(date +'%D  %r')"

# Show Version Info
echo "System Version is Currently: " && $RUN show version

# Grab the URL passed either in-line with this script, or manually from the user
if [ "$#" -ne 1 ]; then
  # Default to asking the user for parameter 1
  echo && echo "URL Required (to Download Firmware Upgrade from)"
	echo "Visit Ubuntu's Site for a Download URL:"
	echo "   https://www.ubnt.com/download/edgemax/edgerouter-lite/erlite3"
	printf "\nEnter URL: " && read FIRMWARE_URL && printf "\n\n"
else 
	# Use parameter #1 passed in-line to this script
	FIRMWARE_URL=$1;
fi

# Check if URL exists --- If URL Exists, $? is set to 0, otherwise $? is set to 1
curl -s --head "${FIRMWARE_URL}" | head -n 1 | grep "HTTP/1.[01] [23].." > /dev/null
if [ "$?" = "0" ]; then
	# Report if URL exists & continue script
	echo "✓ URL Exists: [${FIRMWARE_URL}]"
	echo "Downloading now..."
	curl -OJ "${FIRMWARE_URL}"
else
	# Exit out if URL does not exist
	echo "✕ URL does not exist: [${FIRMWARE_URL}]"
	echo -e "Exiting ${THIS_SCRIPT}   -   $(date +'%D  %r')\n"
	exit 0
fi

# Check if file exists
tars_found="$(($(ls -Artl | grep '.tar' | awk '{print $9}' | wc -l)))"
if [ ${tars_found} -gt 0 ]; then
	
  NEWEST_TAR="$(ls -Artl | grep '.tar' | awk '{print $9}' | tail -n 1)"
	echo "✓ Tarfile being used: [${NEWEST_TAR}]"

	# Make sure that the file meets filename requirement(s)
	FILENAME_TEST_1=$(($(printf "${NEWEST_TAR}" | grep "${FIRMWARE_FILENAME_REQUIREMENT_1}" | wc -l)))
	if [ "${FILENAME_TEST_1}" = "1" ]; then
		echo "✓ Requirement-1 Passed: \"${FIRMWARE_FILENAME_REQUIREMENT_1}\" found in \"${NEWEST_TAR}\""
	else
		echo "✕ Requirement-1 Failed"
		echo "   GREP_TEST_1=[${GREP_TEST_1}]"
		echo "✕ Requirement-1 Failed: \"${FIRMWARE_FILENAME_REQUIREMENT_1}\" not found in \"${NEWEST_TAR}\""
		echo -e "Exiting ${THIS_SCRIPT}   -   $(date +'%D  %r')\n"
		exit 0
	fi
	# Make sure that the file meets filename requirement(s)
	FILENAME_TEST_2=$(($(printf "${NEWEST_TAR}" | grep "${FIRMWARE_FILENAME_REQUIREMENT_2}" | wc -l)))
	if [ "${FILENAME_TEST_2}" = "1" ]; then
		echo "✓ Requirement-2 Passed: \"${FIRMWARE_FILENAME_REQUIREMENT_2}\" found in \"${NEWEST_TAR}\""
	else
		echo "✕ Requirement-2 Failed: \"${FIRMWARE_FILENAME_REQUIREMENT_2}\" not found in \"${NEWEST_TAR}\""
		echo -e "Exiting ${THIS_SCRIPT}   -   $(date +'%D  %r')\n"
		exit 0
	fi

	# Filename is valid, continue with updating the system
	printf "\nType \"1\" to Confirm the Firmware Upgrade: " && read USER_ACCEPTS_IF_1 && printf "\n"

	if [ "${USER_ACCEPTS_IF_1}" = "1" ]; then

		# User typed "1" - attempt to perform the Firmware Upgrade
		echo "✓ Acceptance entered. Performing Firmware Upgrade Using File: ${NEWEST_TAR}"
		$RUN add system image "${NEWEST_TAR}"
		# The Shell will overwrite the Logfile & we need to re-instantiate the connection to it
		exec > >(tee -a "${LOGFILE}" )
		exec 2>&1
		echo "✓ Firmware Image Applied (pending Reboot)"
		
		# Cleanup old .tar file
		echo "" && echo "Removing .tar file..." && rm -f "${NEWEST_TAR}" && echo "✓ Removed .tar File (already applied)"
		
		# Reboot the system 
		echo "" && echo "✓ Rebooting to Complete the Firmware Upgrade   -   $(date +'%D  %r')  " && sudo reboot
		exit 0
		
	else
		# Exit out if User didn't type "1"
		echo "✕ Acceptance declined (User Entered \"${USER_ACCEPTS_IF_1}\" instead of \"1\")"
		echo -e "Exiting ${THIS_SCRIPT}   -   $(date +'%D  %r')\n"
		exit 0
	fi;

else
	# If no archives are found, log it
	echo "✕ No .tar file(s) found"
	echo -e "Exiting ${THIS_SCRIPT}   -   $(date +'%D  %r')\n"
	exit 0;
fi

# Exit Gracefully
echo -e "Exiting ${THIS_SCRIPT}   -   $(date +'%D  %r')\n"
exit 0;

#
# Version 2.0.1  :::  Released 2019-03-29  :::  ./edgerouter_fw_upgrader.sh "https://dl.ubnt.com/firmwares/edgemax/v2.0.x/ER-e100.v2.0.1.5174691.tar"
#
