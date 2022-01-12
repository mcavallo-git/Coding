-- ------------------------------------------------------------
--
-- Microsoft SQL - Get all tables (in target database)
--

SELECT
  TABLE_NAME
FROM
  INFORMATION_SCHEMA.TABLES
WHERE
  TABLE_CATALOG='DatabaseName'
  AND TABLE_TYPE='BASE TABLE'
;

-- ------------------------------------------------------------