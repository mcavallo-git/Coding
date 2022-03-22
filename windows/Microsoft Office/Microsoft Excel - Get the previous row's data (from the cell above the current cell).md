
***
# Microsoft Excel - Get the current Column-Character

```excel
=CHAR(64+COLUMN())
```

***
# Microsoft Excel - Get the current Row-Number

```excel
=ROW()
```

***
# Microsoft Excel - Generate a string referencing the Column-Character & Row-Number of the data cell in the previous row & same column (relative to the cell containing this function)

```excel
=CONCAT(CHAR(64+COLUMN()),(ROW()-1))
```

***
# Microsoft Excel - Get the data in previous row (above current cell)

```excel
=INDIRECT(CONCAT(CHAR(64+COLUMN()),(ROW()-1)))
```

***
# Microsoft Excel - Generate Averages, Max, & Min (3 new rows) referencing a dataset with a header row, full data rows, followed by the average-row, max-row, and min-row (below)

```excel
=AVERAGE(INDIRECT(CONCAT(CHAR(64+COLUMN()),2)):INDIRECT(CONCAT(CHAR(64+COLUMN()),(ROW()-1))))
```

```excel
=MAX(INDIRECT(CONCAT(CHAR(64+COLUMN()),2)):INDIRECT(CONCAT(CHAR(64+COLUMN()),(ROW()-2))))
```

```excel
=MIN(INDIRECT(CONCAT(CHAR(64+COLUMN()),2)):INDIRECT(CONCAT(CHAR(64+COLUMN()),(ROW()-3))))
```


***
# Citation(s)
- [stackoverflow.com  |  "Return values from the row above to the current row"](https://stackoverflow.com/a/3549109)
