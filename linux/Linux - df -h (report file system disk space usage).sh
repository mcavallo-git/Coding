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

# Das Essentials:
df -h --output="target,pcent,size,source";  # "Mounted on Use%  Size Filesystem"

shopt -s lastpipe; # extends the current shell into sub-shells (within piped-commands), sharing variables down-into them, as well


# ------------------------------------------------------------

# Das Essentials:

unset DISK_USEDPERCENTS; declare -A DISK_USEDPERCENTS; # Re-instantiate bash array
unset DISK_FILESYSTEMS;  declare -A DISK_FILESYSTEMS;  # Re-instantiate bash array
unset DISK_MOUNTPOINTS;  declare -A DISK_MOUNTPOINTS;  # Re-instantiate bash array

DOCKER_CONTAINER_IDS=$(docker ps --format "{{.ID}}");

CHOICE_KEY=0;

df -h --output="target,pcent,size,source" \
| sed '1!G;h;$!d' \
| head -n -1 \
| sed '1!G;h;$!d' \
| while read EACH_LINE; do
	CHOICE_KEY=$((CHOICE_KEY+1));
	MOUNTPOINT echo "${EACH_LINE}";
	echo "------------------------------------------------------------";


done;


# ------------------------------------------------------------
# Citation(s)
#
#   community.hpe.com  |  "difference between filesystem and mountpoint"  |  https://community.hpe.com/t5/System-Administration/difference-between-filesystem-and-mountpoint/m-p/5260291#M52653
#
# ------------------------------------------------------------