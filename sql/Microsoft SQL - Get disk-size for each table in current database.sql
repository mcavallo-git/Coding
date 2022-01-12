-- ------------------------------------------------------------
--
--
-- Microsoft SQL (MSSQL) - Get the disk size of every table current database
--

SELECT
  t.NAME AS TableName
  ,s.Name AS SchemaName
  ,p.rows AS RowCounts
  ,(((SUM(a.total_pages) * 8.0) / 1024.0 / 1024.0)) AS "Capacity (GB)"
  ,(((SUM(a.total_pages) * 8.0))) AS "Capacity (KB)"
  ,(((SUM(a.used_pages) * 8.0) / 1024.0 / 1024.0)) AS "Used (GB)"
  ,(((SUM(a.used_pages) * 8.0))) AS "Used (KB)"
  ,((((SUM(a.total_pages) - SUM(a.used_pages)) * 8.0) / 1024.0 / 1024.0)) AS "Free (GB)"
  ,((((SUM(a.total_pages) - SUM(a.used_pages)) * 8.0))) AS "Free (KB)"

FROM
  sys.tables t

INNER JOIN
  sys.indexes i ON t.OBJECT_ID = i.object_id

INNER JOIN
  sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id

INNER JOIN
  sys.allocation_units a ON p.partition_id = a.container_id

LEFT OUTER JOIN
  sys.schemas s ON t.schema_id = s.schema_id

WHERE
  t.NAME NOT LIKE 'dt%'
  AND t.is_ms_shipped = 0
  AND i.OBJECT_ID > 255

GROUP BY
  t.Name,
  s.Name,
  p.Rows

ORDER BY
  "Capacity (KB)" desc;


-- ------------------------------------------------------------
--
-- Citation(s)
--
--   github.com  |  "Coding/sql at master · mcavallo-git/Coding · GitHub"  |  https://github.com/mcavallo-git/Coding/tree/master/sql
--
-- ------------------------------------------------------------