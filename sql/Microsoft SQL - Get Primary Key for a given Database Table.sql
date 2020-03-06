
/* Microsoft SQL - Get all Column names in a given Database Table (or Tables) */

SELECT COLUMN_NAME

FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE

WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + QUOTENAME(CONSTRAINT_NAME)), 'IsPrimaryKey') = 1
AND TABLE_NAME = 'TableName'
AND TABLE_SCHEMA = 'Schema'

;


/*
----------------------------------------------------------
--
-- Citation(s)
--
--   stackoverflow.com  |  "SQL Server: Get table primary key using sql query - Stack Overflow"  |  https://stackoverflow.com/a/3930742
--
----------------------------------------------------------
*/