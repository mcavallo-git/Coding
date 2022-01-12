
***
# Microsoft Excel - Get the current Date
```=TEXT(NOW(),"mmm-dd, yyyy")```
```=TEXT(NOW(),"mm/dd/yyyy")```
```=TEXT(NOW(),"yyyy-mm-dd")```


***
# Microsoft Excel - Get the current Time
```=TEXT(NOW(),"hh:mm AM/PM")```
```=TEXT(NOW(),"hh:mm:ss")```


***
# Microsoft Excel - Get a DateTime/Timestamp
```=CONCAT(TEXT(NOW(),"yyyy-mm-dd")," @ ",TEXT(NOW(),"hh:mm AM/PM"))```
```=CONCAT(TEXT(NOW(),"mmm-dd, yyyy")," @ ",TEXT(NOW(),"hh:mm AM/PM"))```
```=CONCAT("Printed:   ",(CONCAT(TEXT(NOW(),"mmm-dd, yyyy")," @ ",TEXT(NOW(),"hh:mm AM/PM"))))```


<!--
 ------------------------------------------------------------

  Citation(s)

    domain  |  "title"  |  url

 ------------------------------------------------------------
-->