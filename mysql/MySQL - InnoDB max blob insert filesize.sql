
SELECT
  @@innodb_log_file_size,
  @@innodb_log_files_in_group,
  CONCAT(ROUND(((@@innodb_log_file_size * @@innodb_log_files_in_group)/10/1024/1024),2),' MB') AS "Max blob insert filesize"
