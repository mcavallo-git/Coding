------------------------------------------------------------

-- List local server names
sp_helpserver;


------------------------------------------------------------

-- Rename Server
sp_dropserver 'OLD-NAME';
GO
sp_addserver 'NEW-NAME', local;
GO


----------------------------------------------------------
--
-- Citation(s)
--
--   docs.microsoft.com  |  "Rename computer hosting instance - SQL Server | Microsoft Docs"  |  https://docs.microsoft.com/en-us/sql/database-engine/install-windows/rename-a-computer-that-hosts-a-stand-alone-instance-of-sql-server?view=sql-server-ver15
--
----------------------------------------------------------