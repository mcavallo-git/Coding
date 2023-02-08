-- ------------------------------------------------------------
-- SQLite - Get all tables
-- ------------------------------------------------------------


SELECT
  NAME
FROM
  sqlite_master
WHERE
  TYPE='table'
  AND NAME NOT LIKE 'sqlite_%'
ORDER BY
  NAME ASC
;


-- ------------------------------------------------------------
--
-- Note: Different versions of SQLite use different schema tables:
--        |--> Table "sqlite_schema" is used by versions since v3.33.0
--        |--> Table "sqlite_master" is used by versions before v3.33.0
--              |--> Note that "sqlite_master" is commonly an alias to "sqlite_schema"
--
-- ------------------------------------------------------------
--
-- Citation(s)
--
--   www.sqlite.org  |  "SQLite Forum: Documentation issue (wrong table name) in FAQ, point 7"  |  https://www.sqlite.org/forum/forumpost/d90adfbb0a
--
--   www.sqlite.org  |  "The Schema Table"  |  https://www.sqlite.org/schematab.html
--
--   www.sqlitetutorial.net  |  "SQLite Show Tables: Listing All Tables in a Database"  |  https://www.sqlitetutorial.net/sqlite-show-tables/
--
-- ------------------------------------------------------------