-- ------------------------------------------------------------
-- Microsoft SQL - Get user roles & permissions (for all users in database)
-- ------------------------------------------------------------

SELECT
  DISTINCT pr.principal_id,
  pr.name,
  pr.type_desc, 
  pr.authentication_type_desc,
  pe.state_desc,
  pe.permission_name
FROM
  sys.database_principals AS pr
JOIN
  sys.database_permissions AS pe
    ON pe.grantee_principal_id = pr.principal_id
;


-- ------------------------------------------------------------
--
-- Citation(s)
--
--   docs.microsoft.com  |  "sys.database_permissions (Transact-SQL) - SQL Server | Microsoft Docs"  |  https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-database-permissions-transact-sql?redirectedfrom=MSDN&view=sql-server-ver15
--
--   stackoverflow.com  |  "How to view the roles and permissions granted to any database user in Azure SQL server instance? - Stack Overflow"  |  https://stackoverflow.com/a/31125327
--
-- ------------------------------------------------------------