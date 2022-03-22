
***
# Microsoft Excel - Get target cell's row number(s) (1,2,3,...)

```excel
=ROW()
```

***
# Microsoft Excel - Get target cell's column number(s) (1,2,3,...)

```excel
=COLUMN()
```

***
# Microsoft Excel - Get target cell's column character(s) (A,B,C,...)

```excel
=CHAR(64+COLUMN())
```

***
# Microsoft Excel - Get target cell's column character concatenaced with its row number (A1,B2,C3,...)

```excel
=CONCAT(CHAR(64+COLUMN()),ROW())
```
