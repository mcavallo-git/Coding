# MySQL - DateTimes & Timestamps


### MySQL - Schema required for saving additional datetime precision beyond seconds, to milli/micro seconds
```

Data type should be:

DATETIME(3) for milliseconds

DATETIME(6) for microseconds

```
[Thanks to user "l33t" on StackOverflow forums](https://stackoverflow.com/questions/13344994/mysql-5-6-datetime-doesnt-accept-milliseconds-microseconds)
***



### MySQL - Determine current Schema of a database regarding timestamps
```

SELECT *
FROM information_schema.COLUMNS
WHERE true
AND TABLE_SCHEMA IN ('MY_DB_NAME')
AND DATA_TYPE IN ('datetime','time','timestamp')
ORDER BY DATA_TYPE ASC
LIMIT 0,250

```
***



### Save a javascript date object (with milliseconds) into MySQL
```

FROM_UNIXTIME(JS_DATE_VAR * 0.001)

```
***