#!/bin/bash

USERS_MATCHED=();

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
		USERS_MATCHED+=("$(basename ${EACH_USER_DIR})");
	fi;

	#
	##### if more 'verbose' output is desired (and for the sake of transparency)
	#
	# if [ "${LAST_EXIT_CODE}" == "0" ]; then
	# 	echo "PASS - Can read \"${EACH_USER_DIR}\" - Current session has sufficient privilege(s)";
	# else
	# 	echo "FAIL - Cannot read \"${EACH_USER_DIR}\" - Current session lacks sufficient privilege(s)";
	# fi;

done;

echo "Current Linux-Instance hosted by Windows-User \"${WINDOWS_USERNAME}\"";




#
# Citation(s)
#	
#		Thanks to StackOverflow user [ dogbane ] on forum [ https://stackoverflow.com/questions/15065010/how-do-i-use-a-for-each-loop-to-iterate-over-file-paths-in-bash ]
#
