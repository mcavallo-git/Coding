
***
# Excel Formulas (Assorted)


***
### Basename
###### Get the [ File-Name + File-Extension ] for the current excel file (e.g. get the Fullpath minus the Dirname)
```=MID(CELL("filename"),SEARCH("[",CELL("filename"))+1, SEARCH("]",CELL("filename"))-SEARCH("[",CELL("filename"))-1)```


***
### Sheet-Name
###### Get the name of the currently-selected Tab/Sheet
```=MID(CELL("filename",$A$1),FIND("]",CELL("filename",$A$1))+1,255)```


***
### Date
###### Get the current Date (w/ format "yyyy-mm-dd")
```=TEXT(NOW(),"yyyy-mm-dd")```
###### Get the current Date (w/ format "mm/dd/yyyy")
```=TEXT(NOW(),"mm/dd/yyyy")```
###### Get the current Date (w/ format "mmm-dd, yyyy")
```=TEXT(NOW(),"mmm-dd, yyyy")```


***
### Time
###### Get the current time (w/ format hh:mm AM/PM)
```=TEXT(NOW(),"hh:mm AM/PM")```


***
### DateTime / Timestamp
###### Get the current Date & Time 
```
=CONCAT(TEXT(NOW(),"yyyy-mm-dd")," @ ",TEXT(NOW(),"hh:mm AM/PM"))
=CONCAT(TEXT(NOW(),"mmm-dd, yyyy")," @ ",TEXT(NOW(),"hh:mm AM/PM"))

```

