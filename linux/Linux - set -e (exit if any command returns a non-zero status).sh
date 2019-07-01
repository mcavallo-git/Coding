#!/bin/bash
#
# set
#     -x     Print commands and their arguments as they are executed.
#     -u     Treat unset variables as an error when substituting.
#     -e     Exit immediately if a command exits with a non-zero status.
#
# ------------------------------------------------------------

set -xue;

DIR_EXPORTS="/root/mysql_bak";

MYSQL_EXPORT_PROD="${DIR_EXPORTS}/export_prod.sql";
MYSQL_EXPORT_DEV="${DIR_EXPORTS}/export_dev_$(date +'%Y%m%d_%H%M%S').sql";

mkdir -p "${DIR_EXPORTS}/";
cp "${MYSQL_EXPORT_PROD}" "${MYSQL_EXPORT_DEV}";

DB_NAME_PROD="database_prod";
DB_NAME_DEV="database_dev";

DASHES="---------------------------";

# fill test-file with mock data
echo "";
echo "Populating \"${MYSQL_EXPORT_DEV}\" with mock data";
echo " " > "${MYSQL_EXPORT_DEV}";
echo "  -- REPLACE DB-NAME: \`${DB_NAME_PROD}\`  " >> "${MYSQL_EXPORT_DEV}";
echo "  -- WITH THIS DB-NAME: \`${DB_NAME_PROD}\`  " >> "${MYSQL_EXPORT_DEV}";
echo "  -- SELECT * FROM \`${DB_NAME_PROD}\`.${DB_NAME_PROD}s WHERE ...  " >> "${MYSQL_EXPORT_DEV}";
echo "  -- SELECT * FROM \`${DB_NAME_DEV}\`.${DB_NAME_PROD}s WHERE ...  " >> "${MYSQL_EXPORT_DEV}";
echo " " >> "${MYSQL_EXPORT_DEV}";

# setup sed text-replacement
SED_UPDATE='s|`'"${DB_NAME_PROD}"'`|`'"${DB_NAME_DEV}"'`|g';

# show file before sed
echo ""; echo "Calling [cat \"${MYSQL_EXPORT_DEV}\"]"; echo "${DASHES}"; cat "${MYSQL_EXPORT_DEV}"; echo "${DASHES}";

# perform sed to replace substrings in file
echo ""; echo "Calling [sed -i -e \"${SED_UPDATE}\" \"${MYSQL_EXPORT_DEV}\"]";
sed -i -e "${SED_UPDATE}" "${MYSQL_EXPORT_DEV}"; ERRCD="${?}"; if [ "${ERRCD}" -ne "0" ]; then echo "sed error ${ERRCD}"; exit "${ERRCD}"; fi;

# show error status
CURRENT_ERROR_STATUS="${?}"; echo ""; echo "CURRENT_ERROR_STATUS = \$\? = \"${CURRENT_ERROR_STATUS}\"";

# show file after sed
echo ""; echo "Calling [cat \"${MYSQL_EXPORT_DEV}\"]"; echo "${DASHES}"; cat "${MYSQL_EXPORT_DEV}"; echo "${DASHES}";

# remove sed-target then perform sed on missing file, then fail-out
echo ""; echo "Calling [rm -f \"${MYSQL_EXPORT_DEV}\"]"; rm -f "${MYSQL_EXPORT_DEV}";
echo ""; echo "Calling [sed -i -e \"${SED_UPDATE}\" \"${MYSQL_EXPORT_DEV}\"]";
sed -i -e "${SED_UPDATE}" "${MYSQL_EXPORT_DEV}"; ERRCD="${?}"; if [ "${ERRCD}" -ne "0" ]; then echo "sed error ${ERRCD}"; exit "${ERRCD}"; fi;

echo "You shouldn't ever get to this line - This script should always error out before getting here";
