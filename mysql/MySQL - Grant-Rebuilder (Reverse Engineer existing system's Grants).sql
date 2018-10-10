/* Get All Grants/Permissions for MySQL Instance */

-- DROP VIEW boneal_dev.grant_query_rebuilder

-- SELECT * FROM boneal_dev.grant_query_rebuilder

-- CREATE VIEW boneal_dev.grant_query_rebuilder AS

/* [Database.Table.Column]-Specific Grants */
SELECT
	CONCAT("`",gcl.Db,"`") AS 'Database(s) Affected',
-- TEST COMMENT
	CONCAT("`",gcl.Table_name,"`") AS 'Table(s) Affected',
	gcl.User AS 'User-Account(s) Affected',
	IF(gcl.Host='%','ALL',gcl.Host) AS 'Remote-IP(s) Affected',
	CONCAT("GRANT ",UPPER(gcl.Column_priv)," (",GROUP_CONCAT(gcl.Column_name),") ",
				 "ON `",gcl.Db,"`.`",gcl.Table_name,"` ",
				 "TO '",gcl.User,"'@'",gcl.Host,"';") AS 'GRANT Statement (Reconstructed)'
FROM mysql.columns_priv gcl
WHERE true
-- AND gcl.User IN ('some_user') /* Show only for a set of MySQL Users */
GROUP BY CONCAT(gcl.Db,gcl.Table_name,gcl.User,gcl.Host)
/* SELECT * FROM mysql.columns_priv */

UNION

/* [Database.Table]-Specific Grants */
SELECT
	CONCAT("`",gtb.Db,"`") AS 'Database(s) Affected',
	CONCAT("`",gtb.Table_name,"`") AS 'Table(s) Affected',
	gtb.User AS 'User-Account(s) Affected',
	IF(gtb.Host='%','ALL',gtb.Host) AS 'Remote-IP(s) Affected',
	CONCAT(
		"GRANT ",UPPER(gtb.Table_priv)," ",
		"ON `",gtb.Db,"`.`",gtb.Table_name,"` ",
		"TO '",gtb.User,"'@'",gtb.Host,"';"
	) AS 'GRANT Statement (Reconstructed)'
FROM mysql.tables_priv gtb
WHERE gtb.Table_priv!=''
-- AND gtb.User IN ('some_user') /* Show only for a set of MySQL Users */
/* SELECT * FROM mysql.tables_priv */

UNION

/* Database-Specific Grants */
SELECT
	CONCAT("`",gdb.Db,"`") AS 'Database(s) Affected',
	"ALL" AS 'Table(s) Affected',
	gdb.User AS 'User-Account(s) Affected',
	IF(gdb.Host='%','ALL',gdb.Host) AS 'Remote-IP(s) Affected',
	CONCAT(
		'GRANT ',
		CONCAT_WS(',',
			IF(gdb.Select_priv='Y','SELECT',NULL),
			IF(gdb.Insert_priv='Y','INSERT',NULL),
			IF(gdb.Update_priv='Y','UPDATE',NULL),
			IF(gdb.Delete_priv='Y','DELETE',NULL),
			IF(gdb.Create_priv='Y','CREATE',NULL),
			IF(gdb.Drop_priv='Y','DROP',NULL),
			IF(gdb.Grant_priv='Y','GRANT',NULL),
			IF(gdb.References_priv='Y','REFERENCES',NULL),
			IF(gdb.Index_priv='Y','INDEX',NULL),
			IF(gdb.Alter_priv='Y','ALTER',NULL),
			IF(gdb.Create_tmp_table_priv='Y','CREATE TEMPORARY TABLES',NULL),
			IF(gdb.Lock_tables_priv='Y','LOCK TABLES',NULL),
			IF(gdb.Create_view_priv='Y','CREATE VIEW',NULL),
			IF(gdb.Show_view_priv='Y','SHOW VIEW',NULL),
			IF(gdb.Create_routine_priv='Y','CREATE ROUTINE',NULL),
			IF(gdb.Alter_routine_priv='Y','ALTER ROUTINE',NULL),
			IF(gdb.Execute_priv='Y','EXECUTE',NULL),
			IF(gdb.Event_priv='Y','EVENT',NULL),
			IF(gdb.Trigger_priv='Y','TRIGGER',NULL)
		),
		" ON `",gdb.Db,"`.* TO '",gdb.User,"'@'",gdb.Host,"';"
	) AS 'GRANT Statement (Reconstructed)'
FROM mysql.db gdb
WHERE gdb.Db != ''
-- AND gdb.User IN ('some_user') /* Show only for a set of MySQL Users */
/* SELECT * FROM mysql.db */

UNION

/* User-Specific Grants */
SELECT
	"ALL" AS 'Database(s) Affected',
	"ALL" AS 'Table(s) Affected',
	usr.User AS 'User-Account(s) Affected',
	IF(usr.Host='%','ALL',usr.Host) AS 'Remote-IP(s) Affected',
	CONCAT(
		"GRANT ",
		IF((usr.Select_priv='N')&(usr.Insert_priv='N')&(usr.Update_priv='N')&(usr.Delete_priv='N')&(usr.Create_priv='N')&(usr.Drop_priv='N')&(usr.Reload_priv='N')&(usr.Shutdown_priv='N')&(usr.Process_priv='N')&(usr.File_priv='N')&(usr.References_priv='N')&(usr.Index_priv='N')&(usr.Alter_priv='N')&(usr.Show_db_priv='N')&(usr.Super_priv='N')&(usr.Create_tmp_table_priv='N')&(usr.Lock_tables_priv='N')&(usr.Execute_priv='N')&(usr.Repl_slave_priv='N')&(usr.Repl_client_priv='N')&(usr.Create_view_priv='N')&(usr.Show_view_priv='N')&(usr.Create_routine_priv='N')&(usr.Alter_routine_priv='N')&(usr.Create_user_priv='N')&(usr.Event_priv='N')&(usr.Trigger_priv='N')&(usr.Create_tablespace_priv='N')&(usr.Grant_priv='N'),
			"USAGE",
			IF((usr.Select_priv='Y')&(usr.Insert_priv='Y')&(usr.Update_priv='Y')&(usr.Delete_priv='Y')&(usr.Create_priv='Y')&(usr.Drop_priv='Y')&(usr.Reload_priv='Y')&(usr.Shutdown_priv='Y')&(usr.Process_priv='Y')&(usr.File_priv='Y')&(usr.References_priv='Y')&(usr.Index_priv='Y')&(usr.Alter_priv='Y')&(usr.Show_db_priv='Y')&(usr.Super_priv='Y')&(usr.Create_tmp_table_priv='Y')&(usr.Lock_tables_priv='Y')&(usr.Execute_priv='Y')&(usr.Repl_slave_priv='Y')&(usr.Repl_client_priv='Y')&(usr.Create_view_priv='Y')&(usr.Show_view_priv='Y')&(usr.Create_routine_priv='Y')&(usr.Alter_routine_priv='Y')&(usr.Create_user_priv='Y')&(usr.Event_priv='Y')&(usr.Trigger_priv='Y')&(usr.Create_tablespace_priv='Y')&(usr.Grant_priv='Y'),
				"ALL PRIVILEGES",
				CONCAT_WS(',',
					IF(usr.Select_priv='Y','SELECT',NULL),
					IF(usr.Insert_priv='Y','INSERT',NULL),
					IF(usr.Update_priv='Y','UPDATE',NULL),
					IF(usr.Delete_priv='Y','DELETE',NULL),
					IF(usr.Create_priv='Y','CREATE',NULL),
					IF(usr.Drop_priv='Y','DROP',NULL),
					IF(usr.Reload_priv='Y','RELOAD',NULL),
					IF(usr.Shutdown_priv='Y','SHUTDOWN',NULL),
					IF(usr.Process_priv='Y','PROCESS',NULL),
					IF(usr.File_priv='Y','FILE',NULL),
					IF(usr.References_priv='Y','REFERENCES',NULL),
					IF(usr.Index_priv='Y','INDEX',NULL),
					IF(usr.Alter_priv='Y','ALTER',NULL),
					IF(usr.Show_db_priv='Y','SHOW DATABASES',NULL),
					IF(usr.Super_priv='Y','SUPER',NULL),
					IF(usr.Create_tmp_table_priv='Y','CREATE TEMPORARY TABLES',NULL),
					IF(usr.Lock_tables_priv='Y','LOCK TABLES',NULL),
					IF(usr.Execute_priv='Y','EXECUTE',NULL),
					IF(usr.Repl_slave_priv='Y','REPLICATION SLAVE',NULL),
					IF(usr.Repl_client_priv='Y','REPLICATION CLIENT',NULL),
					IF(usr.Create_view_priv='Y','CREATE VIEW',NULL),
					IF(usr.Show_view_priv='Y','SHOW VIEW',NULL),
					IF(usr.Create_routine_priv='Y','CREATE ROUTINE',NULL),
					IF(usr.Alter_routine_priv='Y','ALTER ROUTINE',NULL),
					IF(usr.Create_user_priv='Y','CREATE USER',NULL),
					IF(usr.Event_priv='Y','EVENT',NULL),
					IF(usr.Trigger_priv='Y','TRIGGER',NULL),
					IF(usr.Create_tablespace_priv='Y','CREATE TABLESPACE',NULL)
				)
			)
		),
		" ON *.* TO '",usr.User,"'@'",usr.Host,"' REQUIRE ",
		CASE usr.ssl_type
			WHEN 'ANY' THEN
				"SSL "
			WHEN 'X509' THEN
				"X509 "
			WHEN 'SPECIFIED' THEN
				CONCAT_WS("AND ",
					IF((LENGTH(usr.ssl_cipher)>0),CONCAT("CIPHER '",CONVERT(usr.ssl_cipher USING utf8),"' "),NULL),
					IF((LENGTH(usr.x509_issuer)>0),CONCAT("ISSUER '",CONVERT(usr.ssl_cipher USING utf8),"' "),NULL),
					IF((LENGTH(usr.x509_subject)>0),CONCAT("SUBJECT '",CONVERT(usr.ssl_cipher USING utf8),"' "),NULL)
				)
			ELSE "NONE "
		END,
		"WITH ",
		IF(usr.Grant_priv='Y',"GRANT OPTION ",""),
		"MAX_QUERIES_PER_HOUR ",usr.max_questions," ",
		"MAX_CONNECTIONS_PER_HOUR ",usr.max_connections," ",
		"MAX_UPDATES_PER_HOUR ",usr.max_updates," ",
		"MAX_USER_CONNECTIONS ",usr.max_user_connections,
		";"
	) AS 'GRANT Statement (Reconstructed)'
FROM mysql.user usr
WHERE usr.Password != ''
-- AND usr.User IN ('some_user') /* Show only for a set of MySQL Users */

/* SELECT * FROM mysql.user usr */

	/* To-Do (1): Procedure/Routine-Specific Grants*/
	/* SELECT * FROM mysql.procs_priv gpr */
	
	/* To-Do (2): ??? Host-Specific Grants ??? */
	/* SELECT * FROM mysql.host ghs */
