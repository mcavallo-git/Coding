#!/bin/bash
getenforce;
CONF_FILE="/etc/selinux/config"; if [ -f "${CONF_FILE}" ]; then sed --in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" -e "/^SELINUX=/c\SELINUX=disabled" "/etc/selinux/config"; fi; \
CONF_FILE="/etc/sysconfig/selinux"; if [ -f "${CONF_FILE}" ]; then sed --in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" -e "/^SELINUX=/c\SELINUX=disabled" "/etc/selinux/config"; fi; \
setenforce 0; \
echo "$(date +'%Y-%m-%d_%H-%M-%S')  |  Reboot required to finish disabling Selinux"; read -p " --> Reboot, now? (y/n)  " -n 1 -t 60 -r; if [[ $REPLY =~ ^[Yy]$ ]]; then reboot now; fi;
