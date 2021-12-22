#!/bin/bash
# ------------------------------------------------------------
# Linux - sqlite3 (get schema for database table).sh
# ------------------------------------------------------------


TABLE_NAME="domainlist"; FULLPATH_DATABASE="/etc/pihole/gravity.db"; sqlite3 "${FULLPATH_DATABASE}" ".schema ${TABLE_NAME}";


# ------------------------------------------------------------
#
# Citation(s)
#
#   discourse.pi-hole.net  |  "V5.0 Docker, Whitelist domain, writing to readonly database - Help - Pi-hole Userspace"  |  https://www.sqlitetutorial.net/sqlite-tutorial/sqlite-describe-table/
#
#   www.sqlitetutorial.net  |  "SQLite Describe Table"  |  https://www.sqlitetutorial.net/sqlite-tutorial/sqlite-describe-table/
#
# ------------------------------------------------------------