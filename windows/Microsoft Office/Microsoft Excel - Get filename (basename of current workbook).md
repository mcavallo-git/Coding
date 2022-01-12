
***
# Microsoft Excel - Get the filename (basename + extension) for the current workbook/excel-file (e.g. get the Fullpath minus the Dirname)
```=MID(CELL("filename"),SEARCH("[",CELL("filename"))+1, SEARCH("]",CELL("filename"))-SEARCH("[",CELL("filename"))-1)```
```=CONCAT("File:   '",(MID(CELL("filename"),SEARCH("[",CELL("filename"))+1, SEARCH("]",CELL("filename"))-SEARCH("[",CELL("filename"))-1)),"'")```


<!--
 ------------------------------------------------------------

  Citation(s)

    domain  |  "title"  |  url

 ------------------------------------------------------------
-->