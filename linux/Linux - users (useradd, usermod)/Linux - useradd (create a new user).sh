#!/bin/bash

# ------------------------------------------------------------
#
#	Script must be run w/ sudo privileges (e.g. as root user)
#
# ------------------------------------------------------------

# User Info
USER_NAME="newuser";
USER_ID="1234";
USER_SHELL="/bin/bash";

# User Directory-Info
DIR_USER_HOME="/home/${USER_NAME}"; CREATE_USERHOME="1";
DIR_USER_SSH="${DIR_USER_HOME}/.ssh"; CREATE_USERSSH="1";

# Primary Group Info
GROUP_NAME="${USER_NAME}"; CREATE_GROUP="1";
GROUP_ID="${USER_ID}";

# Options - Password
SET_USER_PASSWORD="0";

# Options - Sudo
ADD_USER_TO_SUDOERS="1";
SUDO_REQUIRES_PASS="0";

#	------------------------------------------------------------
#	   Set values above (Values below are based off of them)
# ------------------------------------------------------------

if [ "$(whoami)" != "root" ]; then

	echo "Must run \"${0}\" as user 'root'.";
	exit 1;

elif [ "$(id ${USER_ID} 2>/dev/null)" != "" ]; then

	echo "User ID \"${USER_ID}\" already taken, please choose another and re-run this script.";
	exit 1;

elif [ "${CREATE_GROUP}" == "1" ] && [ "$(getent group ${GROUP_ID} 2>/dev/null)" != "" ]; then

	echo "Group ID \"${GROUP_ID}\" already taken, please choose another and re-run this script.";
	echo "If this is desired, please set \$CREATE_GROUP to \"0\" and re-run this script.";
	exit 1;

elif [ "${CREATE_USERHOME}" == "1" ] && [ -d "${DIR_USER_HOME}" ]; then

	echo "Home Directory already exists: \"${DIR_USER_HOME}\".";
	echo "If you still want to use this directory, set \$CREATE_USERHOME to \"0\" and re-run this script.";
	exit 1;

else

	groupadd --gid "${GROUP_ID}" "${GROUP_NAME}";

	useradd --create-home --uid "${USER_ID}" --gid "${GROUP_ID}" --home-dir "${DIR_USER_HOME}" --shell "${USER_SHELL}" "${USER_NAME}";

	if [ "${CREATE_USERSSH}" == "1" ] && [ ! -d "${DIR_USER_SSH}" ]; then
		# Create user's SSH directory "~/.ssh"
		mkdir "${DIR_USER_SSH}";
		chmod 0700 "${DIR_USER_SSH}";
		chown "${USER_ID}" "${DIR_USER_SSH}";
	fi;


	# Make user a sudoer (able to run as root using 'sudo' command)
	if [ "${ADD_USER_TO_SUDOERS}" == "1" ]; then

		SUDOER_FILEPATH="/etc/sudoers.d/${USER_NAME}";

		# Add user to 'sudo' group (sudoers)
		usermod -aG sudo "${USER_NAME}";

		if [ "${SUDO_REQUIRES_PASS}" == "0" ]; then

			# Choice 1/2: No password required for user to run 'sudo' commands
			echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" > "${SUDOER_FILEPATH}";
			chmod 440 "${SUDOER_FILEPATH}";

		else

			# Choice 2/2: Require a password when user runs 'sudo' commands
			echo "${USER_NAME} ALL=(ALL) ALL" > "${SUDOER_FILEPATH}";
			chmod 440 "${SUDOER_FILEPATH}";

		fi;

		# Refer to "/etc/ssh/sshd_config" for more-advanced SSH config

	fi;


	if [ "${SET_USER_PASSWORD}" != "0" ]; then
		passwd "${USER_NAME}";
		#				[Enter password] > ENTER
		#			[Confirm password] > ENTER
	fi;
	
	exit 0;

fi;
