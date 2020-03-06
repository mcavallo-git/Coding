
/* Microsoft SQL - Get all Column names in a given Database Table (or Tables) */

select schema_name(tab.schema_id) as schema_name,
    tab.name as table_name, 
    col.column_id,
    col.name as column_name, 
    t.name as data_type,    
    col.max_length,
    col.precision
from sys.tables as tab
    inner join sys.columns as col
        on tab.object_id = col.object_id
    left join sys.types as t
    on col.user_type_id = t.user_type_id
order by schema_name,
    table_name, 
    column_id;


/*
----------------------------------------------------------
--
-- Citation(s)
--
--   dataedo.com  |  "List table columns in SQL Server database - SQL Server Data Dictionary Queries"  |  https://dataedo.com/kb/query/sql-server/list-table-columns-in-database
--
----------------------------------------------------------
*/