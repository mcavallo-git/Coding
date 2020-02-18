sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'Agent XPs', 1;
GO
RECONFIGURE
GO


----------------------------------------------------------
--
-- Citation(s)
--
--   docs.microsoft.com  |  "Agent XPs Server Configuration Option - SQL Server | Microsoft Docs"  |  https://docs.microsoft.com/en-us/sql/database-engine/configure-windows/agent-xps-server-configuration-option?view=sql-server-ver15
--
----------------------------------------------------------