
# [ssh-keygen(1) - Linux man page](https://linux.die.net/man/1/ssh-keygen)

# ---------------------------------------------------------------------------------------------------------------------------------------------------- #
#!/bin/bash

#####      SSH-KEY CREATION & APPLICATION      #####
START_TIMESTAMP="$(date +'%Y%m%d_%H%M%S')";


IP_WHITELIST="";


KEY_PASSPHRASE="";


KEY_COMMENT="created_${START_TIMESTAMP}_by_$(whoami)_on_$(hostname)";



# Select output user directory
echo "";
read -p "  Create SSH-Key for which User?:  " -t 60 -r;
USER_NAME="${REPLY}";


# Check for valid data-entry
if [ -z "${USER_NAME}" ]; then
	echo "";
	echo "  ERROR - Empty or Null response detected - exiting ...";
	echo "";
	exit 1;
fi;


# Check if selected user exists
USER_PASSWD_INFO="$(getent passwd ${USER_NAME})";
if [ -z "${USER_PASSWD_INFO}" ]; then
	echo "";
	echo "  ERROR - User \"${USER_NAME}\" not found - exiting ...";
	echo "";
	exit 1;
fi;


# Check if User's home-directory exists
USER_HOME="$(echo ${USER_PASSWD_INFO} | cut -d: -f6)";
if [ ! -d "${USER_HOME}" ]; then
	echo "";
	echo "  ERROR - Home-Directory not found for user \"${USER_NAME}\" - exiting ...";
	echo "";
	exit 1;
fi;


# Runtime variables
#  |--> (DO NOT EDIT VARS ON THE FOLLOWING LINES --> INSTEAD, EDIT THEIR DEPENDENCIES AT THE TOP)
USER_HOME="$(eval echo ~${USER_NAME})";
KEY_UID="ssh_key_${USER_NAME}_${START_TIMESTAMP}";

KEY_OUTPUT_DIR="${USER_HOME}/ssh_created_keys/${START_TIMESTAMP}";
	KEY_ABSPATH_NOEXT="${KEY_OUTPUT_DIR}/${KEY_UID}";

PRIVATE_KEY_PATH="${KEY_ABSPATH_NOEXT}_private.pem";
PUBLIC_KEY_PATH="${KEY_ABSPATH_NOEXT}_public.pub";

# Create the output directory
mkdir -p "${KEY_OUTPUT_DIR}";

# Set permissions on output directory
chown "${USER_NAME}:${USER_NAME}" "${KEY_OUTPUT_DIR}";
chmod 700 "${KEY_OUTPUT_DIR}";

# Set permissions on output directory's parent-directory
chown "${USER_NAME}:${USER_NAME}" "$(dirname ${KEY_OUTPUT_DIR})";
chmod 700 "$(dirname ${KEY_OUTPUT_DIR})";


# Create the SSH-keypair
#  |--> (DO NOT EDIT VARS ON THE FOLLOWING LINES --> INSTEAD, EDIT THEIR DEPENDENCIES AT THE TOP)
if [ -n "$KEY_COMMENT" ]; then # var is not empty

	ssh-keygen -q -t rsa -b 2048 -f "${KEY_ABSPATH_NOEXT}" -N "${KEY_PASSPHRASE}" -C "${KEY_COMMENT}";

else # var is empty

	ssh-keygen -q -t rsa -b 2048 -f "${KEY_ABSPATH_NOEXT}" -N "${KEY_PASSPHRASE}";

fi;


# Add an IP whitelist to the public key (if variable is not blank)
#  |--> (DO NOT EDIT VARS ON THE FOLLOWING LINES --> INSTEAD, EDIT THEIR DEPENDENCIES AT THE TOP)
if [ -n "${IP_WHITELIST}" ]; then # var is not empty
	printf 'from="'${IP_WHITELIST}'" ' >> "${PUBLIC_KEY_PATH}"
	IP_RESTRICTION_MSG="${IP_WHITELIST}";
else # var is empty
	IP_RESTRICTION_MSG="ANY IP";
fi;


