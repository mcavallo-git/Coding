-- ------------------------------------------------------------
--
--
-- Microsoft SQL (MSSQL) - Enable the SQL Server Agent XPs (extended stored procedures, sp_configure)
--

sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'Agent XPs', 1;
GO
RECONFIGURE
GO

-- ------------------------------------------------------------
--
-- Citation(s)
--
--   docs.microsoft.com  |  "Agent XPs Server Configuration Option - SQL Server | Microsoft Docs"  |  https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/agent-xps-server-configuration-option?view=sql-server-ver15
--
--   docs.microsoft.com  |  "sp_configure (Transact-SQL) - SQL Server | Microsoft Docs"  |  https://docs.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-configure-transact-sql?view=sql-server-ver15
--
--   github.com  |  "Coding/sql at master · mcavallo-git/Coding · GitHub"  |  https://github.com/mcavallo-git/Coding/tree/master/sql
--
-- ------------------------------------------------------------