-- ------------------------------------------------------------
--
-- Microsoft SQL (MSSQL) - Get indexes (by table)
--

SELECT
  OBJECT_NAME(object_id) As Table_Name,
  *
FROM
  sys.indexes
WHERE
  is_hypothetical = 0
  AND index_id != 0
  AND OBJECT_NAME(object_id) = 'TABLE_NAME'
;


-- ----------------------------------------------------------
--
-- Citation(s)
--
--   github.com  |  "Coding/sql at main · mcavallo-git/Coding · GitHub"  |  https://github.com/mcavallo-git/Coding/tree/main/sql
--
--   stackoverflow.com  |  "tsql - List of all index & index columns in SQL Server DB - Stack Overflow"  |  https://stackoverflow.com/a/765892
--
--   www.mytecbits.com  |  "Find Indexes On A Table In SQL Server | My Tec Bits"  |  https://www.mytecbits.com/microsoft/sql-server/find-indexes-on-a-table
--
-- ----------------------------------------------------------