# Name the keys as-intended
#  |--> (DO NOT EDIT VARS ON THE FOLLOWING LINES --> INSTEAD, EDIT THEIR DEPENDENCIES AT THE TOP)
mv "${KEY_ABSPATH_NOEXT}" "${PRIVATE_KEY_PATH}";
cat "${KEY_ABSPATH_NOEXT}.pub" >> "${PUBLIC_KEY_PATH}" && rm "${KEY_ABSPATH_NOEXT}.pub";


# ADD TO:  /etc/ssh/authorized_keys/${USER_NAME}  ??
#  |--> (DO NOT EDIT VARS ON THE FOLLOWING LINES --> INSTEAD, EDIT THEIR DEPENDENCIES AT THE TOP)
ETC_SSH_AUTHKEYS="/etc/ssh/authorized_keys";
	ETC_SSH_AUTHKEYS_USERNAME="${ETC_SSH_AUTHKEYS}/${USER_NAME}";
echo "";
read -p "  ADD KEY TO  \"${ETC_SSH_AUTHKEYS_USERNAME}\"  ? ( Y/N ) " -n 1 -r;
APPEND_TO_ETC_SSH_AUTHKEYS="${REPLY}";


if [[ "${APPEND_TO_ETC_SSH_AUTHKEYS}" == "y" ]] || [[ "${APPEND_TO_ETC_SSH_AUTHKEYS}" == "Y" ]]; then
	
	# Append the newly created key's public-file onto [ /etc/ssh/authorized_keys/$USER_NAME ]
	# 	Note 1: The public-key matches with client-passed private-key at time of ssh-connection
	#   Note 2: [cat ... >> ...] adds a newline before the command (no need to add extra \n's)
	echo "";
	echo "    Appending public-key onto \"${ETC_SSH_AUTHKEYS_USERNAME}\" ...";
	mkdir -p "${ETC_SSH_AUTHKEYS}" && chown "root:root" "${ETC_SSH_AUTHKEYS}" && chmod 755 "${ETC_SSH_AUTHKEYS}";
	cat "${PUBLIC_KEY_PATH}" >> "${ETC_SSH_AUTHKEYS_USERNAME}" && chown "${USER_NAME}:${USER_NAME}" "${ETC_SSH_AUTHKEYS_USERNAME}" && chmod 600 "${ETC_SSH_AUTHKEYS_USERNAME}";
	
else
	
	echo "";
	echo "    Skipped Etc-Authkey";
		
	# Setup filepaths for [ ${USER_HOME}/.ssh/authorized_keys ]
	#  |--> (DO NOT EDIT VARS ON THE FOLLOWING LINES --> INSTEAD, EDIT THEIR DEPENDENCIES AT THE TOP)
	USERHOME_SSH="${USER_HOME}/.ssh";
		USERHOME_SSH_AUTHKEY="${USERHOME_SSH}/authorized_keys";

	# Check if user wants to append the new public-key onto "${USER_HOME}/.ssh/authorized_keys"
	#  |--> (DO NOT EDIT VARS ON THE FOLLOWING LINES --> INSTEAD, EDIT THEIR DEPENDENCIES AT THE TOP)
	echo "";
	read -p "  ADD KEY TO  \"${USERHOME_SSH_AUTHKEY}\"  ? ( Y/N ) " -n 1 -r;
	APPEND_TO_USERHOME_SSH_AUTHKEY="${REPLY}";
	
	if [[ "${APPEND_TO_USERHOME_SSH_AUTHKEY}" == "y" ]] || [[ "${APPEND_TO_USERHOME_SSH_AUTHKEY}" == "Y" ]]; then
		echo "";
		echo "    Appending public-key onto \"${USERHOME_SSH_AUTHKEY}\" ...";
		mkdir -p "${USERHOME_SSH}" && chown "${USER_NAME}:${USER_NAME}" "${USERHOME_SSH}" && chmod 700 "${USERHOME_SSH}";
		cat "${PUBLIC_KEY_PATH}" >> "${USERHOME_SSH_AUTHKEY}" && chown "${USER_NAME}:${USER_NAME}" "${USERHOME_SSH_AUTHKEY}" && chmod 600 "${USERHOME_SSH_AUTHKEY}";

	else
		echo "";
		echo "    Skipped Userhome-Authkey";
	fi;
	
