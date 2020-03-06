#!/bin/bash
# ------------------------------------------------------------
# Show disk info


lsblk -p -n -o KNAME,TYPE,MOUNTPOINT;


fdisk -l | grep sectors | grep '^Disk';


# Get filesystem-type(s) for the current system
df -h --output="source,fstype";
lsblk -fp;


# List partition beginning/end points
for hdd in /dev/sd? ; do parted -m $hdd unit B print; done;


# ------------------------------------------------------------
# Create a new partition
#
###  mkpart part-type [fs-type] start end
#
###  mklabel label-type
#

DEVICE="/dev/sda";
PART_TYPE="logical";
FS_TYPE="xfs";
START_BYTE="";
END_BYTE=""
parted "${DEVICE}" mkpart "${PART_TYPE}" "${FS_TYPE}" "1GiB" "8GiB";

# parted "/dev/sda" mklabel "gpt" "mkpart" "${PART_TYPE}" "${FS_TYPE}" "1GiB" "8GiB";


# ------------------------------------------------------------
# Resize a given partition

### REFER TO:  https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/storage_administration_guide/s2-disk-storage-parted-resize-part


# ------------------------------------------------------------
# Partition un-partitioned disk(s)

### UNDER CONSTRUCTION AS-OF 20200305-225420  -->  wget "https://raw.githubusercontent.com/mcavallo-git/cloud-infrastructure/master/usr/local/sbin/partition_unpartitioned_disks" -O "/usr/local/sbin/partition_unpartitioned_disks" -q && chmod 0755 "/usr/local/sbin/partition_unpartitioned_disks" && /usr/local/sbin/partition_unpartitioned_disks;


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