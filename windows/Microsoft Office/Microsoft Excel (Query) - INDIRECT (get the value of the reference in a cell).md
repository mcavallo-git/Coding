
***
# Microsoft Excel - INDIRECT - Get the value of cell "A1"

```excel
=INDIRECT("A1")
```

***
# Microsoft Excel - INDIRECT - Get the value in the current cell (should give circular reference error)
```excel
=INDIRECT(CONCAT(CHAR(64+COLUMN()),(ROW())))
```

***
# Microsoft Excel - INDIRECT - Get the header row's data (e.g. row #1's data for current column)

```excel
=INDIRECT(CONCAT(CHAR(64+COLUMN()),1))
```

***
# Microsoft Excel - INDIRECT - Get the data in the same column, but previous row(above current cell)

```excel
=INDIRECT(CONCAT(CHAR(64+COLUMN()),(ROW()-1)))
```

***
# Microsoft Excel - INDIRECT - For the current row, show nothing ("") if column A's value is "INVALID" or "NULL", otherwise show column B's value

```excel
=IF(
  OR(
    INDIRECT(CONCAT("A",ROW()))="INVALID",
    INDIRECT(CONCAT("A",ROW()))="NULL"
  ),
  "",
  INDIRECT(CONCAT("B",ROW())))
)
```


***
# Citation(s)
- [support.microsoft.com  |  "INDIRECT function"](https://support.microsoft.com/en-us/office/indirect-function-474b3a3a-8a26-4f44-b491-92b6306fa261)
