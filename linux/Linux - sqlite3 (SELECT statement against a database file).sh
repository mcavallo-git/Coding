#!/bin/sh

# NOTE: The following commands are for managing a FreeNAS MySQL database which exists at path "/data/freenas-v1.db"
#       To target a different db, change the "/data/freenas-v1.db" string to match the path to your respective database

# SQLite3 - Show all table names
sqlite3 "/data/freenas-v1.db" "SELECT name from sqlite_master where type='table';";

# SQLite3 - Show all columns in a given table (FreeNAS Active Directory Management)
sqlite3 "/data/freenas-v1.db" "PRAGMA table_info(directoryservice_activedirectory);";

# SQLite3 - Show all rows in a given table (FreeNAS Active Directory Management)
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