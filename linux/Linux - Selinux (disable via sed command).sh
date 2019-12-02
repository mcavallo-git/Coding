#!/bin/bash
sudo sed --in-place=".$(date +'%Y-%m-%d_%H-%M-%S').bak" -e "/^SELINUX=/c\SELINUX=disabled" "/etc/sysconfig/selinux";
