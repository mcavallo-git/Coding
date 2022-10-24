-- ----------------------------------------------------------
--
-- Microsoft SQL (MSSQL) - Get server name, domain name, SLD, TLD (xpregread)
--

-- Get just the SLD (pre-Windows 2000 compatible domain name)
SELECT DEFAULT_DOMAIN() AS DomainName;


-- ----------------------------------------------------------

DECLARE @Domain varchar(100), @key varchar(100)
SET @key = 'SYSTEM\ControlSet001\Services\Tcpip\Parameters\'
EXEC master..xp_regread @rootkey='HKEY_LOCAL_MACHINE', @key=@key,@value_name='Domain',@value=@Domain OUTPUT
SELECT @@servername AS ServerName,
convert(varchar(100),@Domain) AS DomainName_FQDN,
DEFAULT_DOMAIN() AS DomainName_SLD;


-- ------------------------------------------------------------
--
-- Citation(s)
--
--   github.com  |  "Coding/sql at main · mcavallo-git/Coding · GitHub"  |  https://github.com/mcavallo-git/Coding/tree/main/sql
--
--   stackoverflow.com  |  "How to get DOMAIN name from SQL Server? - Stack Overflow"  |  https://stackoverflow.com/a/40877756
--
-- ------------------------------------------------------------