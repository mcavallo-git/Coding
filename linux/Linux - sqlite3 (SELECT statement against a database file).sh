#!/bin/sh

# NOTE: The following commands are for managing a FreeNAS MySQL database which exists at path "/data/freenas-v1.db" (Active Directory management)
#       To target a different db, change the "/data/freenas-v1.db" string to match the path to your respective database

# FreeNAS - Show all table names
sqlite3 "/data/freenas-v1.db" "SELECT name from sqlite_master where type='table';";

# FreeNAS - Show all columns in a given table
sqlite3 "/data/freenas-v1.db" "PRAGMA table_info(directoryservice_activedirectory);";

# FreeNAS - Show values defined in current Active Directory settings
sqlite3 "/data/freenas-v1.db" "SELECT * from directoryservice_activedirectory;";


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.sqlite.org  |  "Command Line Shell For SQLite"  |  https://www.sqlite.org/cli.html
#
#   stackoverflow.com  |  "sqlite - How to get a list of column names on Sqlite3 database? - Stack Overflow"  |  https://stackoverflow.com/questions/947215/how-to-get-a-list-of-column-names-on-sqlite3-database
#
# ------------------------------------------------------------