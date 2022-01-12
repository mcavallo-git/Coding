
/* Microsoft SQL (MSSQL) - Drop all tables (including foreign keys) */

-- ------------------------------------------------------------

USE "DATABASE_NAME"
GO

DECLARE @Sql NVARCHAR(500) DECLARE @Cursor CURSOR

SET @Cursor = CURSOR FAST_FORWARD FOR
SELECT DISTINCT sql = 'ALTER TABLE [' + tc2.TABLE_SCHEMA + '].[' +  tc2.TABLE_NAME + '] DROP [' + rc1.CONSTRAINT_NAME + '];'
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS rc1
LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc2 ON tc2.CONSTRAINT_NAME =rc1.CONSTRAINT_NAME

OPEN @Cursor FETCH NEXT FROM @Cursor INTO @Sql

WHILE (@@FETCH_STATUS = 0)
BEGIN
Exec sp_executesql @Sql
FETCH NEXT FROM @Cursor INTO @Sql
END

CLOSE @Cursor DEALLOCATE @Cursor
GO

EXEC sp_MSforeachtable 'DROP TABLE ?'
GO


-- ------------------------------------------------------------
--
-- Citation(s)
--
--   github.com  |  "Coding/sql at master · mcavallo-git/Coding · GitHub"  |  https://github.com/mcavallo-git/Coding/tree/master/sql
--
--   stackoverflow.com  |  "How to drop all tables in a SQL Server database? - Stack Overflow"  |  https://stackoverflow.com/a/8439798
--
-- ------------------------------------------------------------