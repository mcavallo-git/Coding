/*
------------------------------------------------------------

Microsoft T-SQL
    Backing-up and restoring Microsoft SQL (T-SQL) databases

------------------------------------------------------------
*/

/* Backup T-SQL Database to Disk via SQL Command(s) */
/*  !!!  DO NOT WRAP DB-NAME QUOTES,   !!!  */
/*  !!!  ONLY USE SINGLE-QUOTES TO WRAP THE OUTPUT FILEPATH (STRING) - DO NOT USE DOUBLE QUOTES  !!!  */

BACKUP DATABASE DatabaseName TO DISK='DatabaseNameCopyOnly.bak' WITH COPY_ONLY;


/*
------------------------------------------------------------

Manual Backup Method via Microsoft SSMS (SQL Server Management Studio)

    In SSMS, Right-click your database, select "Tasks" > "Back Up..." > check "Copy-only backup" (middle of popup window) > Click "Add" (bottom-right) and locate your desired export directory > Cli

    If migrating the database(s) off-machine, use the "Copy-only backup" option, which should (when checked) activate the "SIMPLE" Removery model

    Refer to Microsoft's documentation for T-SQL Database Backup & Recovers  @  https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/quickstart-backup-restore-database?view=sql-server-ver15&viewFallbackFrom=sql-server-2014

------------------------------------------------------------
*/


/*
----------------------------------------------------------

Citation(s)

    docs.microsoft.com  |  "Backup Devices (SQL Server) - SQL Server 2014 | Microsoft Docs"  |  https://docs.microsoft.com/en-au/sql/relational-databases/backup-restore/backup-devices-sql-server?view=sql-server-2014

    docs.microsoft.com  |  "Copy-Only Backups (SQL Server) - SQL Server 2014 | Microsoft Docs"  |  https://docs.microsoft.com/en-au/sql/relational-databases/backup-restore/copy-only-backups-sql-server?view=sql-server-2014

    docs.microsoft.com  |  "Quickstart: Back up & restore database - SQL Server | Microsoft Docs"  |  https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/quickstart-backup-restore-database?view=sql-server-ver15&viewFallbackFrom=sql-server-2014

----------------------------------------------------------
*/

