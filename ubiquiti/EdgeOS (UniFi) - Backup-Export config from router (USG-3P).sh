#!/bin/bash

sudo -i;


if [[ 1 -eq 1 ]]; then 

EXPORT_DIR="$(getent passwd ${SUDO_USER:-${USER}} | cut -d : -f 6)/backup.$(hostname).$(date +'%Y%m%d_%H%M%S')"; 

echo "Info:  Creating export directory \"${EXPORT_DIR}\""; mkdir -p "${EXPORT_DIR}"; 

mca-ctrl -t dump-cfg > "${EXPORT_DIR}/mca-ctrl -t dump-cfg.$(date +'%Y%m%d_%H%M%S').$(hostname).json"; 

show configuration commands > "${EXPORT_DIR}/show configuration commands.$(date +'%Y%m%d_%H%M%S').$(hostname).sh"; 

show configuration > "${EXPORT_DIR}/config.$(date +'%Y%m%d_%H%M%S').$(hostname).boot"; 

chown -R "${SUDO_USER:-${USER}}" "${EXPORT_DIR}"; 

chmod -R 0700 "${EXPORT_DIR}";

cd "${EXPORT_DIR}"; 

ls -al; 

fi;

