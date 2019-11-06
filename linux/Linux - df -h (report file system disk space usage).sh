#!/bin/bash

# df -h --output="source" | grep -v '^Filesystem'

# Get the fullpath to all disks mount-points
df -h --output="source" | sed '1!G;h;$!d' | head -n -1 | sed '1!G;h;$!d'; 

# Get the % disk-usage for all disk
$ df -h --output="pcent" | sed '1!G;h;$!d' | head -n -1 | sed '1!G;h;$!d' | sort -n | tail -1 | tr -d ' '


# df --output="KEY";  # VAL  (associated column-header)

df -h --output="source";  # "Filesystem"
df -h --output="fstype";  # "Type"
df -h --output="itotal";  # "Inodes"
df -h --output="iused";  # "IUsed"
df -h --output="iavail";  # "IFree"
df -h --output="ipcent";  # "IUse%"
df -h --output="size";  # "Size"
df -h --output="used";  # "Used"
df -h --output="avail";  # "Avail"
df -h --output="pcent";  # "Use%"
df -h --output="file";  # "File"
df -h --output="target";  # "Mounted on"

# ------------------------------------------------------------

# Essentials:
df -h --output="target,pcent,size,source";  # "Mounted on Use%  Size Filesystem"


# Essentials:

unset DISK_USED_PERCENTAGES; declare -A DISK_USED_PERCENTAGES; # Re-instantiate bash array
unset DISK_PARTITION_SIZES;  declare -A DISK_PARTITION_SIZES;  # Re-instantiate bash array
unset DISK_MOUNT_FULLPATHS;  declare -A DISK_MOUNT_FULLPATHS;  # Re-instantiate bash array

DOCKER_CONTAINER_IDS=$(docker ps --format "{{.ID}}");

CHOICE_KEY=0;
for EACH_CONTAINER_ID in ${DOCKER_CONTAINER_IDS[@]}; do

df -h --output="target,pcent,size,source" \
| sed '1!G;h;$!d' \
| head -n -1 \
| sed '1!G;h;$!d' \
| while read EACH_LINE; do
MOUNT_ echo "${EACH_LINE}";
echo "------------------------------------------------------------";


done;












