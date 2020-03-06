#!/bin/bash
# ------------------------------------------------------------
# Parted - Create a new partition
#

# Determine partition's disk-size (based on start- & end-bytes)
for EACH_DEVICE in /dev/sd? ; do parted -m "${EACH_DEVICE}" unit B print; done;
#  |--> Set start-byte to 1 byte past the LAST partition's end-byte (in B)
#  |--> Set end-byte to the total disk size (in B)
#
### EXAMPLE --> for EACH_DEVICE in /dev/sd? ; do parted -m "${EACH_DEVICE}" unit B print; done;
#
# BYT;
# /dev/sda:429496729600B:scsi:512:512:msdos:VMware Virtual disk:;
# 1:1048576B:1074790399B:1073741824B:xfs::boot;
# 2:1074790400B:107374182399B:106299392000B:::lvm;
#
# ^-- Device name is '/dev/sda' (based on the header line's FIRST value of "/dev/sda)"
#      |--> DEVICE="/dev/sda";
#
# ^-- Total disk size is 400GB disk (based on the '/dev/sda ...' line's SECOND value, "429496729600B")
#      |--> END_BYTE="429496729600B";
#
# ^-- The second (and last) currently-existent partition ends at byte 107374182399, so start new partition just after on 107374182399+1 (based on the '1:...' line's THIRD value, "1074790399B")
#      |--> START_BYTE="107374182400B";
#
# ^-- The filesystem type for the currently boot partition on this device is "xfs" (based on the '1:...' line's FIFTH value, "xfs")
#      |--> FS_TYPE="xfs";
#

#
# Determine partition-type based-on currently-existent partition types
# !!! AUTOMATICALLY DONE VIA SCRIPT, BELOW !!!
#  |--> parted "/dev/sda" "print";  # Or without targeting a specific device:   parted -l;
#        |--> If target disk's "Partition Table" has value "msdos", then it is formatted using MBR, so use "primary" partition type
#        |--> If target disk's "Partition Table" has value "gpt", then it is formatted using GPT, so use "logical" partition type
#

if [ 1 -eq 1 ]; then
DEVICE="/dev/sda";
START_BYTE="107374182400B";
END_BYTE="429496729600B";
FS_TYPE="xfs";
PART_TYPE="primary"; if [ $(parted "${DEVICE}" print | grep '^Partition Table:' | grep 'gpt' 1>/dev/null 2>&1; echo $?;) -eq 0 ]; then PART_TYPE="logical"; fi;
echo "";
echo "Calling  [ parted \"${DEVICE}\" mkpart \"${PART_TYPE}\" \"${FS_TYPE}\" \"${START_BYTE}\" \"${END_BYTE}\"; ]  ...";
parted "${DEVICE}" mkpart "${PART_TYPE}" "${FS_TYPE}" "${START_BYTE}" "${END_BYTE}";
echo "";
echo "Calling  [ df -h | grep -v '^tmp' | grep -v '^dev'; ]  ...";
df -h | grep -v '^tmp' | grep -v '^dev';
echo "";
fi;


# ------------------------------------------------------------
# Resize a given partition

### REFER TO:  https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/storage_administration_guide/s2-disk-storage-parted-resize-part


# ------------------------------------------------------------
# Partition un-partitioned disk(s)

### UNDER CONSTRUCTION AS-OF 20200305-225420  -->  wget "https://raw.githubusercontent.com/mcavallo-git/cloud-infrastructure/master/usr/local/sbin/partition_unpartitioned_disks" -O "/usr/local/sbin/partition_unpartitioned_disks" -q && chmod 0755 "/usr/local/sbin/partition_unpartitioned_disks" && /usr/local/sbin/partition_unpartitioned_disks;


# ------------------------------------------------------------
# Additional disk-info packages/commands/tools

# Determine FS (filesystem) type based on existing filesystem(s)
df -h --output="source,fstype" | grep -v '^tmp' | grep -v '^dev';

lsblk -p -n -o KNAME,TYPE,MOUNTPOINT;

fdisk -l | grep sectors | grep '^Disk';

# Get filesystem-type(s) for the current system
df -h --output="source,fstype";
lsblk -fp;


# ------------------------------------------------------------
#
# Citation(s)
#
#   access.redhat.com  |  "Chapter 7. Kernel crash dump guide Red Hat Enterprise Linux 7 | Red Hat Customer Portal"  |  https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/kernel_administration_guide/kernel_crash_dump_guide
#
#   access.redhat.com  |  "13.4. Resizing a Partition Red Hat Enterprise Linux 6 | Red Hat Customer Portal"  |  https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/storage_administration_guide/s2-disk-storage-parted-resize-part
#
#   help.ubuntu.com  |  "Kernel Crash Dump"  |  https://help.ubuntu.com/lts/serverguide/kernel-crash-dump.html
#
#   linux.die.net  |  "parted(8): partition change program - Linux man page"  |  https://linux.die.net/man/8/parted
#
#   opensource.com  |  "How to partition a disk in Linux | Opensource.com"  |  https://opensource.com/article/18/6/how-partition-disk-linux
#
#   stackoverflow.com  |  "linux - How to make parted always show the same unit - Stack Overflow"  |  https://stackoverflow.com/a/6428709
#
#   wiki.archlinux.org  |  "Parted - ArchWiki"  |  https://wiki.archlinux.org/index.php/Parted
#
#   www.thegeekdiary.com  |  "How To Create a Partition Using “parted” Command – The Geek Diary"  |  https://www.thegeekdiary.com/how-to-create-a-partition-using-parted-command/
#
# ------------------------------------------------------------