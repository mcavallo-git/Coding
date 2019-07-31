
SELECT
	ENGINE AS 'Storage Engine',
	COUNT(ENGINE) AS 'Count',
	TABLE_SCHEMA AS 'Table Name'

FROM
	information_schema.TABLES

WHERE ENGINE IS NOT NULL
	AND TABLE_SCHEMA <> 'information_schema'
	AND TABLE_SCHEMA <> 'mysql'
	AND TABLE_SCHEMA <> 'performance_schema'
	AND TABLE_SCHEMA <> 'sys'

GROUP BY
	TABLE_SCHEMA,
	ENGINE

ORDER BY
	ENGINE,
	TABLE_SCHEMA
