
# Microsoft Excel - Row-Column values (for a given cell)


## Row (number):
  - ```=ROW()```
  - Example output(s):  ```1```, ```17```, ```15```


## Column (letter):
  - ```=CHAR(64+COLUMN())``
  - Example output(s):  ```A```, ```C```, ```O```


## Column & Row (letter):
  - ```=CONCAT(CHAR(64+COLUMN()),ROW())```  
  - Example output(s):  ```A1```, ```C17```, ```O15```
