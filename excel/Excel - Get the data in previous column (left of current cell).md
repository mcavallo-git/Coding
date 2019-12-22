### Excel - Get the data in previous column (left of current cell)

```
=(INDIRECT(CONCAT("$",CHAR(64+COLUMN()-1),ROW())))
```
