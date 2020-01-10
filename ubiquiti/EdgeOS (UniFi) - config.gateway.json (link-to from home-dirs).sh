#!/bin/bash

# Define the common path for Unifi's "config.gateway.json" file on Debian distros (based on the 'unifi' Linux user)
UNIFI_HOMEDIR=$(getent passwd unifi | cut -d : -f 6);
CONFIG_GATEWAY_JSON="${UNIFI_HOMEDIR:-/usr/lib/unifi}/data/sites/default/config.gateway.json";

# Link the config.gateway.json to the sudoer's homedir (for expedited access/management)
test -n "${UNIFI_HOMEDIR}" && test -v HOME && ln -sf "${CONFIG_GATEWAY_JSON}" "${HOME}/config.gateway.json";

# Link the config.gateway.json to the sudoer's homedir (for expedited access/management)
test -n "${UNIFI_HOMEDIR}" && test -v SUDO_USER && SUDOER_HOMEDIR="$(getent passwd ${SUDO_USER} | cut -d : -f 6)" && ln -sf "${CONFIG_GATEWAY_JSON}" "${SUDOER_HOMEDIR}/config.gateway.json";

