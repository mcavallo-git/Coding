

### Excel - Get the current Column-Character
```
=CHAR(64+COLUMN())
```


### Excel - Get the current Row-Number
```
=ROW()
```


### Excel - Generate a string referencing the Column-Character & Row-Number of the data cell in the previous row & same column (relative to the cell containing this function)
```
=CONCAT(CHAR(64+COLUMN()),(ROW()-1))
```


### Excel - Get the data in previous row (above current cell)
```
=(INDIRECT(CONCAT(CHAR(64+COLUMN()),(ROW()-1))))
```


### Excel - Generate Averages, Max, & Min (3 new rows) referencing a dataset with a header row, full data rows, followed by the average-row, max-row, and min-row (below)
=AVERAGE(INDIRECT(CONCAT(CHAR(64+COLUMN()),2)):INDIRECT(CONCAT(CHAR(64+COLUMN()),(ROW()-1))))
=MAX(INDIRECT(CONCAT(CHAR(64+COLUMN()),2)):INDIRECT(CONCAT(CHAR(64+COLUMN()),(ROW()-2))))
=MIN(INDIRECT(CONCAT(CHAR(64+COLUMN()),2)):INDIRECT(CONCAT(CHAR(64+COLUMN()),(ROW()-3))))


<!-- ------------------------------------------------------------ -->

<!-- Citation(s) -->

<!--   stackoverflow.com  |  "Return values from the row above to the current row"  |  https://stackoverflow.com/a/3549109 -->

<!-- ------------------------------------------------------------ -->