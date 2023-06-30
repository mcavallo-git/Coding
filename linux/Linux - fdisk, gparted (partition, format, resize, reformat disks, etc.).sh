#!/bin/bash
# ------------------------------------------------------------
#
#   INSTALLATION
#

sudo apt-get -y update; sudo apt-get -y install fdisk;


# ------------------------------------------------------------
#
#   LISTING
#

# Get attached disk(s)
fdisk -l | grep -i 'sectors$' | grep -i '^disk' | grep -v '/dev/loop';  # Ignore '/dev/loop*' (Ubuntu Snap) mounted images


# ------------------------------------------------------------
#
#   PARTITIONING
#

fdisk /dev/sdb

# Type 'n' > Enter

# fdisk's built-in wizard will walk you creating a partition

# Type 'w' > Enter to save changes at the end


# ------------------------------------------------------------
#
#   FORMATTING
#

# Install pre-req package(s)
yum -y install epel-release; yum -y install gparted;

gparted /dev/sdb1;


##   !!!   DESKTOP VERSION OF LINUX IS REQUIRED TO USE GPARTED   !!!   ##


# ------------------------------------------------------------
#
# Citation(s)
#
#   askubuntu.com  |  "loop device - What is /dev/loopx? - Ask Ubuntu"  |  https://askubuntu.com/a/906685
#
#   devconnected.com  |  "How To Create Disk Partitions on Linux – devconnected"  |  https://devconnected.com/how-to-create-disk-partitions-on-linux/
#
#   www.cyberciti.biz  |  "How To Install EPEL Repo on a CentOS and RHEL 7.x - nixCraft"  |  https://www.cyberciti.biz/faq/installing-rhel-epel-repo-on-centos-redhat-7-x/
#
# ------------------------------------------------------------