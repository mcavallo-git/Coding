
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


/*
----------------------------------------------------------

Citation(s)

www.mytecbits.com  |  "Find Indexes On A Table In SQL Server | My Tec Bits"  |  https://www.mytecbits.com/microsoft/sql-server/find-indexes-on-a-table

----------------------------------------------------------
*/