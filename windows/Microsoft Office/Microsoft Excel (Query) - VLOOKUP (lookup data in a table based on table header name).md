
***
# Microsoft Excel - VLOOKUP (general syntax)

```vb
=VLOOKUP(
	(What you want to look up)
	(Where you want to look for it),
	(The column number in the range containing the value to return),
	(return an Approximate or Exact match – indicated as 1/TRUE or 0/FALSE)
)
```

***
# Microsoft Excel - VLOOKUP (descriptive syntax)

```vb
=VLOOKUP(
	(What you want to look up)
	(Where you want to look for it),
	(The column number in the range containing the value to return),
	(return an Approximate or Exact match – indicated as 1/TRUE or 0/FALSE)
)
```

***
# Microsoft Excel - Do a lookup of a table

```vb
=VLOOKUP(
  A1,
  TableName[#All],
  INT(
    MATCH(
      "HeaderName",
      TableName[#Headers],
      0
    )
  ),
  0
)
```


***
# Citation(s)
- [support.microsoft.com  |  "Quick Reference Card: VLOOKUP refresher"](https://support.microsoft.com/en-us/office/quick-reference-card-vlookup-refresher-750fe2ed-a872-436f-92aa-36c17e53f2ee)
- [support.microsoft.com  |  "VLOOKUP function"](https://support.microsoft.com/en-us/office/vlookup-function-0bbc8083-26fe-4963-8ab8-93a18ad188a1)
