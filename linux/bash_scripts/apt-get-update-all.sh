#!/bin/bash
#
# Ubuntu - Fetch, Pull, & Install updates (system & package)
#
# Create/Edit this script:    APT_UPDATER="/root/apt-get-update-all.sh" && sudo vi "${APT_UPDATER}" && sudo ln -sf "${APT_UPDATER}" /update_now;
#
# Execute/Run this script:    /update_now;
#

if [ "$(date +%u)" == "0" ] || [ "${0}" == "/update_now" ]; then

	# Setup Logging
	START_TIMESTAMP="$(date +'%Y%m%d_%H%M%S')";
	THIS_SCRIPT=$(basename "${0}");
	THIS_DIRNAME=$(dirname "${0}");
	LOGFILE_BASENAME="apt_update_${START_TIMESTAMP}.log";
	LOGFILE_DIRNAME="/root/apt_update_logs";
	LOGFILE_FULLPATH="${LOGFILE_DIRNAME}/${LOGFILE_BASENAME}";

	# Make sure that Logfile directory exists
	mkdir -p "${LOGFILE_DIRNAME}";
	chmod 0700 "${LOGFILE_DIRNAME}";

	echo " " > "${LOGFILE_FULLPATH}" && \
	chmod 0600 "${LOGFILE_FULLPATH}";

	# Log shell & error output to logfile
	exec > >(tee -a "${LOGFILE_FULLPATH}" );
	exec 2>&1;

	echo "# ------------------------------------------------------------- #";
	
	echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Starting \"${THIS_SCRIPT}\"\n";

	echo "# ------------------------------------------------------------- #";

	comm="apt-get"; 
	if [ -z "$(which $comm)" ]; then
		echo "Command \"$comm\" not found";
	else
		echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Command \"$comm\" resolved to $(which $comm)";

		echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo $comm list --upgradable";
		sudo $comm list --upgradable;

		echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo $comm -y update";
		sudo $comm -y update;

		echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo $comm -y dist-upgrade";
		sudo $comm -y dist-upgrade;

		echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo $comm -y autoremove";
		sudo $comm -y autoremove;
		
		echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo $comm -y clean";
		sudo $comm -y clean;
	fi;

	echo "# ------------------------------------------------------------- #";

	comm="yum";
	if [ -z "$(which $comm)" ]; then
		echo "Command \"$comm\" not found";
	else
		echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Command \"$comm\" resolved to $(which $comm)";

		echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo $comm list --upgradable";
		sudo $comm check-update;

		echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo $comm -y update";
		sudo $comm -y update;

		echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo $comm -y update";
		sudo $comm -y upgrade;
		
		# echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo $comm -y autoremove";
		# sudo $comm -y autoremove;
		
		# echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo $comm -y clean";
		# sudo $comm -y clean;
	fi;

	echo "# ------------------------------------------------------------- #";

	comm="updatedb";
	if [ -z "$(which $comm)" ]; then
		echo "Command \"$comm\" not found";
	else
		echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Command \"$comm\" resolved to $(which $comm)";
		echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo $comm";
		sudo $comm;
	fi;

	echo "# ------------------------------------------------------------- #";

	comm="ldconfig";

	if [ -z "$(which $comm)" ]; then
		echo "Command \"$comm\" not found";
	else
		echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Command \"$comm\" resolved to $(which $comm)";
		echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo $comm";
		sudo $comm;
	fi;

	echo "# ------------------------------------------------------------- #";

	comm="pip";
	if [ "skip $comm" == "skip $comm" ]; then
			echo "Skipping \"$comm\"";
	else 
		if [ -z "$(which $comm)" ]; then
			echo "Command \"$comm\" not found";
		else
			echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Command \"$comm\" resolved to $(which $comm)";

			echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo $comm install --upgrade $comm;";
			sudo $comm install --upgrade $comm;
			
			# Update pip modules - 'newer' version of pip (version??)
			echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo $comm freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 sudo -H $comm install -U;";
			sudo $comm list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo -H $comm install -U;

			# Update pip modules - 'older' version of pip (version??)
			echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo $comm freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo -H $comm install -U;";
			sudo $comm freeze --local | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 sudo -H $comm install -U;
		fi;
	fi;

	echo "# ------------------------------------------------------------- #";

	UBUNTU_REBOOT_REQUIRED_IF_EXISTS="/var/run/reboot-required";
	if [ -f "${UBUNTU_REBOOT_REQUIRED_IF_EXISTS}" ]; then

		# The File '/var/run/reboot-required' is an Ubuntu native, and signifies that at least one recent update requires a reboot to fully complete their install/update.
		# If we find that ^ file on our current host (after running updates), then the system is in the reboot preparation phase -> set it just to restart after 2 minutes
		echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   REBOOT REQUIRED TO FINALIZE ONE OR MORE UPDATES - SETTING A RESTART FOR 2 MINUTES FROM NOW";

		# Schedule the system restart/reboot (NOT reset)
		SCHEDULED_RESTART_TIME=$(date -d "$(date +%H):$(date +%M) 2 minutes" +'%H:%M');
		echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo shutdown -r \"${SCHEDULED_RESTART_TIME}\"";
		sudo shutdown -r "${SCHEDULED_RESTART_TIME}";

	fi;

	# Pretty-Print exit msg
	echo -e "\n ($(date '+%Y-%m-%d %H:%M:%S'))   Finished \"${THIS_SCRIPT}\"\n";
	
	echo "# ------------------------------------------------------------- #";


fi;

# Exit Gracefully
exit 0;

# WSL (Windows Subsystem for Linux)
# !! To shutdown WSL, manually create above file via [sudo touch /var/run/reboot-required], when closing terminals,
# !! otherwise the linux environment persists the background as a service (essentially hidden)
#
# > sudo touch /var/run/reboot-required
