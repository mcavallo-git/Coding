#!/bin/bash

ROLLBACK_IFS="${IFS}"; IFS=$'\n';
for EACH_LINE in "$(parted -lm 2>&1 | grep -i ^/ | grep unknown;)"; do
EACH_DISK_NAME=$(echo "${EACH_LINE}" | cut -d':' -f1;);
EACH_DISK_SIZE=$(echo "${EACH_LINE}" | cut -d':' -f2;);
EACH_PROTOCOL=$(echo "${EACH_LINE}" | cut -d':' -f3;);
EACH_SECTORSIZE_LOGICAL=$(echo "${EACH_LINE}" | cut -d':' -f4;);
EACH_SECTORSIZE_PHYSICAL=$(echo "${EACH_LINE}" | cut -d':' -f5;);
EACH_PARTITION_TABLE=$(echo "${EACH_LINE}" | cut -d':' -f6;);
EACH_DISK_DESCRIPTION=$(echo "${EACH_LINE}" | cut -d':' -f7;);
EACH_UNKOWWN=$(echo "${EACH_LINE}" | cut -d':' -f8;);
echo "------------------------------------------------------------";
echo "EACH_DISK_NAME = [ ${EACH_DISK_NAME} ]";
echo "EACH_DISK_SIZE = [ ${EACH_FIELD_2} ]";
echo "EACH_PROTOCOL = [ ${EACH_FIELD_3} ]";
echo "EACH_SECTORSIZE_LOGICAL = [ ${EACH_SECTORSIZE_LOGICAL} ]";
echo "EACH_SECTORSIZE_PHYSICAL = [ ${EACH_SECTORSIZE_PHYSICAL} ]";
echo "EACH_PARTITION_TABLE = [ ${EACH_PARTITION_TABLE} ]";
echo "EACH_DISK_DESCRIPTION = [ ${EACH_FIELD_7} ]";
echo "EACH_UNKOWWN = [ ${EACH_FIELD_8} ]";
done; IFS="${ROLLBACK_IFS}";

exit 0;


# ------------------------------------------------------------
# Partition un-partitioned disk(s)
ROLLBACK_IFS="${IFS}"; IFS=$'\n';
for EACH_LINE in $(parted -lm 2>&1 | grep -i ^/;); do \
EACH_DISK_DEVICE=$(echo "${EACH_LINE}" | cut -d':' -f1;);
EACH_DISK_SIZE=$(echo "${EACH_LINE}" | cut -d':' -f2;);
EACH_PARTITION_TABLE=$(echo "${EACH_LINE}" | cut -d':' -f6;);
if [ "${EACH_PARTITION_TABLE}" == "unknown" ]; then
	echo "Partitioning  [  ${EACH_DISK_DEVICE}  ]  as 'msdos'...";
	parted "${EACH_DISK_DEVICE}" mklabel 'msdos';
else
	echo "Skipping device  [  ${EACH_DISK_DEVICE}  ]  (already partitioned as ${EACH_PARTITION_TABLE})"
fi;
done; IFS="${ROLLBACK_IFS}";


# ------------------------------------------------------------
# Resize a given partition

### REFER TO:  https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/storage_administration_guide/s2-disk-storage-parted-resize-part


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
# ------------------------------------------------------------