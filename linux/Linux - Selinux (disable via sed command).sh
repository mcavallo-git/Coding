#!/bin/bash
sed --in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" -e "/^SELINUX=/c\SELINUX=disabled" "/etc/selinux/config"; \
sed --in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" -e "/^SELINUX=/c\SELINUX=disabled" "/etc/sysconfig/selinux"; \
echo "$(date +'%Y-%m-%d_%H-%M-%S')  |  REBOOT REQUIRED TO FINISH DISABLING SELINUX"; \
read -p " --> REBOOT NOW? (y/n)  " -n 1 -t 60 -r; if [[ $REPLY =~ ^[Yy]$ ]]; then reboot now; fi;
