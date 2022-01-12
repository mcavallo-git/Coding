<!-- ------------------------------------------------------------ -->
<!-- Microsoft Excel - INDIRECT  (get the value of the reference in a cell) -->
<!-- ------------------------------------------------------------ -->


# Microsoft Excel - Get the value of the reference in cell "A1"
```
=INDIRECT("A1")
```


# Microsoft Excel - Get the header row's data (e.g. row #1's data for current column)
```
=INDIRECT(CONCAT(CHAR(64+COLUMN()),1))
```


# Microsoft Excel - Get the data in previous row (above current cell)
```
=INDIRECT(CONCAT(CHAR(64+COLUMN()),(ROW()-1)))
```


# Microsoft Excel - For the current row, show nothing ("") if column A's value is "INVALID" or "NULL", otherwise show column B's value
```
=IF(
  OR(
    INDIRECT(CONCAT("A",ROW()))="INVALID",
    INDIRECT(CONCAT("A",ROW()))="NULL"
  ),
  "",
  INDIRECT(CONCAT("B",ROW())))
)
```


<!--
 ------------------------------------------------------------

  Citation(s)

    support.microsoft.com  |  "INDIRECT function"  |  https://support.microsoft.com/en-us/office/indirect-function-474b3a3a-8a26-4f44-b491-92b6306fa261

 ------------------------------------------------------------
-->