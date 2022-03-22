

## Microsoft Excel - Get target cell's row number(s) (1,2,3,...)
- ```excel
  =ROW()
  ```


## Microsoft Excel - Get target cell's column number(s) (1,2,3,...)
- ```excel
  =COLUMN()
  ```


## Microsoft Excel - Get target cell's column character(s) (A,B,C,...)
- ```excel
  =CHAR(64+COLUMN())
  ```


<!-- ------------------------------ -->

## Column & Row (letter):
- ```excel
  =CONCAT(CHAR(64+COLUMN()),ROW())
  ```


<!-- ------------------------------ -->