
***
# Microsoft Excel - Get the filename (basename + extension) for the current workbook/excel-file (e.g. the fullpath minus the dirname)

```excel
=MID(CELL("filename"),SEARCH("[",CELL("filename"))+1, SEARCH("]",CELL("filename"))-SEARCH("[",CELL("filename"))-1)
```


***
# Citation(s)
- [support.microsoft.com  |  "SEARCH function"](https://support.microsoft.com/en-us/office/search-function-f79ef0b8-0991-4fc1-93b0-627f019a69e3)
