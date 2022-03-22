
***
# Microsoft Excel - Get the previous column's data (from the cell left of current cell)

```excel
=(INDIRECT(CONCAT("$",CHAR(64+COLUMN()-1),ROW())))
```
