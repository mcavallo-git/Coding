
***
# Microsoft Excel - Get the current Date

> Example: "Mar-22, 2022"
```excel
=TEXT(NOW(),"mmm-dd, yyyy")
```

> Example: "03/22/2022"
```excel
=TEXT(NOW(),"mm/dd/yyyy")
```

> Example: "2022-03-22"
```excel
=TEXT(NOW(),"yyyy-mm-dd")
```

***
# Microsoft Excel - Get the current Time

> Example: "11:27 AM"
```excel
=TEXT(NOW(),"hh:mm AM/PM")
```

> Example: "11:27:21"
```excel
=TEXT(NOW(),"hh:mm:ss")
```

***
# Microsoft Excel - Get a DateTime/Timestamp

> Example: "2022-03-22 @ 11:27 AM"
```excel
=CONCAT(TEXT(NOW(),"yyyy-mm-dd")," @ ",TEXT(NOW(),"hh:mm AM/PM"))
```

> Example: "Mar-22, 2022 @ 11:27 AM"
```excel
=CONCAT(TEXT(NOW(),"mmm-dd, yyyy")," @ ",TEXT(NOW(),"hh:mm AM/PM"))
```

> Example: "Printed:   Mar-22, 2022 @ 11:27 AM"
   - Intended for stamping when you printed the file
```excel
=CONCAT("Printed:   ",(CONCAT(TEXT(NOW(),"mmm-dd, yyyy")," @ ",TEXT(NOW(),"hh:mm AM/PM"))))
```
