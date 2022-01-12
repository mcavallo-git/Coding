-- ------------------------------------------------------------
--
--
-- Microsoft SQL (MSSQL) - Get column names, their data types, and their is_primary_key values (for given table)
--

SELECT
  c.name 'Column Name',
  t.Name 'Data type',
  c.max_length 'Max Length',
  c.precision ,
  c.scale ,
  c.is_nullable,
  ISNULL(i.is_primary_key, 0) 'Primary Key'
FROM
  sys.columns c
INNER JOIN
  sys.types t ON c.user_type_id = t.user_type_id
LEFT OUTER JOIN
  sys.index_columns ic ON ic.object_id = c.object_id
  AND ic.column_id = c.column_id
LEFT OUTER JOIN
  sys.indexes i ON ic.object_id = i.object_id
  AND ic.index_id = i.index_id
WHERE
  c.object_id = OBJECT_ID('TableName')
;


-- ------------------------------------------------------------
--
-- Citation(s)
--
--   stackoverflow.com  |  "sql server - Get all table names of a particular database by SQL query? - Stack Overflow"  |  https://stackoverflow.com/a/3914051
--
--   stackoverflow.com  |  "SQL server query to get the list of columns in a table along with Data types, NOT NULL, and PRIMARY KEY constraints - Stack Overflow"  |  https://stackoverflow.com/a/2418665
--
-- ------------------------------------------------------------