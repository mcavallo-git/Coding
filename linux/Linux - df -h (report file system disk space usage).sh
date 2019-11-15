#!/bin/bash
if [[ 0 -eq 1 ]]; then
# ------------------------------------------------------------

df -h --output="source" | grep -v '^Filesystem';

# Get the fullpath to all mount-points
df -h --output="source" | sed '1!G;h;$!d' | head -n -1 | sed '1!G;h;$!d';

# Get the % disk-usage for all disk
df -h --output="pcent" | sed '1!G;h;$!d' | head -n -1 | sed '1!G;h;$!d' | sort -n | tail -1 | tr -d ' ';

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

# ------------------------------------------------------------
fi;
# ------------------------------------------------------------

shopt -s lastpipe; # extends the current shell into sub-shells (within piped-commands), sharing variables down-into them, as well

# ------------------------------------------------------------

# Das Essentials:

unset DISK_MOUNTPOINTS;  declare -A DISK_MOUNTPOINTS;  # [Re-]Instantiate bash array
unset DISK_USEDPERCENTS; declare -A DISK_USEDPERCENTS; # [Re-]Instantiate bash array
unset DISK_PARTITIONS;   declare -A DISK_PARTITIONS;  # [Re-]Instantiate bash array
unset DISK_FILESYSTEMS;  declare -A DISK_FILESYSTEMS;  # [Re-]Instantiate bash array

DOCKER_CONTAINER_IDS=$(docker ps --format "{{.ID}}");

i=0;

df -h --output="target,pcent,size,source" \
| sed '1!G;h;$!d' \
| head -n -1 \
| sed '1!G;h;$!d' \
| while read EACH_LINE; do

	i=$((i+1));

	EACH_MOUNTPOINT=$(echo "${EACH_LINE}" | awk '{print $1}');
	DISK_MOUNTPOINTS+=(["${i}"]="${EACH_MOUNTPOINT}");

	EACH_USED_PCT=$(echo "${EACH_LINE}" | awk '{print $2}');
	DISK_USEDPERCENTS+=(["${i}"]="${EACH_USED_PCT}");

	EACH_PARTITION=$(echo "${EACH_LINE}" | awk '{print $3}');
	DISK_PARTITIONS+=(["${i}"]="${EACH_PARTITION}");

	EACH_FILESYSTEM=$(echo "${EACH_LINE}" | awk '{print $4}');
	DISK_FILESYSTEMS+=(["${i}"]="${EACH_FILESYSTEM}");


done;

echo "${DISK_FILESYSTEMS[@]}";
j=0;
while [[ ${j} -le ${#DISK_MOUNTPOINTS[@]} ]]; do
	j=$((j+1));
	echo "${DISK_MOUNTPOINTS[${j}]}";
	echo "${DISK_USEDPERCENTS[${j}]}";
	echo "${DISK_PARTITIONS[${j}]}";
	echo "${DISK_FILESYSTEMS[${j}]}";
done;

# ------------------------------------------------------------
# Report file system's disk-usage w/ a case-statement
#

shopt -s lastpipe; # extends the current shell into sub-shells (within piped-commands), sharing variables down-into them, as well

unset DISK_STATS; declare -A DISK_STATS; # [Re-]Instantiate bash array

DISK_PCT_USED=`df -h --output="pcent" | sed '1!G;h;$!d' | head -n -1 | sed '1!G;h;$!d' | sort -n | tail -1 | tr -d ' ' | cut -d "%" -f1 -;`

case ${DISK_PCT_USED} in
[1-6]*)
  Message="Disk is ${DISK_PCT_USED}% Full - All is quiet."
  ;;
[7-8]*)
  Message="Disk is ${DISK_PCT_USED}% Full - Start thinking about cleaning out some stuff.  There's a partition that is $space % full."
  ;;
9[1-8])
  Message="Disk is ${DISK_PCT_USED}% Full - Better hurry with that new disk...  One partition is $space % full."
  ;;
99)
  Message="Disk is ${DISK_PCT_USED}% Full - I'm drowning here!  There's a partition at $space %!"
  ;;
*)
  Message="Disk is ${DISK_PCT_USED}% Full - I seem to be running with an nonexistent amount of disk space..."
  ;;
esac

echo $Message

# ------------------------------------------------------------
# Citation(s)
#
#   tldp.org  |  "7.3. Using case statements"  |  https://www.tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_03.html
#
# ------------------------------------------------------------

# ------------------------------------------------------------
# Citation(s)
#
#   community.hpe.com  |  "difference between filesystem and mountpoint"  |  https://community.hpe.com/t5/System-Administration/difference-between-filesystem-and-mountpoint/m-p/5260291#M52653
#
# ------------------------------------------------------------