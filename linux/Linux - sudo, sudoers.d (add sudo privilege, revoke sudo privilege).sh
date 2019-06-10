#!/bin/bash
#
# Setup user to be able to user [ sudo -i ] and [ sudo ... ] to act as root-user
#
# ------------------------------------------------------------

TARGET_USER="ubuntu";

SUDOER_ACTION="";
# SUDOER_ACTION="ALLOW";
# SUDOER_ACTION="REVOKE";

if [ "${SUDOER_ACTION}" == "ALLOW" ]; then # ------------------------------------------------------------
	### Allow user to call the 'sudo' command

	SUDO_REQUIRES_USERPASS="1";

	SUDOER_FILE_CONTENTS="";
	if [[ "${SUDO_REQUIRES_USERPASS}" == "1" ]]; then
		SUDOER_FILE_CONTENTS="${TARGET_USER} ALL=(ALL) ALL";
	else
		SUDOER_FILE_CONTENTS="${TARGET_USER} ALL=(ALL) NOPASSWD:ALL";
	fi;

	# Add the user-specific 'sudo' config-file
	SUDOER_FILE_FULLPATH="/etc/sudoers.d/${TARGET_USER}";
	echo "${SUDOER_FILE_CONTENTS}" > "${SUDOER_FILE_FULLPATH}" && \
	chmod 400 "${SUDOER_FILE_FULLPATH}" && \
	chown "root:root" "${SUDOER_FILE_FULLPATH}";

	# Add the user to the group 'sudo'
	GROUP_SUDOERS="sudo";
	groupadd "${GROUP_SUDOERS}" && \
	usermod -aG "${GROUP_SUDOERS}" "${TARGET_USER}";

elif [ "${SUDOER_ACTION}" == "REVOKE" ]; then # ------------------------------------------------------------
	### Deny user from running the 'sudo' command

	# Remove the user-specific 'sudo' config-file
	SUDOER_FILE_FULLPATH="/etc/sudoers.d/${TARGET_USER}";
	if [ -f "${SUDOER_FILE_FULLPATH}" ]; then
		rm -f "${SUDOER_FILE_FULLPATH}";
	fi;

	# Remove the user from the group 'sudo'
	GROUP_SUDOERS="sudo";
	gpasswd -d "${TARGET_USER}" "${GROUP_SUDOERS}";

else # ------------------------------------------------------------
	#	Check whether-or-not a user is a sudoer
	#		(e.g. check if a user can call 'sudo')

	sudo --list --other-user="${TARGET_USER}";

fi;

# ------------------------------------------------------------
