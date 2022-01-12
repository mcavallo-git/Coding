
/* Microsoft SQL (MSSQL) - Get indexes by-name (for clustered indexes spanning multiple tables) */

-- ------------------------------------------------------------

SELECT
  a.name AS Index_Name,
  OBJECT_NAME(a.object_id),
  COL_NAME(b.object_id,b.column_id) AS Column_Name,
  b.index_column_id,
  b.key_ordinal,
  b.is_included_column
FROM
  sys.indexes AS a
INNER JOIN
  sys.index_columns AS b
ON
  a.object_id = b.object_id AND a.index_id = b.index_id
WHERE
  a.is_hypothetical = 0 AND
  a.object_id = OBJECT_ID('[[[DATABASE_NAME.TABLE_NAME]]]')
;


/*
----------------------------------------------------------

 Citation(s)

   github.com  |  "Coding/sql at master · mcavallo-git/Coding · GitHub"  |  https://github.com/mcavallo-git/Coding/tree/master/sql

   stackoverflow.com  |  "tsql - List of all index & index columns in SQL Server DB - Stack Overflow"  |  https://stackoverflow.com/a/765892

   www.mytecbits.com  |  "Find Indexes On A Table In SQL Server | My Tec Bits"  |  https://www.mytecbits.com/microsoft/sql-server/find-indexes-on-a-table

----------------------------------------------------------
*/