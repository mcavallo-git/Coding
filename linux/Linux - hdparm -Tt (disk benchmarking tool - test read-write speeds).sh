#!/bin/bash

DISK_PATH=$(lsblk | grep disk | awk '{print $1}';);

hdparm -Tt "/dev/${DISK_PATH}";


# ------------------------------------------------------------
#
# Citation(s)
#
#   askubuntu.com  |  "How to check hard disk performance - Ask Ubuntu"  |  https://askubuntu.com/a/87036
#
# ------------------------------------------------------------