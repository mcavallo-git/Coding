### Excel - Get the next blank-line (to enter data into)

```
=AND(
  AND(
    (INDIRECT(CONCAT("A",ROW()))=""),
    (INDIRECT(CONCAT("B",ROW()))=""),
    (INDIRECT(CONCAT("C",ROW()))="")
  ),
  OR(
    (INDIRECT(CONCAT("A",(ROW()-1)))<>""),
    (INDIRECT(CONCAT("B",(ROW()-1)))<>""),
    (INDIRECT(CONCAT("C",(ROW()-1)))<>"")
  )
)
```
