#!/bin/bash
#
# Check whether a user $1 is a member within group $2
#
# ------------------------------------------------------------

if [ -z "$1" ]; then echo "arg #1 missing (username)"; else TARGET_UNAME="$1"; fi; # Target username
if [ -z "$2" ]; then echo "arg #2 missing (groupname)"; else TARGET_GNAME="$2"; fi; # Target groupname
if [ -z "${TARGET_UNAME}" ] || [ -z "${TARGET_GNAME}" ]; then exit 1; fi; # Exit if either the username or the groupname was not-given/empty

# ------------------------------------------------------------

TARGET_GID="";

USER_LIST_GNAMES=();

GROUP_LIST_UNAMES=();

# ------------------------------------------------------------

# echo "";
for GROUP_ROW in $(cat "/etc/group"); do
{

	# Specifies a group name that is unique on the system. # See the mkgroup command for information on the restrictions for naming groups.
	THIS_GNAME=$( echo "${GROUP_ROW}" | awk -F":" "{print \$1}" ); # echo "${THIS_GNAME}";

	# Not used. # Group administrators are provided instead of group passwords. # See the /etc/security/group file for more information.
	THIS_GADMINS=$( echo "${GROUP_ROW}" | awk -F":" "{print \$2}" ); # echo "${THIS_GADMINS}";
	
	# Specifies the group ID. # The value is a unique decimal integer string. # The maximum value is 4,294,967,295 (4 GB).
	THIS_GID=$( echo "${GROUP_ROW}" | awk -F":" "{print \$3}" ); # echo "${THIS_GID}";
	
	# Identifies a list of one or more users. # Separate group member names with commas. # Each user must already be defined in the local database configuration files.
	THIS_USERLIST=$( echo "${GROUP_ROW}" | awk -F":" "{print \$4}" | tr "," "\n" ); # echo "${THIS_USERLIST}";

	# Save the converted group-id fresh from "/etc/group"
	if [ "${THIS_GNAME}" == "${TARGET_GNAME}" ]; then
		TARGET_GID="${THIS_GID}";
	fi;

	# Walk through each group's list of usernames
	for EACH_MEMBER in "${THIS_USERLIST}"; do
	{
		if [ "${EACH_MEMBER}" == "${TARGET_UNAME}" ]; then USER_LIST_GNAMES+=("${THIS_GNAME}"); fi;
		if [ "${THIS_GNAME}" == "${TARGET_GNAME}" ]; then GROUP_LIST_UNAMES+=("${EACH_MEMBER}"); fi;
	} done;

}; done;

# ------------------------------------------------------------

for USER_ROW in $(cat "/etc/passwd"); do
{
	THIS_UNAME=$( echo "${THIS_ROW}" | awk -F":" "{print \$1}" ); echo "${THIS_UNAME}"; # THIS name
	THIS_PASS=$( echo "${THIS_ROW}" | awk -F":" "{print \$2}" ); echo "${THIS_PASS}"; # Encrypted password
	THIS_UID=$( echo "${THIS_ROW}" | awk -F":" "{print \$3}" ); echo "${THIS_UID}"; # THIS ID number (UID)
	THIS_GID=$( echo "${THIS_ROW}" | awk -F":" "{print \$4}" ); echo "${THIS_GID}"; # THIS's group ID number (GID)
	THIS_GECOS=$( echo "${THIS_ROW}" | awk -F":" "{print \$5}" ); echo "${THIS_GECOS}"; # Full Name of he THIS
	THIS_HOME=$( echo "${THIS_ROW}" | awk -F":" "{print \$6}" ); echo "${THIS_HOME}"; # THIS home directory
	THIS_SHELL=$( echo "${THIS_ROW}" | awk -F":" "{print \$7}" ); echo "${THIS_SHELL}"; # Login shell

	USER_FOUND_IN_GROUPS+=("Item-One");

	if [ "${THIS_GID}" == "${TARGET_GID}" ]; then
		# Target-Group has current-iteration's user as a member
		GROUP_LIST_UNAMES+=("${THIS_UNAME}");
	fi;

	if [ "${THIS_UNAME}" == "${TARGET_UNAME}" ]; then
		TARGET_UID="${THIS_UID}";
		if [ "${THIS_GID}" == "${TARGET_GID}" ]; then
			# Target-User ($1) actually has their default/primary group set to the same value as the target usergroup ($2)
			#   |--> Note that this logic does NOT flow in reverse, e.g. the user may not even be a member of his/her DEFAULT usergroup
			USER_LIST_GNAMES+=("${TARGET_GNAME}");
		fi;
	fi;

}; done;

# Make sure the user-in-question was found to exist, locally
if [ -z "${TARGET_UID}" ]; then
	echo "user not found ($1)";
	exit 3;
fi;

# ------------------------------------------------------------

if [ "${USER_LIST_GNAMES[@]}" == "0" ]; then
	echo "Target-Username \"${TARGET_UNAME}\" not found in any groups (seems wrong, since they should have, in the LEAST, their primary group)";
else
	echo "Target-Username was found in ${#USER_LIST_GNAMES[@]} groups: ( ${USER_LIST_GNAMES[@]} )";
fi;


if [ "${GROUP_LIST_UNAMES[@]}" == "0" ]; then
	echo "Target-Groupname \"${TARGET_GNAME}\" not found to have any members";
else
	echo "Target-Groupname found to have ${#GROUP_LIST_UNAMES[@]} members: ( ${GROUP_LIST_UNAMES[@]} )";
fi;

# ------------------------------------------------------------

# GNAME="docker";
# GMEMBERS=$(getent group "${GNAME}" | awk -F":" "{print \$4}" | tr "," "\n");

# getent group "${GNAME}";


# groupmems --list --group "docker";

# grep "docker" "/etc/group" | cut -d":" -f"3" | xargs -Ix grep x "/etc/passwd" |cut -d ':' -f1;

#
# Citation:
#
#		"/etc/passwd" info thanks to IBM's Knowledge Center | https://www.ibm.com/support/knowledgecenter/en/ssw_aix_72/com.ibm.aix.security/passwords_etc_passwd_file.htm
#
#		"/etc/group" info thanks to IBM's Knowledge Center | https://www.ibm.com/support/knowledgecenter/en/ssw_aix_72/com.ibm.aix.files/group_security.htm
#