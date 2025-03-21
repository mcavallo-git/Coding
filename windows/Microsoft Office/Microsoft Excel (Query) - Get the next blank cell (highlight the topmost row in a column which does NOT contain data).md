
***
# Microsoft Excel - Get the next blank cell

```excel
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


***
# Microsoft Excel - Highlight the topmost row in a column which does NOT contain data

- Note: This example will highlight the topmost cells in columns B and C whose rows do NOT contain data in columns A, B, or C

1. Excel > Home (top left) > Conditional Formatting > Hightlight Cells Rules > More Rules > 'Use a formula to determine which cells to format'

2. Paste the following formula into 'Formula values where this formula is true:'

```excel
=AND( AND( (INDIRECT(CONCAT("A",ROW()))=""), (INDIRECT(CONCAT("B",ROW()))=""), (INDIRECT(CONCAT("C",ROW()))="") ),   OR( (INDIRECT(CONCAT("A",(ROW()-1)))<>""), (INDIRECT(CONCAT("B",(ROW()-1)))<>""), (INDIRECT(CONCAT("C",(ROW()-1)))<>"") ), (INDIRECT(CONCAT("I",(ROW()-1)))<>"") )=TRUE
```

- Expanded view (of same formula)

```excel
=AND(
  AND(
    (INDIRECT(CONCAT("A",ROW()))=""), (INDIRECT(CONCAT("B",ROW()))=""), (INDIRECT(CONCAT("C",ROW()))="")
  ),
  OR(
    (
      INDIRECT(
        CONCAT(
          "A",
          (ROW()-1)
        )
      )<>""
    ),
    (
      INDIRECT(
        CONCAT(
          "B",
          (ROW()-1)
        )
      )<>""
    ), (
      INDIRECT(
        CONCAT(
          "C",(ROW()-1)
        )
      )<>""
    )
  ),
  (
    INDIRECT(
      CONCAT(
        "I",
        (ROW()-1)
      )
    )<>""
  )
)=TRUE
```


***
# Citation(s)
- [support.microsoft.com  |  "INDIRECT function"](https://support.microsoft.com/en-us/office/indirect-function-474b3a3a-8a26-4f44-b491-92b6306fa261)
