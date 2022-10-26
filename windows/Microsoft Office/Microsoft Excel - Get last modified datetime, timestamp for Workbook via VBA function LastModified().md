
## Microsoft Excel - Get last modified datetime, timestamp for Workbook via VBA function LastModified()

***
### Create VBA Module

1. Open Microsoft Excel

1. Press `Alt`+`F11` to open the Visual Basic Editor

1. Create a new module via `Insert` > `Module`

***
### Setup VBA Function `LastModified()`

1. Paste the following macro code into the module:
```vba
Function LastModified() as Date

   LastModified = ActiveWorkbook.BuiltinDocumentProperties("Last Save Time")
   
End Function
```

1. Save the module via the floppy disk icon

***
### Use VBA Function `LastModified()`

1. In your workbook, wherever you want the last modified date, set the cell contents to:
  - `=LastModified()`


<!--
# ------------------------------------------------------------
#
# Citation(s)
#
#   www.techonthenet.com  |  "MS Excel: Function that returns Last Modified date for Workbook"  |  https://www.techonthenet.com/excel/macros/last_modified.php
#
# ------------------------------------------------------------
-->