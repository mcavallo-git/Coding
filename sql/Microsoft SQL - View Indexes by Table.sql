
/* Microsoft SQL (MSSQL) - View Indexes by Table */

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

   github.com  |  "Coding/Microsoft SQL - View Indexes by Table.sql at master · mcavallo-git/Coding · GitHub"  |  https://github.com/mcavallo-git/Coding/blob/master/sql/Microsoft%20SQL%20-%20View%20Indexes%20by%20Table.sql

   stackoverflow.com  |  "tsql - List of all index & index columns in SQL Server DB - Stack Overflow"  |  https://stackoverflow.com/a/765892

   www.mytecbits.com  |  "Find Indexes On A Table In SQL Server | My Tec Bits"  |  https://www.mytecbits.com/microsoft/sql-server/find-indexes-on-a-table

----------------------------------------------------------
*/