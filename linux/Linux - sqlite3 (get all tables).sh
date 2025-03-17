#!/bin/bash
# ------------------------------------------------------------
# Linux - sqlite3 (get all tables)
# ------------------------------------------------------------


TABLE_NAME="domainlist";
FULLPATH_DATABASE="/etc/pihole/gravity.db";
SQL_QUERY=".schema ${TABLE_NAME}";
sqlite3 "${FULLPATH_DATABASE}" "${SQL_QUERY}";


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "sql - How can I list the tables in a SQLite database file that was opened with ATTACH? - Stack Overflow"  |  https://stackoverflow.com/a/82899
#
# ------------------------------------------------------------