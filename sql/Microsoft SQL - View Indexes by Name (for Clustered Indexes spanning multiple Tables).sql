
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

www.mytecbits.com  |  "Find Indexes On A Table In SQL Server | My Tec Bits"  |  https://www.mytecbits.com/microsoft/sql-server/find-indexes-on-a-table

----------------------------------------------------------
*/