-- ------------------------------------------------------------
-- SQLite - Get all tables
-- ------------------------------------------------------------


SELECT
  NAME
FROM
  sqlite_master
  -- sqlite_schema
WHERE
  TYPE='table'
  AND NAME NOT LIKE 'sqlite_%'
ORDER BY
  NAME ASC
;


-- ------------------------------------------------------------
--
-- Note: Different versions of SQLite use different schema tables:
--        |--> "Older" versions of SQLite use the "sqlite_master" table
--        |--> "Newer" versions of SQLite use the "sqlite_schema" table
--               |--> (Need to determine when the schema switched)
--
-- ------------------------------------------------------------
--
-- Citation(s)
--
--   www.sqlite.org  |  "The Schema Table"  |  https://www.sqlite.org/schematab.html
--
--   www.sqlitetutorial.net  |  "SQLite Show Tables: Listing All Tables in a Database"  |  https://www.sqlitetutorial.net/sqlite-show-tables/
--
-- ------------------------------------------------------------