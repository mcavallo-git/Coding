
/* Microsoft SQL (MSSQL) - View Indexes by Name (for Clustered Indexes spanning multiple Tables) */

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

   github.com  |  "Coding/Microsoft SQL - View Indexes by Name (for Clustered Indexes spanning multiple Tables).sql at master · mcavallo-git/Coding · GitHub"  |  https://github.com/mcavallo-git/Coding/blob/master/sql/Microsoft%20SQL%20-%20View%20Indexes%20by%20Name%20(for%20Clustered%20Indexes%20spanning%20multiple%20Tables).sql

   stackoverflow.com  |  "tsql - List of all index & index columns in SQL Server DB - Stack Overflow"  |  https://stackoverflow.com/a/765892

   www.mytecbits.com  |  "Find Indexes On A Table In SQL Server | My Tec Bits"  |  https://www.mytecbits.com/microsoft/sql-server/find-indexes-on-a-table

----------------------------------------------------------
*/