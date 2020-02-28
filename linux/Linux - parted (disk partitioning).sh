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


# ------------------------------------------------------------
#
# Citation(s)
#
#   linux.die.net  |  "parted(8): partition change program - Linux man page"  |  https://linux.die.net/man/8/parted
#
# ------------------------------------------------------------