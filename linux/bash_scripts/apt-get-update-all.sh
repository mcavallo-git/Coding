#!/bin/bash
#
# Ubuntu - Fetch, Pull, & Install updates (system & package)
#
# Create/Edit this script:    APT_UPDATER="/root/apt-get-update-all.sh" && sudo vi "${APT_UPDATER}" && sudo ln -sf "${APT_UPDATER}" /update_now;
#
# Execute/Run this script:    APT_UPDATER="/root/apt-get-update-all.sh" && sudo chmod 700 "${APT_UPDATER}" && sudo "${APT_UPDATER}";
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

	echo " " > "${LOGFILE_FULLPATH}" && \
	chmod 0600 "${LOGFILE_FULLPATH}";

	# Log shell & error output to logfile
	exec > >(tee -a "${LOGFILE_FULLPATH}" );
	exec 2>&1;

	echo "===== ------------------------------------------------------------ =====";
	echo "";
	echo " ($(date '+%Y-%m-%d %H:%M:%S'))   Starting \"${THIS_SCRIPT}\"";

	echo "";
	echo " ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo apt list --upgradable";
	sudo apt list --upgradable;

	echo "";
	echo " ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo apt -y update";
	sudo apt -y update;

	echo "";
	echo " ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo apt -y dist-upgrade";
	sudo apt -y dist-upgrade;


	echo "";
	echo " ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo apt -y --autoremove";
	sudo apt -y autoremove;

	echo "";
	echo " ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo apt -y --clean";
	sudo apt -y clean;

	echo "";
	echo " ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo updatedb";
	sudo updatedb;

	echo "";
	echo " ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo ldconfig";
	sudo ldconfig;

	# echo "";
	# echo " ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo python -m pip install --upgrade pip;";
	# sudo python -m pip install --upgrade pip;

	# echo "";
	# echo " ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo pip list --outdated;";
	# sudo pip list --outdated;

	# echo "";
	# echo " ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > sudo pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U;";
	# sudo pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U;

	UBUNTU_REBOOT_REQD_IF_EXISTS="/var/run/reboot-required";
	if [ -f "${UBUNTU_REBOOT_REQD_IF_EXISTS}" ]; then
		# The File '/var/run/reboot-required' is an Ubuntu native, and signifies that at least one recent update requires a reboot to fully complete their install/update.
		# If we find that ^ file on our current host (after running updates), then the system is in the reboot preparation phase -> set it just to restart after 2 minutes
		echo "";
		echo " ($(date '+%Y-%m-%d %H:%M:%S'))   REBOOT REQUIRED TO FINALIZE AT LEAST ONE UPDATE - SETTING A RESTART FOR 2 MINUTES FROM NOW";

		# Schedule the system restart/reboot (NOT reset)
		SCHEDULED_RESTART_TIME=$(date -d "$(date +%H):$(date +%M) 2 minutes" +'%H:%M');
		echo "";
		echo " ($(date '+%Y-%m-%d %H:%M:%S'))   Calling  > shutdown -r \"${SCHEDULED_RESTART_TIME}\"";
		shutdown -r "${SCHEDULED_RESTART_TIME}";
	fi;

	# Pretty-Print exit msg
	echo "";
	echo " ($(date '+%Y-%m-%d %H:%M:%S'))   Finished \"${THIS_SCRIPT}\"";
	echo "";
	echo "===== ------------------------------------------------------------ =====";

fi;

# Exit Gracefully
exit 0;

# WSL (Windows Subsystem for Linux)
# !! To shutdown WSL, manually create above file via [sudo touch /var/run/reboot-required], when closing terminals,
# !! otherwise the linux environment persists the background as a service (essentially hidden)
#
# > sudo touch /var/run/reboot-required
