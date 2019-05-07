#!/bin/bash

#
# SCRIPT VERIFIES:    cat "/etc/network/interfaces.d/50-cloud-init.cfg";
#
# SCRIPT REBUILDS VIA:   ifdown -a && ifup -a; resolvconf -u; ifconfig eth0;
#
# TO_DO: LOOK INTO DNS OVER HTTPS https://github.com/jedisct1/dnscrypt-proxy
#        THANKS GO OUT TO THE GENTS ON REDDIT: https://www.reddit.com/r/privacy/comments/8mx6pe/what_dns_servers_to_use/
#

# Exit on-errors
echo ""; echo "Calling [set -e;]";
# set -e;

# DNS SERVER OPTIONS
	OPEN_NIC_DNS_1="128.52.130.209"; # https://servers.opennic.org/
	OPEN_NIC_DNS_2="192.99.85.244";  # https://servers.opennic.org/
	OPEN_NIC_DNS_3="172.98.193.42";  # https://servers.opennic.org/
	OPEN_NIC_DNS_4="198.206.14.241"; # https://servers.opennic.org/
		GOOGLE_DNS_1="8.8.8.8";        # https://developers.google.com/speed/public-dns/
		GOOGLE_DNS_2="8.8.4.4";        # https://developers.google.com/speed/public-dns/
			CLOUDFARE_DNS_1="1.1.1.1";   # https://www.cloudflare.com/dns/
			CLOUDFARE_DNS_2="1.0.0.1";   # https://www.cloudflare.com/dns/

			
# HOSTS/IPS TO TARGET AS DNS NAMESERVERS 
DNS_NAMESRVR_1="${GOOGLE_DNS_1}";
DNS_NAMESRVR_2="${GOOGLE_DNS_2}";
DNS_NAMESRVR_3="${CLOUDFARE_DNS_1}";

# DNS "SEARCH": TAKES A SET OF ONE OR MORE DOMAINS AND TRIES CONCATENATING EACH OF THEM
# WITH THE LOCAL ENVIRONMENT'S HOSTNAME (to try and resolve dns query) BEFORE REVERTING TO
# GOING EXTERNAL FOR RESOLUTION OF THE DNS QUERY IN_QUESTION
#
# MAX IS 6 DOMAINS TOTALING 256 OR LESS CHARACTERS)
#
DNS_SEARCH_DOMAIN="";

# Dingbats, intuitive logging chars/info
BOX_CHECK="☑";
BOX_XMARK="☒":
DASHES="-----------------------------------------------------------------------";
START_TIMESTAMP="$(date +'%Y%m%d_%H%M%S')";

# Privileged user access (root)
if [ "$(whoami)" != "root" ]; then echo ""; echo "ERROR:  Must run as root user"; exit 1; fi;

# Kernel-Info
IS_LINUX=$(if [[ $(uname -s | grep Linux | wc -l) -gt 0 ]]; then echo 1; else echo 0; fi; );
IS_WINDOWS_WSL=$(if [[ "$(< /proc/version)" == *@(Microsoft|WSL)* ]]; then echo 1; else echo 0; fi; );
if [ "${IS_LINUX}" != "1" ]; then echo ""; echo "ERROR:  Must run in a Linux-based environment"; exit 1; fi;

# Network default-filepaths
FILE_DNS_BUILDER="/etc/resolvconf/resolv.conf.d/base";
FILE_ETH0_BUILDER="/etc/network/interfaces.d/50-cloud-init.cfg"; # AWS default cloud-config
FILE_NETWORK_RESOLVER="/etc/resolv.conf";

# Backup-filepaths
BACKUP_CONFIGS_DIR="/root/backup/update_dns_config";
OLD_BACKUP_CONFIGS_DIR="/root/backup_network_configs";
if [ -d "${OLD_BACKUP_CONFIGS_DIR}" ]; then
	mkdir -p $(dirname "${BACKUP_CONFIGS_DIR}");
	mv "${OLD_BACKUP_CONFIGS_DIR}" "${BACKUP_CONFIGS_DIR}";
else
	mkdir -p "${BACKUP_CONFIGS_DIR}";
