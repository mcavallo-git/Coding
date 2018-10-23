
----------------------------------------------------------------------------------------------------------------


  /*   DATABASE SIZES (except system db's)   */
  SELECT CURDATE() AS 'Date',
         CURTIME() AS 'Time',
         TABLE_SCHEMA AS 'Database',
         ROUND(SUM(data_length + index_length) / 1073741824, 2) AS 'Database Size (GB)'
    FROM information_schema.TABLES
   WHERE TABLE_SCHEMA NOT IN ('information_schema','mysql','performance_schema','sys')
GROUP BY TABLE_SCHEMA
ORDER BY ROUND(SUM(data_length + index_length) / 1073741824, 2) DESC


----------------------------------------------------------------------------------------------------------------


  /*   TABLE SIZES, ALL DATABASES   */
  SELECT CURDATE() AS 'Date',
         CURTIME() AS 'Time',
         TABLE_SCHEMA AS 'Database',
         TABLE_NAME AS 'Table',
         ROUND((data_length + index_length) / 1073741824, 2) AS 'Table Size (GB)'
    FROM information_schema.TABLES
   WHERE TABLE_SCHEMA NOT IN ('information_schema','mysql','performance_schema','sys')
ORDER BY ROUND((data_length + index_length) / 1073741824, 2) DESC


----------------------------------------------------------------------------------------------------------------


/*  Database Disk-Space Remaining ('Free' Space) */
SELECT TABLE_SCHEMA "Data Base Name", 
SUM(data_length+index_length)/1024/1024 "Data Base Size in MB", 
SUM(data_free)/1024/1024 "Free Space in MB" 
FROM information_schema.TABLES 
GROUP BY TABLE_SCHEMA;


----------------------------------------------------------------------------------------------------------------