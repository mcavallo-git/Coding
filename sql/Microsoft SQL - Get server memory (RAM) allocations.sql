-- ------------------------------------------------------------
--
--
-- Microsoft SQL (MSSQL) - Get server memory (RAM) allocations
--

SELECT
  Memory_MB = (pages_kb + awe_allocated_kb + virtual_memory_committed_kb)/1024,
  *

FROM
  sys.dm_os_memory_clerks

ORDER BY
  Memory_MB desc
;


-- ----------------------------------------------------------
--
-- Citation(s)
--
--   blog.sqlxdetails.com  |  "Max Memory in SQL Server 2016 Standard Edition – Vedran Kesegic Blog"  |  https://blog.sqlxdetails.com/max-memory-in-sql-server-2016-standard-edition/
--
--   github.com  |  "Coding/sql at main · mcavallo-git/Coding · GitHub"  |  https://github.com/mcavallo-git/Coding/tree/main/sql
--
-- ----------------------------------------------------------