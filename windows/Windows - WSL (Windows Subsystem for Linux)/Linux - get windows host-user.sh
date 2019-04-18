#!/bin/bash

WINDOWS_USER_DIRS="/mnt/c/Users";

find "${WINDOWS_USER_DIRS}" -mindepth 1 -maxdepth 1 -type 'd' -name '*' -print0 | while IFS= read -r -d $'\0' EACH_USER_DIR; do
	echo "------------------------------------------------------------";

	LAST_EXIT_CODE=$([[ -r "${EACH_USER_DIR}" ]]; echo $?);

	if [ "${LAST_EXIT_CODE}" == "0" ]; then	# Valid read-privileges

		echo "Pass - Can read \"${TESEACH_USER_DIRT_PATH}\" - Current session has sufficient privilege(s)";

	else # Insufficient read-privileges

		echo "Fail - Cannot read \"${EACH_USER_DIR}\" - Current session lacks sufficient privilege(s)";
		
	fi;

done;



#
# Citation(s)
#	
#		Thanks to StackOverflow user [ dogbane ] on forum [ https://stackoverflow.com/questions/15065010/how-do-i-use-a-for-each-loop-to-iterate-over-file-paths-in-bash ]
#
