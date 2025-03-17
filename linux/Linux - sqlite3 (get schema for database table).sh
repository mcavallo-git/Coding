#!/bin/bash
# ------------------------------------------------------------
# Linux - sqlite3 (get schema for database table)
# ------------------------------------------------------------


FULLPATH_DATABASE="/etc/pihole/gravity.db";
SQL_QUERY=".tables";
sqlite3 "${FULLPATH_DATABASE}" "${SQL_QUERY}";


# ------------------------------------------------------------
#
# Citation(s)
#
#   discourse.pi-hole.net  |  "V5.0 Docker, Whitelist domain, writing to readonly database - Help - Pi-hole Userspace"  |  https://www.sqlitetutorial.net/sqlite-tutorial/sqlite-describe-table/
#
#   www.sqlitetutorial.net  |  "SQLite Describe Table"  |  https://www.sqlitetutorial.net/sqlite-tutorial/sqlite-describe-table/
#
# ------------------------------------------------------------