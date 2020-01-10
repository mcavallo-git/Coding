#!/bin/bash

# Define the common path for Unifi's "config.gateway.json" file on Debian distros (based on the 'unifi' Linux user)
UNIFI_HOMEDIR=$(getent passwd unifi | cut -d : -f 6);
CONFIG_DIR_1="${UNIFI_HOMEDIR:-/usr/lib/unifi}/sites/default";
CONFIG_DIR_2="${UNIFI_HOMEDIR:-/usr/lib/unifi}/data/sites/default";
CONFIG_GATEWAY_JSON_1="${CONFIG_DIR_1}/config.gateway.json";
CONFIG_GATEWAY_JSON_2="${CONFIG_DIR_2}/config.gateway.json";

# Link to the first-located site & it's designated config.gateway.json path
test -n "${UNIFI_HOMEDIR}" && test -d "${CONFIG_DIR_1}" && test -v HOME && ln -sf "${CONFIG_GATEWAY_JSON_1}" "${HOME}/config.gateway.json";
test -n "${UNIFI_HOMEDIR}" && test -d "${CONFIG_DIR_1}" && test -v SUDO_USER && SUDOER_HOMEDIR="$(getent passwd ${SUDO_USER} | cut -d : -f 6)" && ln -sf "${CONFIG_GATEWAY_JSON_1}" "${SUDOER_HOMEDIR}/config.gateway.json";

test -n "${UNIFI_HOMEDIR}" && test -d "${CONFIG_DIR_2}" && test -v HOME && ln -sf "${CONFIG_GATEWAY_JSON_2}" "${HOME}/config.gateway.json";
test -n "${UNIFI_HOMEDIR}" && test -d "${CONFIG_DIR_2}" && test -v SUDO_USER && SUDOER_HOMEDIR="$(getent passwd ${SUDO_USER} | cut -d : -f 6)" && ln -sf "${CONFIG_GATEWAY_JSON_2}" "${SUDOER_HOMEDIR}/config.gateway.json";