fi;
chmod 700 "${BACKUP_CONFIGS_DIR}"; chown "root:root" "${BACKUP_CONFIGS_DIR}";

# Backup necesarry config file(s), if-existent
FILE_TO_BACKUP="${FILE_NETWORK_RESOLVER}";
if [ -f "${FILE_TO_BACKUP}" ]; then
	BASENAME_TO_BACKUP=$(basename "${FILE_TO_BACKUP}");
	echo ""; echo "Calling [cp -f \"${FILE_TO_BACKUP}\" \"${BACKUP_CONFIGS_DIR}/${START_TIMESTAMP}_${BASENAME_TO_BACKUP}.bak\";]...";
	cp -f "${FILE_TO_BACKUP}" "${BACKUP_CONFIGS_DIR}/${START_TIMESTAMP}_${BASENAME_TO_BACKUP}.bak";
fi;
FILE_TO_BACKUP="${FILE_ETH0_BUILDER}";
if [ -f "${FILE_TO_BACKUP}" ]; then
	BASENAME_TO_BACKUP=$(basename "${FILE_TO_BACKUP}");
	echo ""; echo "Calling [cp -f \"${FILE_TO_BACKUP}\" \"${BACKUP_CONFIGS_DIR}/${START_TIMESTAMP}_${BASENAME_TO_BACKUP}.bak\";]...";
	cp -f "${FILE_TO_BACKUP}" "${BACKUP_CONFIGS_DIR}/${START_TIMESTAMP}_${BASENAME_TO_BACKUP}.bak";
fi;


if [ "${IS_WINDOWS_WSL}" == "1" ]; then

	# Windows subsystem for linux - wipe all of resolver (it gets rebuilt every time WSL is opened)
	echo "" > "${FILE_NETWORK_RESOLVER}";
	if [ -n "${DNS_NAMESRVR_1}" ]; then echo "nameserver ${DNS_NAMESRVR_1}" >> "${FILE_NETWORK_RESOLVER}"; fi;
	if [ -n "${DNS_NAMESRVR_2}" ]; then echo "nameserver ${DNS_NAMESRVR_2}" >> "${FILE_NETWORK_RESOLVER}"; fi;
	if [ -n "${DNS_NAMESRVR_3}" ]; then echo "nameserver ${DNS_NAMESRVR_3}" >> "${FILE_NETWORK_RESOLVER}"; fi;
	if [ -n "${DNS_SEARCH_DOMAIN}" ]; then echo "search ${DNS_SEARCH_DOMAIN}" >> "${FILE_NETWORK_RESOLVER}"; fi;
	echo "" >> "${FILE_NETWORK_RESOLVER}";

