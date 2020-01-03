#!/bin/bash
getenforce; \
CONF_FILE="/etc/selinux/config"; if [ -f "${CONF_FILE}" ]; then sed --in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" -e "/^SELINUX=/c\SELINUX=disabled" "${CONF_FILE}"; fi; \
CONF_FILE="/etc/sysconfig/selinux"; if [ -f "${CONF_FILE}" ]; then sed --in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" -e "/^SELINUX=/c\SELINUX=disabled" "${CONF_FILE}"; fi; \
setenforce 0; \
echo "$(date +'%Y-%m-%d_%H-%M-%S')  |  Reboot required to finish disabling Selinux"; read -p " --> Reboot, now? (y/n)  " -n 1 -t 60 -r; if [[ $REPLY =~ ^[Yy]$ ]]; then reboot now; fi;


### Check Selinux error logs specifically for lines mentioning 'nginx' and 'denied'
cat /var/log/audit/audit.log | grep -i nginx | grep -i denied;


# ------------------------------------------------------------
# Citation(s)
#
#   stackoverflow.com  |  "(13: Permission denied) while connecting to upstream:[nginx]"  |  https://stackoverflow.com/a/24830777
#
# ------------------------------------------------------------