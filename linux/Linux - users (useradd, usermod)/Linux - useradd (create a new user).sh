#!/bin/bash

# User Info
USER_NAME="uname";
USER_ID="1234";
USER_SHELL="/bin/bash";

# User Directory-Info
DIR_USER_HOME="/home/${USER_NAME}"; CREATE_USERHOME="1";
DIR_USER_SSH="${DIR_USER_HOME}/.ssh"; CREATE_USERSSH="1";

# Primary Group Info
GROUP_NAME="${USER_NAME}";
GROUP_ID="${USER_ID}";
CREATE_GROUP="1";

#	------------------------------------------------------------
#	   Set values above (Values below are based off of them)
# ------------------------------------------------------------

if [ "$(id ${USER_ID} 2>/dev/null; echo $?)" != "0" ]; then

	echo "User ID \"${USER_ID}\" already taken, please choose another and re-run this script.";

elif [ "${CREATE_GROUP}" == "1" ] && [ "$(id ${GROUP_ID} 2>/dev/null; echo $?)" != "0" ]; then

	echo "Group ID \"${GROUP_ID}\" already taken, please choose another and re-run this script.";
	echo "If this is desired, please set \$CREATE_GROUP to \"0\" and re-run this script.";
	exit 1;

elif [ "${CREATE_USERHOME}" == "1" ] && [ -d "${DIR_USER_HOME}"]; then

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

fi;