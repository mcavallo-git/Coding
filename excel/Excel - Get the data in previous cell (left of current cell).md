### Excel - Get the data in previous cell (left of current cell)

```=(INDIRECT(CONCAT("$",CHAR(64+COLUMN()-1),ROW())))```
