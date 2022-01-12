-- ------------------------------------------------------------
--
-- Revoke specific user-privilege grants attached to target [ USER ]
--
REVOKE
  -- ALTER ROUTINE,
  -- ALTER,
  -- CREATE ROUTINE,
  -- CREATE TEMPORARY TABLES,
  -- CREATE USER,
  -- CREATE VIEW,
  -- CREATE,
  DELETE,
  -- DROP,
  -- EVENT,
  -- EXECUTE,
  -- INDEX,
  INSERT,
  -- LOCK TABLES,
  -- PROCESS,
  -- REFERENCES,
  -- RELOAD,
  -- REPLICATION CLIENT,
  -- REPLICATION SLAVE,
  SELECT,
  -- SHOW DATABASES,
  -- SHOW VIEW,
  -- TRIGGER,
  UPDATE
ON
  *.*
FROM
  'UserName_1'@'%',
  'UserName_2'@'%',
  'UserName_3'@'%'
;


-- ------------------------------------------------------------
--
-- Revoke all user-privilege grants attached to target [ USER ]
--
REVOKE
  ALL PRIVILEGES
ON
  *.*
FROM
  'UserName_1'@'%',
  'UserName_2'@'%',
  'UserName_3'@'%'
;


-- ------------------------------------------------------------
--
-- Revoke all user-privilege grants attached to target [ DATABASE ]
--
REVOKE
  ALL PRIVILEGES
ON
  `DatabaseName`.*
FROM
  'UserName_1'@'%',
  'UserName_2'@'%',
  'UserName_3'@'%'
;


-- ------------------------------------------------------------
--
-- Revoke all user-privilege grants attached to target [ TABLE ]
--
REVOKE
  ALL PRIVILEGES
ON
  `DatabaseName`.`TableName`
FROM
  'UserName_1'@'%',
  'UserName_2'@'%',
  'UserName_3'@'%'
;


-- ------------------------------------------------------------
--
-- Revoke all user-privilege grants attached to target [ COLUMN ]
--
REVOKE
  SELECT (column_1, column2)
ON
  `DatabaseName`.`TableName`
FROM
  'UserName_1'@'%',
  'UserName_2'@'%',
  'UserName_3'@'%'
;


-- ------------------------------------------------------------
--
-- Note: MySQL defines "Usage" as the scenario when a user has zero privileges granted allowing access to a given database/table/column, but is still a user within the database
--  |
--  |--> E.g. they cannot select/update/insert/etc. any data, but they still exist as a user within the SQL Database - e.g. the user still has "Usage" on the database
--
-- ------------------------------------------------------------