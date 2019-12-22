### Excel - Get the data in previous row (above current cell)

```
=(INDIRECT(CONCAT("$",CHAR(64+COLUMN()),(ROW()-1))))
```


<!-- ------------------------------------------------------------ -->

<!-- Citation(s) -->

<!--   stackoverflow.com  |  "Return values from the row above to the current row"  |  https://stackoverflow.com/a/3549109 -->

<!-- ------------------------------------------------------------ -->