-- MySQL - Get all Views

SELECT TABLE_SCHEMA, TABLE_NAME
FROM information_schema.tables
WHERE TABLE_TYPE LIKE 'VIEW'
-- AND TABLE_SCHEMA NOT IN ('mysql','sys')
;