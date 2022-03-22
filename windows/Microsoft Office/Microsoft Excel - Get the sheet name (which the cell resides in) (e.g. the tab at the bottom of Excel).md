
***
# Microsoft Excel - Get the sheet name (which the cell resides in) (e.g. the tab at the bottom of Excel)

```excel
=MID(CELL("filename",$A$1),FIND("]",CELL("filename",$A$1))+1,255)
```

```excel
=CONCAT("Sheet:   '",(MID(CELL("filename",$A$1),FIND("]",CELL("filename",$A$1))+1,255)),"'")
```
