-- ----------------------------------------------------------------------------------------------------------------------------
-- NOTES
--   MySQL says the user has "Usage" on a instance/database if they have no privileges)
-- ----------------------------------------------------------------------------------------------------------------------------

-- ===================================== --
-- ==        GLOBAL PRIVILEGES        == --
-- ===================================== --

-- REVOKE ALL PRIVILEGES
	REVOKE
		ALL PRIVILEGES
	ON
		*.*
	FROM
		'some_user'@'%', 'boneal_rfq'@'%', 'boneal_user'@'%';
	
-- REVOKE SPECIFICS
	REVOKE 
		SELECT,CREATE,INSERT,UPDATE,DELETE,DROP,RELOAD,PROCESS,REFERENCES,INDEX,ALTER,SHOW DATABASES,CREATE TEMPORARY TABLES,LOCK TABLES,
		REPLICATION SLAVE,REPLICATION CLIENT,CREATE VIEW,EVENT,TRIGGER,SHOW VIEW,CREATE ROUTINE,ALTER ROUTINE,CREATE USER,EXECUTE 
	ON
		*.*
	FROM
		'some_user'@'%', 'boneal_rfq'@'%', 'boneal_user'@'%';



-- REVOKE USER-PRIVILEGES FROM A SPECIFIC [ USER ]
REVOKE
	ALL PRIVILEGES
ON
	*.*
FROM
	'some_user'@'%', 'some_other_user'@'%', 'some_really_mean_user'@'%';



-- REVOKE USER-PRIVILEGES FROM A SPECIFIC [ DATABASE ]
REVOKE
	ALL PRIVILEGES
ON
	`some_database`.*
FROM
	'some_user'@'%', 'some_other_user'@'%', 'some_really_mean_user'@'%';



-- REVOKE USER-PRIVILEGES FROM A SPECIFIC [ TABLE ]
REVOKE
	ALL PRIVILEGES
ON
	`some_database`.`some_table_name`
FROM
	'some_user'@'%', 'some_other_user'@'%', 'some_really_mean_user'@'%';



-- REVOKE USER-PRIVILEGES FROM A SPECIFIC [ COLUMN ]
REVOKE
	SELECT (column_1, column_a)
ON
	`some_database`.`some_table_name`
FROM
	'some_user'@'%', 'some_other_user'@'%', 'some_really_mean_user'@'%';


