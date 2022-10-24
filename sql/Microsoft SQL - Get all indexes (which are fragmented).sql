-- ------------------------------------------------------------
--
--
-- Microsoft SQL (MSSQL) - Get fragmented indices (indexes)
--

SELECT
OBJECT_NAME(i.OBJECT_ID) AS TableName, i.name AS IndexName, indexstats.avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'DETAILED') indexstats
INNER JOIN sys.indexes i ON i.OBJECT_ID = indexstats.OBJECT_ID
WHERE i.index_id = indexstats.index_id;


-- ------------------------------------------------------------
--
-- Citation(s)
--
--   github.com  |  "Coding/sql at main · mcavallo-git/Coding · GitHub"  |  https://github.com/mcavallo-git/Coding/tree/main/sql
--
--   support.microsoft.com  |  "SQL query performance might decrease when the SQL Server Database instance has high index fragmentation"  |  https://support.microsoft.com/en-us/help/2755960/sql-query-performance-might-decrease-when-the-sql-server-database-inst
--
-- ------------------------------------------------------------