#!/bin/bash
# ------------------------------------------------------------
# Selinux - Get status

getenforce;

sestatus;  # Alternate-approach


# ------------------------------------------------------------
# Selinux - Disable

CONF_FILE="/etc/selinux/config"; if [ -f "${CONF_FILE}" ]; then sed --in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" -e "/^SELINUX=/c\SELINUX=disabled" "${CONF_FILE}"; fi; \
CONF_FILE="/etc/sysconfig/selinux"; if [ -f "${CONF_FILE}" ]; then sed --in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" -e "/^SELINUX=/c\SELINUX=disabled" "${CONF_FILE}"; fi; \
setenforce 0; \
echo "$(date +'%Y-%m-%d_%H-%M-%S')  |  Reboot required to finish disabling Selinux"; read -p " --> Reboot, now? (y/n)  " -n 1 -t 60 -r; if [[ $REPLY =~ ^[Yy]$ ]]; then reboot now; fi;


# ------------------------------------------------------------
# Selinux - Enable

CONF_FILE="/etc/selinux/config"; if [ -f "${CONF_FILE}" ]; then sed --in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" -e "/^SELINUX=/c\SELINUX=enforcing" "${CONF_FILE}"; fi; \
CONF_FILE="/etc/sysconfig/selinux"; if [ -f "${CONF_FILE}" ]; then sed --in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" -e "/^SELINUX=/c\SELINUX=enforcing" "${CONF_FILE}"; fi; \
setenforce 1; \
echo "$(date +'%Y-%m-%d_%H-%M-%S')  |  Reboot required to finish enabling Selinux"; read -p " --> Reboot, now? (y/n)  " -n 1 -t 60 -r; if [[ $REPLY =~ ^[Yy]$ ]]; then reboot now; fi;


# ------------------------------------------------------------
# Troubleshooting (example) - Check Selinux error logs specifically for lines mentioning 'nginx' and 'denied'
cat /var/log/audit/audit.log | grep -i nginx | grep -i denied;


# ------------------------------------------------------------
# Citation(s)
#
#   access.redhat.com  |  "Chapter 3. SELinux Contexts Red Hat Enterprise Linux 6 | Red Hat Customer Portal"  |  https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/security-enhanced_linux/chap-security-enhanced_linux-selinux_contexts
#
#   access.redhat.com  |  "5.6. SELinux Contexts – Labeling Files Red Hat Enterprise Linux 6 | Red Hat Customer Portal"  |  https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/security-enhanced_linux/sect-security-enhanced_linux-working_with_selinux-selinux_contexts_labeling_files
#
#   stackoverflow.com  |  "(13: Permission denied) while connecting to upstream:[nginx]"  |  https://stackoverflow.com/a/24830777
#
#   wiki.centos.org  |  "HowTos/SELinux - CentOS Wiki"  |  https://wiki.centos.org/HowTos/SELinux
#
#   www.nginx.com  |  "Modifying SELinux Settings for Full NGINX and NGINX Plus Functionality"  |  https://www.nginx.com/blog/using-nginx-plus-with-selinux/
#
# ------------------------------------------------------------