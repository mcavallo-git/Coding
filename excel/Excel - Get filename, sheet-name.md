
### Excel - Get the basename of the current file
```=MID(CELL("filename"),SEARCH("[",CELL("filename"))+1, SEARCH("]",CELL("filename"))-SEARCH("[",CELL("filename"))-1)```


### Excel - Get the name of the current Tab/Sheet
```=MID(CELL("filename",$A$1),FIND("]",CELL("filename",$A$1))+1,255)```
