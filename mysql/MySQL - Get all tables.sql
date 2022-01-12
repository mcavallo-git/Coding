-- ------------------------------------------------------------
--
-- MySQL - Get all tables
--

SELECT
  *
FROM
  information_schema.TABLES
WHERE
  TABLE_SCHEMA='DatabaseName'


-- ------------------------------------------------------------
--
-- MySQL - Get all tables (ordered by disk size)
--

SELECT table_schema, table_name,
  ROUND(((data_length + index_length)), 0) AS "Size (Bytes)",
  ROUND(((data_length + index_length)/1024), 2) AS "Size (KB)",
  ROUND(((data_length + index_length)/1048576), 2) AS "Size (MB)",
  ROUND(((data_length + index_length)/1073741824), 2) AS "Size (GB)"

FROM
  information_schema.TABLES

WHERE
  table_schema = 'DatabaseName'
  /* AND ((data_length + index_length)/(1024*1024)) < (250) */

ORDER BY
  (data_length + index_length) DESC

-- ------------------------------------------------------------