#!/bin/bash

# External servers to resolve WAN-IP through
SERVER_1="https://icanhazip.com";
SERVER_2="https://ipecho.net/plain";
SERVER_3="https://ident.me";
SERVER_4="https://bot.whatismyipaddress.com";

THIS_WAN_IP="";
THIS_HOST="";

# Get current WAN-IP via PHP running on BNet Servers
RESPONSE_SRVR="";
LENGTH_WAN_IP="";
declare -a IP_RESOLVERS=("SERVER_1" "SERVER_2" "SERVER_3" "SERVER_4");
RESOLVERS_NO_DUPES=($(echo "${IP_RESOLVERS[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '));
for EACH_SRVR in "${RESOLVERS_NO_DUPES[@]}"; do
	if [ ! -n "${THIS_WAN_IP}" ] || (( ${LENGTH_WAN_IP} > 15 )); then
		RESPONSE_SRVR="${!EACH_SRVR}";
		THIS_WAN_IP=$(curl -L -s "${RESPONSE_SRVR}");
		LENGTH_WAN_IP=$(echo -n "${THIS_WAN_IP}" | wc -c);
	fi;
done;

# Output Status: PASS or FAIL
if [ ! -n "${THIS_WAN_IP}" ] || (( ${LENGTH_WAN_IP} > 15 )); then
	RESPONSE_SRVR="";
	THIS_WAN_IP="";
	LENGTH_WAN_IP="";
	THIS_HOST="$(hostname)";
	echo "ERROR - Unable to resolve WAN-IP from BNet sources - Trying External sources";
else

	echo "SUCCESS - Resolved WAN-IP to \"${THIS_WAN_IP}\" via \"${RESPONSE_SRVR}\" ";

	# Manually resolve hostname
	if [[ "${THIS_WAN_IP}" == "52.15.93.108" ]];     then THIS_HOST="aws-1";  #  aws-1
	elif [[ "${THIS_WAN_IP}" == "18.220.12.125" ]];  then THIS_HOST="aws-2";  #  aws-2
	elif [[ "${THIS_WAN_IP}" == "13.58.94.67" ]];    then THIS_HOST="aws-3";  #  aws-3
	elif [[ "${THIS_WAN_IP}" == "18.220.169.43" ]];  then THIS_HOST="aws-4";  #  aws-4
	elif [[ "${THIS_WAN_IP}" == "13.59.148.38" ]];   then THIS_HOST="aws-5";  #  aws-5
	elif [[ "${THIS_WAN_IP}" == "54.236.236.117" ]]; then THIS_HOST="aws-6";  #  aws-6
	elif [[ "${THIS_WAN_IP}" == "54.210.52.140" ]];  then THIS_HOST="aws-7";  #  aws-7
	else echo "ERROR - Unhandled/Unknown WAN-IP: \"${THIS_WAN_IP}\"";
	fi;

	# Make sure desired hostname is what the hostname is currently set-to
	if [[ "${THIS_HOST}" == "$(hostname)" ]]; then
		echo "Current hostname matches one-to-one with desired \"${THIS_HOST}\"";
	else
		echo "ERROR - Hostname \"$(hostname)\" is out-of-sync (should be \"${THIS_HOST}\")";
	fi;
	
fi;

# Backwards compatibility (previously-utilized names for variables)
if [ ! -n "${NODE_IP}" ]; then
	NODE_IP="${THIS_WAN_IP}";
fi;
