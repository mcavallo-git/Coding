#!/bin/bash

# ------------------------------------------------------------
### This script updates a Linux instance's hostname & domain

### To run in 'dry-run' mode:
# >   DRY_RUN="1" && SET_HOSTNAME="HOSTNAME" && SET_DOMAIN="DOMAIN" && source "./set_hostname.sh";

### To run in 'live' mode:
# >   DRY_RUN="0" && SET_HOSTNAME="HOSTNAME" && SET_DOMAIN="DOMAIN" && source "./set_hostname.sh";

# ------------------------------------------------------------

echo "";
if [ "$(whoami)" != "root" ]; then

	# Require elevated privileges (e.g. require "root" user)
	echo "Must run \"${0}\" as user 'root'.";
	exit 1;

elif [ ! -n "${SET_HOSTNAME}" ]; then

	# Required variable empty: SET_HOSTNAME
	echo "Variable \${SET_HOSTNAME} is empty";
	echo "Please set variable to your desired value and re-run this script.";
	echo "  ( e.g. SET_HOSTNAME=[your_value]; )";
	exit 1;

elif [ ! -n "${SET_DOMAIN}" ]; then

	# Required variable empty: SET_HOSTNAME
	echo "Variable \${SET_DOMAIN} is empty";
	echo "Please set variable to your desired value and re-run this script.";
	echo "  ( e.g. SET_DOMAIN=[your_value]; )";
	exit 1;

