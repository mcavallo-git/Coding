
----------------------------------------------------------------------------------------------------------------


  /*   DATABASE SIZES (except system db's)   */
  SELECT CURDATE() AS 'Date',
         CURTIME() AS 'Time',
         table_schema AS 'Database',
         ROUND(SUM(data_length + index_length) / 1073741824, 2) AS 'Database Size (GB)'
    FROM information_schema.TABLES
   WHERE TABLE_SCHEMA NOT IN ('information_schema','mysql','performance_schema','sys')
GROUP BY table_schema
ORDER BY ROUND(SUM(data_length + index_length) / 1073741824, 2) DESC


----------------------------------------------------------------------------------------------------------------


  /*   TABLE SIZES, ALL DATABASES   */
  SELECT CURDATE() AS 'Date',
         CURTIME() AS 'Time',
         table_schema AS 'Database',
         ROUND((data_length + index_length) / 1073741824, 2) AS 'Table Size (GB)'
    FROM information_schema.TABLES
   WHERE TABLE_SCHEMA NOT IN ('information_schema','mysql','performance_schema','sys')
ORDER BY ROUND((data_length + index_length) / 1073741824, 2) DESC


----------------------------------------------------------------------------------------------------------------
