#!/bin/bash

POTENTIAL_USERS_FILE="/tmp/potential_wsl_hosts_$(date +'%s%N')"; if [ -f "${POTENTIAL_USERS_FILE}" ]; then rm -f "${POTENTIAL_USERS_FILE}"; fi;
INVALID_USERS_FILE="/tmp/invalid_wsl_hosts_$(date +'%s%N')"; if [ -f "${INVALID_USERS_FILE}" ]; then rm -f "${INVALID_USERS_FILE}"; fi;

EXACT_MATCH="";

find "/mnt/c/Users" \
-mindepth 1 \
-maxdepth 1 \
-name '*' \
-type 'd' \
-not -path "/mnt/c/Users/Default" \
-not -path "/mnt/c/Users/Public" \
-print0 \
| while IFS= read -r -d $'\0' EACH_USER_DIR; do

	LAST_EXIT_CODE=$([[ -r "${EACH_USER_DIR}/Documents" ]]; echo $?);

	if [ "${LAST_EXIT_CODE}" == "0" ]; then
	#	echo "PASS - Can read \"${EACH_USER_DIR}\" - Current session has sufficient privilege(s)";
		echo "$(basename ${EACH_USER_DIR})" >> "${POTENTIAL_USERS_FILE}";

	else
	#	echo "FAIL - Cannot read \"${EACH_USER_DIR}\" - Current session lacks sufficient privilege(s)";
		echo "$(basename ${EACH_USER_DIR})" >> "${INVALID_USERS_FILE}";

	fi;

done;

USER_COUNT="$(cat ${POTENTIAL_USERS_FILE} | wc -l)";

if [ $(echo "${USER_COUNT} >= 1" | bc) -eq 1 ]; then
	#
	# Matched more than 1 user - show them all
	#
	echo -e "\n";
	echo "User-Documents directory is accessible for [ ${USER_COUNT} ] Windows User(s):";

	cat "${POTENTIAL_USERS_FILE}" | while read EACH_MATCHED_USERNAME; do
		echo "  ${EACH_MATCHED_USERNAME}";
	done;

	if [ $(echo "${USER_COUNT} == 1" | bc) -eq 1 ]; then
		#
		# Matched exactly 1 user - set user as "exact-match" host
		#
		EXACT_MATCH="$(cat ${POTENTIAL_USERS_FILE})";

	fi;

else
	echo "No User-Documents found to be readable.";
fi;

if [ -n "${EXACT_MATCH}" ]; then
	echo -e "\n";
	echo "Current Linux-Instance hosted by Windows-User \"${EXACT_MATCH}\"";
fi;


echo -e "\n";

#
# Citation(s)
#	
#		Thanks to StackOverflow user [ dogbane ] on forum [ https://stackoverflow.com/questions/15065010/how-do-i-use-a-for-each-loop-to-iterate-over-file-paths-in-bash ]
#
