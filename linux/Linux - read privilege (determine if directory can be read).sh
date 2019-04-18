#!/bin/bash

TEST_PATH='/root/';

LAST_EXIT_CODE=$([[ -r "${TEST_PATH}" ]]; echo $?);

if [ "${LAST_EXIT_CODE}" == "0" ]; then	# Valid read-privileges

	echo "Pass - Can read \"${TEST_PATH}\" - Current session has sufficient privilege(s)";

else # Insufficient read-privileges

	echo "Fail - Cannot read \"${TEST_PATH}\" - Current session lacks sufficient privilege(s)";
	
fi;