else

	# ------------------------------------------------------------
	# Determine Dry-Run mode
	#

	if [ -n "${DRY_RUN}" ]; then
		if [ "${DRY_RUN}" != "1" ] && [ "${DRY_RUN}" != "0" ]; then
			echo "Invalid value set for \$DRY_RUN";
			echo "Please set to \"1\" for dry-run, \"0\" for live-run";
			echo "";
			echo "RESETTING \$DRY_RUN to \"1\"";
			DRY_RUN=1;
		fi;
	elif [ -n "$1" ]; then
		if [ "$1" == "0" ]; then
			DRY_RUN=0;
		else
			echo "Invalid value set for \$1";
			echo "Please set to \"1\" for dry-run, \"0\" for live-run";
			echo "";
			echo "RESETTING \$DRY_RUN to \"1\"";
			DRY_RUN=1;
		fi;
	else
		DRY_RUN=1;
	fi;

	# ------------------------------------------------------------
	# Determine Linux distro
	#

	IS_CENTOS=$(if [[ $(cat /etc/*release | grep -i centos | wc -l) -gt 0 ]]; then echo 1; else echo 0; fi; );
	IS_UBUNTU=$(if [[ $(cat /etc/*release | grep -i ubuntu | wc -l) -gt 0 ]]; then echo 1; else echo 0; fi; );
	IS_ALPINE=$(if [[ $(cat /etc/*release | grep -i alpine | wc -l) -gt 0 ]]; then echo 1; else echo 0; fi; );
	IS_DEBIAN=$(if [[ $(cat /etc/*release | grep -i debian | wc -l) -gt 0 ]]; then echo 1; else echo 0; fi; );
	THIS_LINUX_DISTRO="$(if [[ ${IS_CENTOS} -gt 0 ]]; then echo CENTOS; elif [[ ${IS_UBUNTU} -gt 0 ]]; then echo UBUNTU; elif [[ ${IS_ALPINE} -gt 0 ]]; then echo ALPINE; elif [[ ${IS_DEBIAN} -gt 0 ]]; then echo DEBIAN; else echo UNKNOWN; fi; )";

	# ------------------------------------------------------------

	# External server(s) to resolve WAN-IP through
	RESOLVER_1="https://icanhazip.com";
	RESOLVER_2="https://ipecho.net/plain";
	RESOLVER_3="https://ident.me";
	RESOLVER_4="https://bot.whatismyipaddress.com";

	# Attempt to resolve WAN IPv4
	if [ -z "${THIS_IPv4_WAN}" ]; then THIS_IPv4_WAN=$(curl -4 -L -s "${RESOLVER_1}"); fi; RESOLVER_USED="${RESOLVER_1}";
	if [ -z "${THIS_IPv4_WAN}" ]; then THIS_IPv4_WAN=$(curl -4 -L -s "${RESOLVER_2}"); fi; RESOLVER_USED="${RESOLVER_2}";
	if [ -z "${THIS_IPv4_WAN}" ]; then THIS_IPv4_WAN=$(curl -4 -L -s "${RESOLVER_3}"); fi; RESOLVER_USED="${RESOLVER_3}";
	if [ -z "${THIS_IPv4_WAN}" ]; then THIS_IPv4_WAN=$(curl -4 -L -s "${RESOLVER_4}"); fi; RESOLVER_USED="${RESOLVER_4}";

	# Verify WAN IPv4
	if [ -n "${THIS_IPv4_WAN}" ]; then
		echo "Resolved WAN IPv4 to: \"${THIS_IPv4_WAN}\"";
	else 
		echo "Unable to resolve WAN IPv4.";
		echo "If you wish to manually set it, please set \${THIS_IPv4_WAN} to your desired value and re-run this script.";
		exit 1;
	fi;

	# ------------------------------------------------------------
	# Determine LAN IPv4
	THIS_IPv4_LAN=$(ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//' | grep '\.');

	# Verify LAN IPv4
	if [ -n "${THIS_IPv4_LAN}" ]; then
		echo "Resolved LAN IPv4 to: \"${THIS_IPv4_LAN}\"";
	else 
		echo "Unable to resolve LAN IPv4.";
		echo "If you wish to manually set it, please set \${THIS_IPv4_LAN} to your desired value and re-run this script.";
		exit 1;
	fi;
	
	SET_FQDN="${SET_HOSTNAME}.${SET_DOMAIN}";
	
	echo "Set Hostname: \"${SET_HOSTNAME}\"";
	echo "Set Domain: \"${SET_DOMAIN}\"";
	echo "Combined (FQDN): \"${SET_FQDN}\"";

	# ------------------------------------------------------------
	#	If Dry-Run mode is off, require user to confirm changes
	#

	echo "";
	if [[ "${DRY_RUN}" == "0" ]]; then
		echo "NOT RUNNING IN DRY-RUN MODE";
		echo "HOSTNAME / DOMAIN-NAME CHANGES WILL BE SET TO VALUES SHOWN ABOVE";
		read -p "CONFIRM CHANGES TO HOST-NAME / DOMAIN-NAME ( y/n )" -n 1 -r
		echo "";
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			echo "CONFIRMED - PROCEEDING WITH CHANGES TO HOST-NAME / DOMAIN-NAME";
		else
			echo "CANCELLED - EXITING";
			exit 1;
		fi;
	else
		echo "DRY-RUN MODE ACTIVE";
	fi;
	echo "";

	# ------------------------------------------------------------
	# /etc/hostname
	#
	HOSTNAME_FILE="/etc/hostname";
	if [[ -f "${HOSTNAME_FILE}" ]]; then
		if [[ "${DRY_RUN}" == "0" ]]; then # NOT a dry-run
			echo "${SET_HOSTNAME}" > "${HOSTNAME_FILE}";
		else # dry-run
			echo "";
			echo "APPLY HOSTNAME VIA [ ${HOSTNAME_FILE} ]";
		fi;
	fi;

	# ------------------------------------------------------------
	# /etc/hosts
	#
	HOSTS_FILE="/etc/hosts";
	if [[ -f "${HOSTS_FILE}" ]]; then
		if [[ "${DRY_RUN}" == "0" ]]; then # NOT a dry-run
			echo "";
			echo "HOSTS FILE (BEFORE-EDITS)" && cat "${HOSTS_FILE}";
			TEMP_HOSTS="${HOSTS_FILE}_TEMP";
			cp -f "${HOSTS_FILE}" "${TEMP_HOSTS}";
			sed_1="/^${THIS_IPv4_WAN}/c\ ";
			sed_2="/^${THIS_IPv4_LAN}/c\ ";
			sed --in-place --expression="${sed_1}" --expression="${sed_2}" "${TEMP_HOSTS}";
			sed_3="/^127.0.0.1/c\127.0.0.1 localhost localhost.localdomain\n${THIS_IPv4_WAN} ${SET_HOSTNAME}.${SET_DOMAIN} ${SET_HOSTNAME}";
			sed --in-place --expression="${sed_3}" "${TEMP_HOSTS}";
			sed_whitespace_only='/^\s*$/d';
			sed --in-place --expression="${sed_whitespace_only}" "${TEMP_HOSTS}"; # Remove whitespace-only lines
			cp -f "${TEMP_HOSTS}" "${HOSTS_FILE}" && rm -f "${TEMP_HOSTS}";
			echo "";
			echo "HOSTS FILE (AFTER-EDITS)" && cat "${HOSTS_FILE}";
		else # dry-run
			echo "";
			echo "APPLY HOSTNAME VIA [ ${HOSTS_FILE}]";
		fi;
	fi;

	# ------------------------------------------------------------
	# centos 6
	#
	if [[ -f "/etc/sysconfig/network" ]]; then
		if [[ "${DRY_RUN}" == "0" ]]; then # NOT a dry-run
			sed --in-place --expression="/^HOSTNAME=/c\HOSTNAME=${SET_HOSTNAME}.${SET_DOMAIN}" "/etc/sysconfig/network";
		else # dry-run
			echo "";
			echo "APPLY HOSTNAME VIA [ /etc/sysconfig/network ]";
		fi;
	fi;

	# ------------------------------------------------------------
	# debian 7 / slackware / ubuntu 14.04
	#
	if [[ -f "/etc/init.d/hostname.sh" ]]; then
		if [[ "${DRY_RUN}" == "0" ]]; then # NOT a dry-run
			/etc/init.d/hostname.sh;
		else # dry-run
			echo "";
			echo "APPLY HOSTNAME VIA [ /etc/init.d/hostname.sh ]";
		fi;
	fi;

	# ------------------------------------------------------------
	# arch / centos 7 / debian 8 / fedora / ubuntu 16.04 and above
	#
	if [[ $(hostnamectl | wc -l) -gt 0 ]]; then
		if [[ "${DRY_RUN}" == "0" ]]; then # NOT a dry-run
			hostnamectl set-hostname "${SET_HOSTNAME}";
		else # dry-run
			echo "";
			echo "APPLY HOSTNAME VIA [ hostnamectl ]";
		fi;
	fi;


	# ------------------------------------------------------------
	# Apply Changes
	#
	if [[ -f "/etc/init.d/network" ]]; then # centos distros
		if [[ "${DRY_RUN}" == "0" ]]; then # NOT a dry-run
			echo "RESTART REQUIRED FOR [ /etc/init.d/network ]";
			read -p "RESTART NOW? ( Y/N )" -n 1 -r
			echo "";
			if [[ $REPLY =~ ^[Yy]$ ]]; then
				echo "";
				echo "RESTARTING [ /etc/init.d/network ]";
				/etc/init.d/network restart;
			else
				echo "";
				echo "POST-PONING RESTART OF [ /etc/init.d/network ]";
				exit 1;
			fi;
		else # dry-run
			echo "";
			echo "APPLY CHANGES VIA [ /etc/init.d/network restart ]";
		fi;
	else # [other] distros
		if [[ "${DRY_RUN}" == "0" ]]; then # NOT a dry-run
			read -p "SHUTDOWN REQUIRED - PERFORM NOW? ( Y/N )" -n 1 -r
			echo "";
			if [[ $REPLY =~ ^[Yy]$ ]]; then
				echo "";
				echo "SHUTTING DOWN";
				shutdown -r now;
			else
				echo "";
				echo "POST-PONING SHUTDOWN";
				exit 1;
			fi;
		else # dry-run
			echo "";
			echo "APPLY CHANGES VIA [ shutdown -r now ]";
		fi;
	fi;
fi;
echo "";

# ------------------------------------------------------------
#
#	Citation(s)
#
#			https://jblevins.org/log/hostname
#
#			https://support.rackspace.com/how-to/centos-hostname-change/
#
#			https://www.linode.com/docs/getting-started/#setting-the-hostname
#