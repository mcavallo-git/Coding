#!/bin/bash

ROLLBACK_IFS="${IFS}"; IFS=$'\n';
for EACH_LINE in "$(parted -lm 2>&1 | grep -i ^/ | grep unknown;)"; do
EACH_DISK_NAME=$(echo "${EACH_LINE}" | cut -d':' -f1;);
EACH_DISK_SIZE=$(echo "${EACH_LINE}" | cut -d':' -f2;);
EACH_PROTOCOL=$(echo "${EACH_LINE}" | cut -d':' -f3;);
EACH_SECTORSIZE_LOGICAL=$(echo "${EACH_LINE}" | cut -d':' -f4;);
EACH_SECTORSIZE_PHYSICAL=$(echo "${EACH_LINE}" | cut -d':' -f5;);
EACH_PARTITION_TABLE=$(echo "${EACH_LINE}" | cut -d':' -f6;);
EACH_DISK_NAME=$(echo "${EACH_LINE}" | cut -d':' -f7;);
EACH_UNKOWWN=$(echo "${EACH_LINE}" | cut -d':' -f8;);
echo "------------------------------------------------------------";
echo "EACH_DISK_NAME = [ ${EACH_DISK_NAME} ]";
echo "EACH_DISK_SIZE = [ ${EACH_FIELD_2} ]";
echo "EACH_PROTOCOL = [ ${EACH_FIELD_3} ]";
echo "EACH_SECTORSIZE_LOGICAL = [ ${EACH_SECTORSIZE_LOGICAL} ]";
echo "EACH_SECTORSIZE_PHYSICAL = [ ${EACH_SECTORSIZE_PHYSICAL} ]";
echo "EACH_PARTITION_TABLE = [ ${EACH_PARTITION_TABLE} ]";
echo "EACH_DISK_NAME = [ ${EACH_FIELD_7} ]";
echo "EACH_UNKOWWN = [ ${EACH_FIELD_8} ]";
done; IFS="${ROLLBACK_IFS}";


# ------------------------------------------------------------
#
# Citation(s)
#
#   linux.die.net  |  "parted(8): partition change program - Linux man page"  |  https://linux.die.net/man/8/parted
# Citation(s)
#
#   access.redhat.com  |  "Chapter 3. Overview of persistent naming attributes Red Hat Enterprise Linux 8 | Red Hat Customer Portal"  |  https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/managing_storage_devices/assembly_overview-of-persistent-naming-attributes_managing-storage-devices
#
# ------------------------------------------------------------