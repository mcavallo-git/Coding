-- ------------------------------------------------------------
--
--
-- Microsoft SQL (MSSQL) - Rename SQL server (sp_configure)
--

-- List local server names
sp_helpserver;


-- ------------------------------------------------------------

-- Rename Server
sp_dropserver 'OLD-NAME';
GO
sp_addserver 'NEW-NAME', local;
GO


-- ------------------------------------------------------------
--
-- Citation(s)
--
--   docs.microsoft.com  |  "Rename computer hosting instance - SQL Server | Microsoft Docs"  |  https://docs.microsoft.com/en-us/sql/database-engine/install-windows/rename-a-computer-that-hosts-a-stand-alone-instance-of-sql-server?view=sql-server-ver15
--
--   docs.microsoft.com  |  "sp_configure (Transact-SQL) - SQL Server | Microsoft Docs"  |  https://docs.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-configure-transact-sql?view=sql-server-ver15
--
--   github.com  |  "Coding/sql at master · mcavallo-git/Coding · GitHub"  |  https://github.com/mcavallo-git/Coding/tree/master/sql
--
-- ------------------------------------------------------------