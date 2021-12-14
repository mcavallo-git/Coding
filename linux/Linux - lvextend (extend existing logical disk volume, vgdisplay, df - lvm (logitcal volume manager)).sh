#!/bin/bash
exit 1;
# ------------------------------------------------------------
#
# STEP 1 - List file system disks to get the full filepath to target volume
#


df -h "/home/";

#
### OUTPUT:
#
# Filesystem                         Size  Used Avail Use% Mounted on
# /dev/mapper/ubuntu--vg-ubuntu--lv   31G  6.4G   23G  22% /
#
###
#
#  ^--- We will be using [ /dev/mapper/ubuntu--vg-ubuntu--lv ] for this example
#


# ------------------------------------------------------------
#
# STEP 2 - List volumes to determine available free disk space
#


vgdisplay

#
### OUTPUT:
#
#  --- Volume group ---
#  VG Name               ubuntu-vg
#  System ID
#  Format                lvm2
#  Metadata Areas        1
#  Metadata Sequence No  2
#  VG Access             read/write
#  VG Status             resizable
#  MAX LV                0
#  Cur LV                1
#  Open LV               1
#  Max PV                0
#  Cur PV                1
#  Act PV                1
#  VG Size               <63.00 GiB
#  PE Size               4.00 MiB
#  Total PE              16127
#  Alloc PE / Size       8063 / <31.50 GiB
#  Free  PE / Size       8064 / 31.50 GiB
#  VG UUID               CNcWmx-pb86-wIkP-A2st-2eRO-U6Pg-kiVgg9
#
###
#
#  ^--- We only need the available "Free" space on the disk (to expand the volume to use)
#


vgdisplay | grep '^  Free';

#
### OUTPUT:
#
#  Free  PE / Size       8064 / 31.50 GiB
#
###
#
#  ^--- We will want to add 31.5G to the volume (to make use of the remaining free space in the partition)
#


# ------------------------------------------------------------
#
# STEP 3 - Extend the logical volume to use up available disk space
#


lvextend --size +31.5G /dev/mapper/ubuntu--vg-ubuntu--lv;

#
### OUTPUT:
#
#  Size of logical volume ubuntu-vg/ubuntu-lv changed from <31.50 GiB (8063 extents) to <63.00 GiB (16127 extents).
#  Logical volume ubuntu-vg/ubuntu-lv successfully resized.
#
###
#


# ------------------------------------------------------------
#
# STEP 4 - List volumes to verify that all disk space is used
#


vgdisplay

#
### OUTPUT:
#
#  --- Volume group ---
#  VG Name               ubuntu-vg
#  System ID
#  Format                lvm2
#  Metadata Areas        1
#  Metadata Sequence No  3
#  VG Access             read/write
#  VG Status             resizable
#  MAX LV                0
#  Cur LV                1
#  Open LV               1
#  Max PV                0
#  Cur PV                1
#  Act PV                1
#  VG Size               <63.00 GiB
#  PE Size               4.00 MiB
#  Total PE              16127
#  Alloc PE / Size       16127 / <63.00 GiB
#  Free  PE / Size       0 / 0
#  VG UUID               CNcWmx-pb86-wIkP-A2st-2eRO-U6Pg-kiVgg9
#
###
#


vgdisplay | grep '^  Free';

#
### OUTPUT:
#
#  Free  PE / Size       0 / 0
#
###
#
#  ^--- No free space remaining - we've extend the volume successfully!
#


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.linuxtechi.com  |  "How to Extend LVM Partition with lvextend command in Linux"  |  https://www.linuxtechi.com/extend-lvm-partitions/
#
# ------------------------------------------------------------