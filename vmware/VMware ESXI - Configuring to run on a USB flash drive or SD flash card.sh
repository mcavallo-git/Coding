#!/bin/sh
exit 1;
# ------------------------------------------------------------
#
# "Limitation when installing on USB flash drive or SD flash card:"
#   |
#   |--> "Due to the I/O sensitivity of USB and SD devices the installer does not create a scratch partition on these devices. When installing on USB or SD devices, the installer attempts to allocate a scratch region on an available local disk or datastore. If no local disk or datastore is found, /scratch is placed on the ramdisk. After the installation, you should reconfigure /scratch to use a persistent datastore. For more information, see Creating a persistent scratch location for ESXi 4.x and 5.x (1033696). VMware recommends using a retail purchased USB flash drive of 16 GB or larger so that the "extra" flash cells can prolong the life of the boot media but high quality parts of 4 GB or larger are sufficient to hold the extended coredump partition."  ( from https://kb.vmware.com/s/article/2004784 )
#


if [ 1 -eq 1 ]; then
# Backup the current config before making changes to it
cp -v "/bootbank/boot.cfg" /"bootbank/boot.$(date +'%Y%m%dT%H%M%S';).bak.cfg";
# Apply USB flash drive optimizations starting at next restart of ESXi host
FIND_REGEX="^kernelopt=.*$";
REPLACE_WITH="kernelopt=autoPartition=TRUE skipPartitioningSsds=TRUE autoPartitionCreateUSBCoreDumpPartition=TRUE allowCoreDumpOnUsb=TRUE";
sed -re "s/${FIND_REGEX}/${REPLACE_WITH}/i" -i "/bootbank/boot.cfg";
fi;


# ------------------------------------------------------------
#
# Citation(s)
#
#   kb.vmware.com  |  "Installing ESXi on a supported USB flash drive or SD flash card (2004784)"  |  https://kb.vmware.com/s/article/2004784
#
# ------------------------------------------------------------