else

	#
	# Required package:
	#   resolvconf
	#
	# Method(s) used:
	#   > resolvconf   ### manage nameserver information
	#
	REQUIRED_PACKAGE_NAME="resolvconf";
	REQUIRED_METHOD_NAME="resolvconf";
	if [ -n "$(which ${REQUIRED_METHOD_NAME})" ]; then
		echo ""; echo "${BOX_CHECK} Passed  [which \"${REQUIRED_METHOD_NAME}\";] ";
	else
		echo ""; echo "${BOX_XMARK} Failed [which \"${REQUIRED_METHOD_NAME}\";] ";
		echo ""; echo "Please install required package via:";
		echo ""; echo "  > apt -y update; apt -y install \"${REQUIRED_PACKAGE_NAME}\";";
		echo ""; echo "  > reboot;";
		echo ""; exit 1;
	fi;

	#
	# Required package:
	#   ifupdown
	#
	# Method(s) used:
	#   > ifup        ### bring a network interface up
	#   > ifdown      ### take a network interface down
	#
	REQUIRED_PACKAGE_NAME="ifupdown";
	REQUIRED_METHOD_NAME="ifup";
	if [ -n "$(which ${REQUIRED_METHOD_NAME})" ]; then
		echo ""; echo "${BOX_CHECK} Passed  [which \"${REQUIRED_METHOD_NAME}\";] ";
	else
		echo ""; echo "${BOX_XMARK} Failed [which \"${REQUIRED_METHOD_NAME}\";] ";
		echo ""; echo "Please install required package via:";
		echo ""; echo "  > apt -y update; apt -y install \"${REQUIRED_PACKAGE_NAME}\";";
		echo ""; echo "  > reboot;";
		echo ""; exit 1;
	fi;
	REQUIRED_PACKAGE_NAME="ifupdown";
	REQUIRED_METHOD_NAME="ifdown";
	if [ -n "$(which ${REQUIRED_METHOD_NAME})" ]; then
		echo ""; echo "${BOX_CHECK} Passed  [which \"${REQUIRED_METHOD_NAME}\";] ";
	else
		echo ""; echo "${BOX_XMARK} Failed [which \"${REQUIRED_METHOD_NAME}\";] ";
		echo ""; echo "Please install required package via:";
		echo ""; echo "  > apt -y update; apt -y install \"${REQUIRED_PACKAGE_NAME}\";";
		echo ""; echo "  > reboot;";
		echo ""; exit 1;
	fi;

	# show "${FILE_NETWORK_RESOLVER}" file (configuration before-start)
	echo "";
	echo "Calling [cat \"${FILE_NETWORK_RESOLVER}\"]";
	echo "${DASHES}"; cat "${FILE_NETWORK_RESOLVER}"; echo "${DASHES}";

	# show DNS_NAMESRVR_1,2,3 & Domain-search vars
	echo "";
	echo "Attempting to configure $(hostname) to use the following DNS Next-Hops:";
	echo "${DASHES}";
	echo "DNS_NAMESRVR_1 = \"${DNS_NAMESRVR_1}\"";
	echo "DNS_NAMESRVR_2 = \"${DNS_NAMESRVR_2}\"";
	echo "DNS_NAMESRVR_3 = \"${DNS_NAMESRVR_3}\"";
	echo "DNS_SEARCH_DOMAIN = \"${DNS_SEARCH_DOMAIN}\"";
	echo "${DASHES}";

	# Create the eth0 config file (if it is a valid filepath yet doesnt exist)
	if [ -n "${FILE_ETH0_BUILDER}" ] && [ ! -f "${FILE_ETH0_BUILDER}" ]; then
		echo "";
		echo "Calling [echo \"\" > \"${FILE_ETH0_BUILDER}\";]...";
		echo "" > "${FILE_ETH0_BUILDER}";
	fi;

	DNS_SEARCH_DOMAIN="";
	THIS_HYPERVISOR="/sys/hypervisor/uuid";
	AWS_HV_STARTS_WITH="ec2";
	if [ -f "${THIS_HYPERVISOR}" ]; then
		if [[ "$(cat ${THIS_HYPERVISOR})" == "${AWS_HV_STARTS_WITH}"* ]] && [ -n "${DOMAIN}" ]; then
			DNS_SEARCH_DOMAIN="${DOMAIN}";
		fi;
	fi;

	DNS_LOOKUP_1=$(cat ${FILE_ETH0_BUILDER} | grep ${DNS_NAMESRVR_1});
	DNS_LOOKUP_2=$(cat ${FILE_ETH0_BUILDER} | grep ${DNS_NAMESRVR_2});
	DNS_LOOKUP_3=$(cat ${FILE_ETH0_BUILDER} | grep ${DNS_NAMESRVR_3});

	ACTION_DOMAIN_RESOLUTION="";
	DOMAIN_RESOLUTION_CONFIGURED="$(cat ${FILE_ETH0_BUILDER} | grep 'search ')";
	if [ -n "${DNS_SEARCH_DOMAIN}" ]; then
		DOMAIN_RESOLUTION_CONFIGURED="$(echo ${DOMAIN_RESOLUTION_CONFIGURED} | grep ${DNS_SEARCH_DOMAIN};)";
		if [ ! -n "${DOMAIN_RESOLUTION_CONFIGURED}" ]; then
			ACTION_DOMAIN_RESOLUTION="SET"; # Need to configure local domain-name resolution
		fi;
	fi;

	if [ -n "${DNS_LOOKUP_1}" ] && [ -n "${DNS_LOOKUP_2}" ] && [ -n "${DNS_LOOKUP_3}" ] && [ -n "${ACTION_DOMAIN_RESOLUTION}" ]; then # all variables are not null

		echo "";
		echo "\"${FILE_ETH0_BUILDER}\"'s DNS settings are up-to-date";
		
	else # at least one DNS-IP/Hostname is missing

		echo "";
		echo "Updating DNS Servers which build out of file \"${FILE_ETH0_BUILDER}\"";
		
		# "dns-search"
		if [ -n "${DNS_SEARCH_DOMAIN}" ] && [ "${ACTION_DOMAIN_RESOLUTION}" == "SET" ]; then
			#    verify if any line already contains the "dns-search" directive
			DNS_SEARCH_LINES_FOUND=$(cat "${FILE_ETH0_BUILDER}" | grep 'dns-search ' | wc -l);
			DOMAIN_BIND_TO_ETH0="${DNS_SEARCH_DOMAIN}";
			if [ "${DNS_SEARCH_LINES_FOUND}" == "0" ]; then
				# add the "dns-search" line
				echo "dns-search ${DOMAIN_BIND_TO_ETH0}" >>  "${FILE_ETH0_BUILDER}";
			else
				# modify the "dns-search" line
				SED_DNS_SEARCH="/^dns-search/c\dns-search ${DOMAIN_BIND_TO_ETH0}";
				sed --in-place --expression="${SED_DNS_SEARCH}" "${FILE_ETH0_BUILDER}";
			fi;

		else
			echo "";
			echo "Skipping Setting: Local domain-name resolution (${FILE_NETWORK_RESOLVER} setting 'search ...')";
			echo "Skip Reason: Required variable 'DNS_SEARCH_DOMAIN' is undefined/empty (holds domain-name string)";

		fi;
		
		
		# "dns-nameservers"
		#    verify if any line already contains the "dns-nameservers" directive
		DNS_NAMESERVER_LINES_FOUND=$(cat "${FILE_ETH0_BUILDER}" | grep 'dns-nameservers' | wc -l);
		DNS_BIND_TO_ETH0="${DNS_NAMESRVR_1} ${DNS_NAMESRVR_2} ${DNS_NAMESRVR_3}";
		if [ "${DNS_NAMESERVER_LINES_FOUND}" == "0" ]; then
			# add the "dns-nameservers" line
			echo "dns-nameservers ${DNS_BIND_TO_ETH0}" >> "${FILE_ETH0_BUILDER}";
		else
			# modify the "dns-nameservers" line
			SED_DNS_NAMESERVERS="/^dns-nameservers/c\dns-nameservers ${DNS_BIND_TO_ETH0}";
			sed --in-place --expression="${SED_DNS_NAMESERVERS}" "${FILE_ETH0_BUILDER}";
		fi;
		
		# take down the main network interface & bring it back up (in one statement)
		echo "";
		echo "Calling [ifdown -a && ifup -a;]...";
		echo "(takes down the main network interface & bring it back up, in one statement)...";
		echo "${DASHES}"; ifdown -a && ifup -a; echo "${DASHES}";
		
		# give the (virtual) NIC a few seconds to grab a connection
		sleep 5;
		
		# refresh the resolvconf DNS file
		echo "";
		echo "Calling [resolvconf -u]...";
		echo "${DASHES}"; resolvconf -u; echo "${DASHES}";
		echo "";
		
	fi;

	# verify the configuration tied to eth0
	echo "";
	echo "Calling [ifconfig eth0]...";
	echo "${DASHES}"; ifconfig eth0; echo "${DASHES}";

	# show the "/etc/network/interfaces/..." file, which should contain all DNS update logic
	echo "";
	echo "Calling [cat \"${FILE_ETH0_BUILDER}\"]";
	echo "${DASHES}"; cat "${FILE_ETH0_BUILDER}"; echo "${DASHES}";
	
fi;

# show "${FILE_NETWORK_RESOLVER}" file, which is the LIVE linux config-file (which is dynamically filled-in by network/interface configs)
echo "";
echo "Calling [cat \"${FILE_NETWORK_RESOLVER}\"]";
echo "${DASHES}"; cat "${FILE_NETWORK_RESOLVER}"; echo "${DASHES}";
