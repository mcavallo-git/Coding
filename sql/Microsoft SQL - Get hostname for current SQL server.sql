-- ------------------------------------------------------------
--
-- Microsoft SQL (MSSQL) - Get hostname of current SQL server
--

-- Option 1:
SELECT HOST_NAME();

-- Option 2:
SELECT @@SERVERNAME;

-- Option 3:
SELECT SERVERPROPERTY('machinename');


-- ------------------------------------------------------------
--
-- Citation(s)
--
--   github.com  |  "Coding/sql at main · mcavallo-git/Coding · GitHub"  |  https://github.com/mcavallo-git/Coding/tree/main/sql
--
-- ------------------------------------------------------------