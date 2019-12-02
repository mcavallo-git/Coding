#!/bin/bash
sudo sed --in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" -e "/^SELINUX=/c\SELINUX=disabled" "/etc/sysconfig/selinux";

echo "$(date +'%Y-%m-%d_%H-%M-%S')  |  REBOOT REQUIRED TO FINISH DISABLING SELINUX";
