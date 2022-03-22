
***  
# Microsoft Excel - Get the current Date
```excel
=TEXT(NOW(),"mmm-dd, yyyy")
```
```excel
=TEXT(NOW(),"mm/dd/yyyy")
```
```excel
=TEXT(NOW(),"yyyy-mm-dd")
```

***  
# Microsoft Excel - Get the current Time
```excel
=TEXT(NOW(),"hh:mm AM/PM")
```
```excel
=TEXT(NOW(),"hh:mm:ss")
```


***  
# Microsoft Excel - Get a DateTime/Timestamp
```excel
=CONCAT(TEXT(NOW(),"yyyy-mm-dd")," @ ",TEXT(NOW(),"hh:mm AM/PM"))
```
```excel
=CONCAT(TEXT(NOW(),"mmm-dd, yyyy")," @ ",TEXT(NOW(),"hh:mm AM/PM"))
```
```excel
=CONCAT("Printed:   ",(CONCAT(TEXT(NOW(),"mmm-dd, yyyy")," @ ",TEXT(NOW(),"hh:mm AM/PM"))))
```


<!--
 ------------------------------------------------------------

  Citation(s)

    domain  |  "title"  |  url

 ------------------------------------------------------------
-->