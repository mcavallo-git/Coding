
***
# Microsoft Excel - Get the name of the sheet which the cell resides in (e.g. the tab at the bottom of Excel)
```=MID(CELL("filename"),SEARCH("[",CELL("filename"))+1, SEARCH("]",CELL("filename"))-SEARCH("[",CELL("filename"))-1)```
```=CONCAT("File:   '",(MID(CELL("filename"),SEARCH("[",CELL("filename"))+1, SEARCH("]",CELL("filename"))-SEARCH("[",CELL("filename"))-1)),"'")```

***
# Microsoft Excel - Sheet-Name
## Get the name of the currently-selected Tab/Sheet
```=MID(CELL("filename",$A$1),FIND("]",CELL("filename",$A$1))+1,255)```
```=CONCAT("Sheet:   '",(MID(CELL("filename",$A$1),FIND("]",CELL("filename",$A$1))+1,255)),"'")```



<!--
 ------------------------------------------------------------

  Citation(s)

    domain  |  "title"  |  url

 ------------------------------------------------------------
-->