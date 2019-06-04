#!/bin/bash

CONF_DISABLE_IPV6="/etc/sysctl.d/99-zero-ipv6-traffic.conf";

RELOAD_SYSCTL="";

if [ ! -f "${CONF_DISABLE_IPV6}" ]; then
	echo "$(date +'%Y-%m-%d %H:%M:%S') Creating sysctl file \"${CONF_DISABLE_IPV6}\"...";
	echo "" > "${CONF_DISABLE_IPV6}";
	RELOAD_SYSCTL="1";
fi;

DISABLE_IPV6_ALL="net.ipv6.conf.all.disable_ipv6 = 1";
DISABLE_IPV6_DEF="net.ipv6.conf.default.disable_ipv6 = 1";
DISABLE_IPV6_LO="net.ipv6.conf.lo.disable_ipv6 = 1";

GREP_IPV6_ALL=$(cat "${CONF_DISABLE_IPV6}" | grep "${DISABLE_IPV6_ALL}");
GREP_IPV6_DEF=$(cat "${CONF_DISABLE_IPV6}" | grep "${DISABLE_IPV6_DEF}");
GREP_IPV6_LO=$(cat "${CONF_DISABLE_IPV6}" | grep "${DISABLE_IPV6_LO}");

if [ -z "${GREP_IPV6_ALL}" ]; then
	echo "$(date +'%Y-%m-%d %H:%M:%S') Adding \"${DISABLE_IPV6_ALL}\" to sysctl file \"${CONF_DISABLE_IPV6}\"...";
	echo "${DISABLE_IPV6_ALL}" >> "${CONF_DISABLE_IPV6}";
	RELOAD_SYSCTL="1";
fi;

if [ -z "${GREP_IPV6_DEF}" ]; then
	echo "$(date +'%Y-%m-%d %H:%M:%S') Adding \"${DISABLE_IPV6_DEF}\" to sysctl file \"${CONF_DISABLE_IPV6}\"...";
	echo "${DISABLE_IPV6_DEF}" >> "${CONF_DISABLE_IPV6}";
	RELOAD_SYSCTL="1";
fi;

if [ -z "${GREP_IPV6_LO}" ]; then
	echo "$(date +'%Y-%m-%d %H:%M:%S') Adding \"${DISABLE_IPV6_LO}\" to sysctl file \"${CONF_DISABLE_IPV6}\"...";
	echo "${DISABLE_IPV6_LO}" >> "${CONF_DISABLE_IPV6}";
	RELOAD_SYSCTL="1";
fi;

# Read-in new values into sysctl service and also apply values on every boot henceforth
if [ -n "${RELOAD_SYSCTL}" ]; then
	chmod 0644 "${CONF_DISABLE_IPV6}";
	chown root:root "${CONF_DISABLE_IPV6}";
	sysctl --system;
fi;
