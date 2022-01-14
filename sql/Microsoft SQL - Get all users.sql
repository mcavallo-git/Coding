-- ------------------------------------------------------------
-- Microsoft SQL - Get all users
-- ------------------------------------------------------------

SELECT
  name AS username,
  create_date,
  modify_date,
  type_desc as type,
  authentication_type_desc as authentication_type
FROM
  sys.database_principals
WHERE
  type not in ('A', 'G', 'R', 'X')
  AND sid is not null
  AND name != 'guest'
ORDER BY
  username
;


-- ------------------------------------------------------------

SELECT
  *
FROM
  sysusers
;


-- ------------------------------------------------------------
--
-- Citation(s)
--
--   stackoverflow.com  |  "sql server - How to get the list of all database users - Stack Overflow"  |  https://stackoverflow.com/a/44387238
--
-- ----------------------------------------------------------