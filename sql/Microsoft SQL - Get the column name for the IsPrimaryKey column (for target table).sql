
/* Microsoft SQL (MSSQL) - Get the column name for the IsPrimaryKey column (for a given table) */

-- ------------------------------------------------------------

SELECT
  COLUMN_NAME

FROM
  INFORMATION_SCHEMA.KEY_COLUMN_USAGE

WHERE
  OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + QUOTENAME(CONSTRAINT_NAME)), 'IsPrimaryKey') = 1
  AND TABLE_NAME = 'TableName'
  AND TABLE_SCHEMA = 'Schema'

;


-- ------------------------------------------------------------
--
-- Citation(s)
--
--   github.com  |  "Coding/sql at master · mcavallo-git/Coding · GitHub"  |  https://github.com/mcavallo-git/Coding/tree/master/sql
--
--   stackoverflow.com  |  "SQL Server: Get table primary key using sql query - Stack Overflow"  |  https://stackoverflow.com/a/3930742
--
-- ------------------------------------------------------------