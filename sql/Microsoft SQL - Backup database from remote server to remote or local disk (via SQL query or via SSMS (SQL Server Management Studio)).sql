
/* Microsoft SQL (MSSQL) - Backup database from remote server to remote or local disk (via SQL query or via SSMS (SQL Server Management Studio)) */

-- ------------------------------------------------------------

/*
Manual Method 1 --> Manual Backup Method via Microsoft SSMS (SQL Server Management Studio)

  > In SSMS, Right-click your database, select "Tasks" > "Back Up..." > check "Copy-only backup" (middle of popup window) > Click "Add" (bottom-right) and locate your desired export directory > Cli

  > If migrating the database(s) off-machine, use the "Copy-only backup" option, which should (when checked) activate the "SIMPLE" Removery model

  > Refer to Microsoft's documentation for T-SQL Database Backup & Recovers  @  https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/quickstart-backup-restore-database?view=sql-server-ver15&viewFallbackFrom=sql-server-2014


Manual Method 2 --> Creating a database backup of a remote server (or schema) to local workstation (via SSMS - SQL Server Management Studio)

  > Refer to Citation "How can I backup a remote SQL Server database to a local drive? - Stack Overflow" - https://stackoverflow.com/a/9141964

*/


-- ------------------------------------------------------------

/*
Scripted Backup Method --> Backup database to disk (via SQL command(s))

!!!  WORK IN-PROGRESS - Couldn't, yet get it to work as-intended  !!!

!!!  Note:  DO NOT WRAP DB-NAME QUOTES   !!!

!!!  Note:  ONLY USE SINGLE-QUOTES TO WRAP THE OUTPUT FILEPATH (STRING) - DO NOT USE DOUBLE QUOTES  !!!

!!! Note: The default location is stored in the BackupDirectory registry key under HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL.YourDbName\MSSQLServer.  (quoted from Microsoft)

BACKUP DATABASE DATABASE_NAME_HERE TO DISK='DATABASE_FILENAME.bak' WITH COPY_ONLY;
*/


-- ------------------------------------------------------------
--
-- Citation(s)
--
--   docs.microsoft.com  |  "Backup Devices (SQL Server) - SQL Server 2014 | Microsoft Docs"  |  https://docs.microsoft.com/en-au/sql/relational-databases/backup-restore/backup-devices-sql-server?view=sql-server-2014
--
--   docs.microsoft.com  |  "Copy-Only Backups (SQL Server) - SQL Server 2014 | Microsoft Docs"  |  https://docs.microsoft.com/en-au/sql/relational-databases/backup-restore/copy-only-backups-sql-server?view=sql-server-2014
--
--   docs.microsoft.com  |  "Quickstart: Back up & restore database - SQL Server | Microsoft Docs"  |  https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/quickstart-backup-restore-database?view=sql-server-ver15&viewFallbackFrom=sql-server-2014
--
--   github.com  |  "Coding/sql at master · mcavallo-git/Coding · GitHub"  |  https://github.com/mcavallo-git/Coding/tree/master/sql
--
--   stackoverflow.com  |  "How can I backup a remote SQL Server database to a local drive? - Stack Overflow"  |  https://stackoverflow.com/a/9141964
--
-- ------------------------------------------------------------