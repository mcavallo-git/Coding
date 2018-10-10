------------------------------------------------------------------------------------------------------------------------------
-- NOTES
--   MySQL says the user has "Usage" on a instance/database if they have no privileges)
------------------------------------------------------------------------------------------------------------------------------

--===================================--
--==--     GLOBAL PRIVILEGES     --==--
--===================================--

-- GRANT ALL PRIVILEGES
	GRANT
		ALL PRIVILEGES
	ON
		*.*
	TO
		'some_user'@'%', 'some_other_user'@'%';
	
-- GRANT SPECIFICS
	GRANT 
		SELECT,CREATE,INSERT,UPDATE,DELETE,DROP,RELOAD,PROCESS,REFERENCES,INDEX,ALTER,SHOW DATABASES,CREATE TEMPORARY TABLES,LOCK TABLES,
		REPLICATION SLAVE,REPLICATION CLIENT,CREATE VIEW,EVENT,TRIGGER,SHOW VIEW,CREATE ROUTINE,ALTER ROUTINE,CREATE USER,EXECUTE 
	ON
		*.*
	TO
		'some_user'@'%', 'some_other_user'@'%';


-- GRANT THE ABILITY TO GRANT
	-- SQL HERE FOR GRANTING

------------------------------------------------------------------------------------------------------------------------------

--==========================================--
--==--     PER-USER  &  PER-DATABASE    --==--
--==========================================--

-- GRANT ALL
	GRANT
		ALL PRIVILEGES
	ON
		`some_database`.*
	TO
		'some_user'@'%', 'some_other_user'@'%', 'some_worthy_user'@'%';

-- GRANT SPECIFICS
	GRANT
		ALL PRIVILEGES
	ON
		`some_database`.*
	TO
		'some_user'@'%', 'some_other_user'@'%', 'some_worthy_user'@'%';

-- PROCEDURE GRANTS
	GRANT
		EXECUTE
	ON PROCEDURE
		`some_database`.'some_procedure'
	TO
		'some_user'@'%', 'some_other_user'@'%', 'some_worthy_user'@'%';
		
-- TRIGGER GRANTS
	-- !!!  NOTE  !!!
			--	WHEN A TRIGGER IS DEFINED, THE USER WHO DEFINED IT BECOMES ATTACHED TO IT, AND WHEN THE TRIGGER FIRES FROM THEN ON,
			--	IT IS THAT ORIGINAL DEFINING USER WHO IS PERFORMING THE INSERT/UPDATE/DELETE ACTIONS. THEREFORE, THE DEFINING USER MUST 
			--	ALWAYS HAVE THE 'TRIGGER' PRIVILEGE FOR ANY DATABASE.TABLE ASSOCIATED WITH THE TRIGGER
	
------------------------------------------------------------------------------------------------------------------------------


--   GRANT  :::  GLOBAL PRIVILEGES
GRANT
SELECT,CREATE,INSERT,UPDATE,DELETE,DROP,RELOAD,PROCESS,REFERENCES,INDEX,ALTER,SHOW DATABASES,CREATE TEMPORARY TABLES,LOCK TABLES,
REPLICATION SLAVE,REPLICATION CLIENT,CREATE VIEW,EVENT,TRIGGER,SHOW VIEW,CREATE ROUTINE,ALTER ROUTINE,CREATE USER,EXECUTE 
ON *.*
TO 'some_user'@'%', 'some_other_user'@'%';


--   GRANT  :::  DATABASE-SPECIFIC PRIVILEGES
GRANT
SELECT,CREATE,INSERT,UPDATE,DELETE,DROP,RELOAD,PROCESS,REFERENCES,INDEX,ALTER,SHOW DATABASES,CREATE TEMPORARY TABLES,LOCK TABLES,
REPLICATION SLAVE,REPLICATION CLIENT,CREATE VIEW,EVENT,TRIGGER,SHOW VIEW,CREATE ROUTINE,ALTER ROUTINE,CREATE USER,EXECUTE 
ON `some_database`.*
TO 'some_user'@'%';

GRANT
SELECT,CREATE,INSERT,UPDATE,DELETE,DROP,RELOAD,PROCESS,REFERENCES,INDEX,ALTER,SHOW DATABASES,CREATE TEMPORARY TABLES,LOCK TABLES,
REPLICATION SLAVE,REPLICATION CLIENT,CREATE VIEW,EVENT,TRIGGER,SHOW VIEW,CREATE ROUTINE,ALTER ROUTINE,CREATE USER,EXECUTE 
ON `some_database`.*
TO 'some_other_user'@'%','some_worthy_user'@'%';

-- Allow database user the necessary (back-end) method of checking for available MySQL Procedures
GRANT
SELECT
ON `mysql`.'proc'
TO 'some_user'@'%', 'some_other_user'@'%', 'some_worthy_user'@'%';
