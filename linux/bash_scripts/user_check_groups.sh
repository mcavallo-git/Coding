#!/bin/bash

USER_TO_CHECK="$(whoami)";

GROUPLIST=$(id --groups --name "${USER_TO_CHECK}");
i=0; SPLIT_CHAR=" ";
while [ $i -le 1000 ]; do # Bail-out after 100 iterations (for older, less-POSIX-friendly environments)
	i=$(( $i + 1 ));
	GROUPLIST_PRE_SPLIT="${GROUPLIST}";
	EACH_GROUP="${GROUPLIST%%${SPLIT_CHAR}*}";
	# 
	#			DO ACTION HERE FOR EACH GROUP WHICH THE GIVEN USER IS A MEMBER-OF
	#
	#				... e.g. ...   echo "EACH_GROUP = \"${EACH_GROUP}\"";
	#
	GROUPLIST="${GROUPLIST#*${SPLIT_CHAR}}";
	if [ "${GROUPLIST_PRE_SPLIT}" == "${GROUPLIST}" ]; then
		break; # Last Item - Exit the loop
	fi;
done;