fi;


# Exported Keys - [chmod] and [chown] as-intended
#  |--> (DO NOT EDIT VARS ON THE FOLLOWING LINES --> INSTEAD, EDIT THEIR DEPENDENCIES AT THE TOP)
chmod 600 "${PRIVATE_KEY_PATH}" && chown "${USER_NAME}:${USER_NAME}" "${PRIVATE_KEY_PATH}";
chmod 600 "${PUBLIC_KEY_PATH}" && chown "${USER_NAME}:${USER_NAME}" "${PUBLIC_KEY_PATH}";

echo ""
echo "  SSH-Keypair created!";
echo ""
echo "     Linux-User:    ${USER_NAME}";
echo "     IPs Allowed:   ${IP_RESTRICTION_MSG}";
echo ""
echo "     Public-Key:    ${PUBLIC_KEY_PATH}";
echo "     Private-Key:   ${PRIVATE_KEY_PATH}";
echo "";
echo "  Script Complete - exiting ...";
echo "";

exit;


# ---------------------------------------------------------------------------------------------------------------------------------------------------- #

  # CREATE A NEW [SSH-RSA 2048-bit] KEY IN HOME DIRECTORY
# ssh-keygen -t rsa -b 2048 -f "$(eval echo ~$(whoami))/new_key.pem"

# ---------------------------------------------------------------------------------------------------------------------------------------------------- #

  # NEW KEY IN ~/.ssh/authorized_keys  &&  ~/.ssh/new_key.pem
# ssh-keygen -t rsa -b 2048 -f "${HOME}/.ssh/authorized_keys.pem"
# ssh-keygen -t rsa -b 2048 -f "${HOME}/.ssh/new_key.pem"

# ---------------------------------------------------------------------------------------------------------------------------------------------------- #

  # man ssh-keygen

     # -b bits
             # Specifies the number of bits in the key to create.  For RSA keys, the minimum size is 1024 bits and the default is 2048 bits.  Generally, 2048 bits is considered
             # sufficient.  DSA keys must be exactly 1024 bits as specified by FIPS 186-2.  For ECDSA keys, the -b flag determines the key length by selecting from one of three
             # elliptic curve sizes: 256, 384 or 521 bits.  Attempting to use bit lengths other than these three values for ECDSA keys will fail.  Ed25519 keys have a fixed
             # length and the -b flag will be ignored.

     # -f filename
             # Specifies the filename of the key file.

     # -t dsa | ecdsa | ed25519 | rsa | rsa1
             # Specifies the type of key to create.  The possible values are “rsa1” for protocol version 1 and “dsa”, “ecdsa”, “ed25519”, or “rsa” for protocol version 2.

# ---------------------------------------------------------------------------------------------------------------------------------------------------- #


#Subsystem sftp /usr/lib/openssh/sftp-server ### STOCK
# Subsystem sftp internal-sftp ### UPDATED

#AuthorizedKeysFile %h/.ssh/authorized_keys  ### STOCK
# AuthorizedKeysFile /etc/ssh/authorized_keys/%u  ## UPDATED (1 of 2)
# AuthorizedKeysFile %h/.ssh/authorized_keys      ## UPDATED (2 of 2)


#/\/===--    SSH CONFIG    --===\/\#
SSH_CONF_FILEPATH="/etc/ssh/sshd_config";
echo "";
echo "Updating SSH Config-File \"${SSH_CONF_FILEPATH}\" ...";
sed_SSH_001="/^Subsystem sftp /c\Subsystem sftp internal\-sftp";
sed_SSH_002="/^AuthorizedKeysFile /c\AuthorizedKeysFile \%h\/\.ssh\/authorized_keys \/etc\/ssh\/authorized_keys\/\%u";
sed --in-place \
--expression="${sed_SSH_002}" \
--expression="${sed_SSH_002}" \
"${SSH_CONF_FILEPATH}";
echo "";
echo "Updated SSH Config-File \"${SSH_CONF_FILEPATH}\"";

# Apply changes to the SSH service
service ssh restart


# ---------------------------------------------------------------------------------------------------------------------------------------------------- #
