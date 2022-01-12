<!-- ------------------------------------------------------------ -->

### Excel - Get the next blank cell

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

<!-- ------------------------------------------------------------ -->

### Excel - Highlight the topmost row in a column which does NOT contain data
###### Note: This example will highlight the topmost cells in columns B and C whose rows do NOT contain data in columns A, B, or C

Excel > Home (top left) > Conditional Formatting > Hightlight Cells Rules > More Rules > 'Use a formula to determine which cells to format'

Paste the following formula into 'Formula values where this formula is true:'

```=AND( AND( (INDIRECT(CONCAT("A",ROW()))=""), (INDIRECT(CONCAT("B",ROW()))=""), (INDIRECT(CONCAT("C",ROW()))="") ),   OR( (INDIRECT(CONCAT("A",(ROW()-1)))<>""), (INDIRECT(CONCAT("B",(ROW()-1)))<>""), (INDIRECT(CONCAT("C",(ROW()-1)))<>"") ), (INDIRECT(CONCAT("I",(ROW()-1)))<>"") )=TRUE```


##### Expanded view (of same formula)
```
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



<!--
 ------------------------------------------------------------

  Citation(s)

    domain  |  "title"  |  url

 ------------------------------------------------------------
-->