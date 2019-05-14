#!/bin/bash
if [ -n "$0" ]; then
	# FIND LOGFILE
	DIR_LOGS="/home/boneal/public_html/persistent/logfiles";
	LOG_TYPE="";
	SUBDOMAIN="";
	DOMAIN="boneal.net";
	if [ -n "$3" ]; then
		LOGFILE_TARGET="$3";
	else
		if [[ "$0" == *"rfq"* ]]; then
			SUBDOMAIN="www";
			if [[ "$1" == *"access"* ]]; then # RFQ Access-Log
				LOG_TYPE="access";
				LOGFILE_1="${DIR_LOGS}/access_log_www";
				LOGFILE_2="${DIR_LOGS}/ssl_access_log_www";
			elif [[ "$1" == *"mail"* ]]; then # RFQ Mail-Log
				LOG_TYPE="mail";
				LOGFILE_1="${DIR_LOGS}/mail_log_www";
				LOGFILE_2="";
			else 															# RFQ Error-Log
				LOG_TYPE="error";
				LOGFILE_1="${DIR_LOGS}/error_log_www";
				LOGFILE_2="${DIR_LOGS}/ssl_error_log_www";
			fi;

		elif [[ "$0" == *"dev.bonedge"* ]]; then # dev.bonedge.boneal.net
			LOG_TYPE="error";
			SUBDOMAIN="dev.bonedge";
			LOGFILE_1="${DIR_LOGS}/error_log_dev.bonedge";

		elif [[ "$0" == *"prod.bonedge"* ]]; then # prod.bonedge.boneal.net
			LOG_TYPE="error";
			SUBDOMAIN="prod.bonedge";
			LOGFILE_1="${DIR_LOGS}/error_log_prod.bonedge";

		elif [[ "$0" == *"qa.bonedge"* ]]; then # qa.bonedge.boneal.net
			LOG_TYPE="error";
			SUBDOMAIN="qa.bonedge";
			LOGFILE_1="${DIR_LOGS}/error_log_qa.bonedge";

		elif [[ "$0" == *"uat.bonedge"* ]]; then # uat.bonedge.boneal.net
			LOG_TYPE="error";
			SUBDOMAIN="uat.bonedge";
			LOGFILE_1="${DIR_LOGS}/error_log_uat.bonedge";
			
		elif [[ "$0" == *"mdev"* ]]; then
			SUBDOMAIN="mdev";
			if [[ "$1" == *"access"* ]]; then # MDEV Access-Log
				LOG_TYPE="access";
				LOGFILE_1="${DIR_LOGS}/access_log_mdev";
				LOGFILE_2="${DIR_LOGS}/ssl_access_log_mdev";
			elif [[ "$1" == *"mail"* ]]; then # MDEV Mail-Log
				LOG_TYPE="mail";
				LOGFILE_1="${DIR_LOGS}/mail_log_mdev";
				LOGFILE_2="";
			else 															# MDEV Error-Log
				LOG_TYPE="error";
				LOGFILE_1="${DIR_LOGS}/error_log_mdev";
				LOGFILE_2="${DIR_LOGS}/ssl_error_log_mdev";
				# tail -f file1 & tail -f file2
			fi;
		elif [[ "$0" == *"rdev"* ]]; then
			SUBDOMAIN="rdev";
			if [[ "$1" == *"access"* ]]; then # RDEV Access-Log
				LOG_TYPE="access";
				LOGFILE_1="${DIR_LOGS}/access_log_rdev";
				LOGFILE_2="${DIR_LOGS}/ssl_access_log_rdev";
			elif [[ "$1" == *"mail"* ]]; then # RDEV Mail-Log
				LOG_TYPE="mail";
				LOGFILE_1="${DIR_LOGS}/mail_log_rdev";
				LOGFILE_2="";
			else 															# RDEV Error-Log
				LOG_TYPE="error";
				LOGFILE_1="${DIR_LOGS}/error_log_rdev";
				LOGFILE_2="${DIR_LOGS}/ssl_error_log_rdev";
			fi;
		elif [[ "$0" == *"dev"* ]]; then
			SUBDOMAIN="dev";
			if [[ "$1" == *"access"* ]]; then # DEV Access-Log
				LOG_TYPE="access";
				LOGFILE_1="${DIR_LOGS}/access_log_dev";
				LOGFILE_2="${DIR_LOGS}/ssl_access_log_dev";
			elif [[ "$1" == *"mail"* ]]; then # DEV Mail-Log
				LOG_TYPE="mail";
				LOGFILE_1="${DIR_LOGS}/mail_log_dev";
				LOGFILE_2="";
			else 															# DEV Error-Log
				LOG_TYPE="error";
				LOGFILE_1="${DIR_LOGS}/error_log_dev";
				LOGFILE_2="${DIR_LOGS}/ssl_error_log_dev";
			fi;
		else
			echo "";
			echo "Error: Invalid / Undefined tail command \"${0}\"";
			echo "";
			exit;
		fi;
		FQDN="${SUBDOMAIN}.${DOMAIN}";
	fi;
	
	if [ -n "${LOGFILE_1}" ] && [ -f "${LOGFILE_1}" ] && [ $(du -sh "${LOGFILE_1}" | awk '{print $1}') != "0" ]; then
		if [ -n "${LOGFILE_2}" ] && [ -f "${LOGFILE_2}" ] && [ $(du -sh "${LOGFILE_2}" | awk '{print $1}') != "0" ]; then
			clear;
			echo -e "\nTailing \"${FQDN}\" ${LOG_TYPE} log(s)\n\nLog-Filepath: ${LOGFILE_1}\n\nLog-Filepath: ${LOGFILE_2}\n";
			multitail "${LOGFILE_1}" "${LOGFILE_2}";
		else
			clear;
			echo -e "\nTailing \"${FQDN}\" ${LOG_TYPE} log(s)\n\nLog-Filepath: ${LOGFILE_1}\n";
			tail -n 1000 -f "${LOGFILE_1}";
		fi;
	elif [ -n "${LOGFILE_2}" ] && [ -f "${LOGFILE_2}" ] && [ $(du -sh "${LOGFILE_2}" | awk '{print $1}') != "0" ]; then
		clear;
			echo -e "\nTailing \"${FQDN}\" ${LOG_TYPE} log(s)\n\nLog-Filepath: ${LOGFILE_2}\n";
		tail -n 1000 -f "${LOGFILE_2}";
	else
		echo "";
		echo " No Logfiles Found - Exiting...";
		echo "";
	fi;
	
	# DISPLAY LOGFILE
	###   if [ -n "${LOGFILE_TARGET}" ]; then # variable is set
	###   	if [ -f "${LOGFILE_TARGET}" ]; then # file exists
	###   		echo "";
	###   		echo "LOGFILE_TARGET:   ${LOGFILE_TARGET}";
	###   		echo "";
	###   		REGEX_INTEGERS='^[0-9]+$';
	###   		if [ -n "$2" ]; then
	###   			if [[ "$2" == *"all"* ]]; then
	###   				# SHOW ENTIRE FILE
	###   				cat "${LOGFILE_TARGET}";
	###   			elif [[ "$2" == *"er"* ]]; then
	###   				# SHOW ERRORS ONLY
	###   				tail -n +1 -f "${LOGFILE_TARGET}" | grep error;
	###   			elif [[ $2 =~ $REGEX_INTEGERS ]]; then
	###   				# TAIL BY [ARG 2] LINES
	###   				tail -n $2 -f "${LOGFILE_TARGET}";
	###   			else
	###   				# TAIL N LINES
	###   				tail -f "${LOGFILE_TARGET}";
	###   			fi;
	###   		else
	###   			# CAT FILE (IF $2 IS 0)
	###   			tail -n 2500 -f "${LOGFILE_TARGET}";
	###   		fi;
	###   	else
	###   		echo -e "\n\n$0: File not found: '${LOGFILE_TARGET}'\n\n";
	###   	fi;
	###   else 
	###   	echo -e "\n\n$0: Variable not set: LOGFILE_TARGET\n\n";
	###   fi;	
else 
	echo -e "\n\n $0: Variable not set: \$0\n\n";
fi;

exit;