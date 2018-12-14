
SELECT tbl.table_schema, tbl.table_name,
	ROUND(((tbl.data_length + tbl.index_length)), 0) AS "Size (Bytes)",
	ROUND(((tbl.data_length + tbl.index_length)/1024), 2) AS "Size (KB)",
	ROUND(((tbl.data_length + tbl.index_length)/1048576), 2) AS "Size (MB)",
	ROUND(((tbl.data_length + tbl.index_length)/1073741824), 2) AS "Size (GB)"

FROM information_schema.TABLES tbl

WHERE table_schema = 'db_name'

-- AND ((tbl.data_length + tbl.index_length)/(1024*1024)) < (250)

ORDER BY (tbl.data_length + tbl.index_length) DESC
