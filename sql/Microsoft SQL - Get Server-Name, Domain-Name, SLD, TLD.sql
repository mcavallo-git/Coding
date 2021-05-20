
/* Microsoft SQL (MSSQL) - Get Server-Name, Domain-Name, SLD, TLD */

-- ----------------------------------------------------------

/* Get just the SLD (pre-Windows 2000 compatible domain name) */
SELECT DEFAULT_DOMAIN() AS DomainName;


-- ----------------------------------------------------------

DECLARE @Domain varchar(100), @key varchar(100)
SET @key = 'SYSTEM\ControlSet001\Services\Tcpip\Parameters\'
EXEC master..xp_regread @rootkey='HKEY_LOCAL_MACHINE', @key=@key,@value_name='Domain',@value=@Domain OUTPUT 
SELECT @@servername AS ServerName,
convert(varchar(100),@Domain) AS DomainName_FQDN,
DEFAULT_DOMAIN() AS DomainName_SLD;


/*
------------------------------------------------------------

 Citation(s)

   stackoverflow.com  |  "How to get DOMAIN name from SQL Server? - Stack Overflow"  |  https://stackoverflow.com/a/40877756

------------------------------------------------------------
*/