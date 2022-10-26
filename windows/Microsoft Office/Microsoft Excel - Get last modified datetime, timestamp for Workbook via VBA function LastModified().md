
## Microsoft Excel - Get last modified datetime, timestamp for Workbook via VBA function LastModified()

***
### Create VBA Module

1. Open Microsoft Excel

1. Open the Visual Basic Editor by pressing `Alt`+`F11` or manually selecting it via `Developers` (ribbon tab) > `Visual Basic` (left-hand side of ribbon)

1. Create a new module via `Insert` > `Module`

***
### Setup VBA Function `LastModified()`

1. Paste the following macro code into the module:
   ```vba
   Function LastModified() as Date
 
     LastModified = ActiveWorkbook.BuiltinDocumentProperties("Last Save Time")

  End Function
  ```

1. Save the VMA Module by pressing `Ctrl`+`S` or by manually clicking the floppy disk save icon

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