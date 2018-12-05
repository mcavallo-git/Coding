
SET @DB_NAME = 'prod_supplier_gateway';

SELECT tbl.table_schema, tbl.table_name,
	ROUND(((tbl.data_length + tbl.index_length)), 0) AS "Size (Bytes)",
	ROUND(((tbl.data_length + tbl.index_length)/1073741824), 2) AS "Size (GB)"
FROM information_schema.TABLES tbl
WHERE table_schema = @DB_NAME
-- AND ((tbl.data_length + tbl.index_length)/(1024*1024)) < (250)
ORDER BY (tbl.data_length + tbl.index_length) DESC
