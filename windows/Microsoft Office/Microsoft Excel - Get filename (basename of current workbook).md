
***
# Microsoft Excel - Get the filename (basename + extension) for the current workbook/excel-file (e.g. the fullpath minus the dirname)

- ```excel
  =MID(CELL("filename"),SEARCH("[",CELL("filename"))+1, SEARCH("]",CELL("filename"))-SEARCH("[",CELL("filename"))-1)
  ```

- ```excel
  =CONCAT("File:   '",(MID(CELL("filename"),SEARCH("[",CELL("filename"))+1, SEARCH("]",CELL("filename"))-SEARCH("[",CELL("filename"))-1)),"'")
  ```


<!--
 ------------------------------------------------------------

  Citation(s)

    domain  |  "title"  |  url

 ------------------------------------------------------------
-->