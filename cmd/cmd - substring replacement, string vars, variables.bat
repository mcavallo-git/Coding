@ECHO OFF
EXIT


REM ------------------------------------------------------------
REM   REPLACE Substring
SET EXAMPLE=Hello World
SET DAT_REPLACE=%EXAMPLE:Hello=Goodbye%
ECHO EXAMPLE = [ %EXAMPLE% ],  DAT_REPLACE = [ %DAT_REPLACE% ]


REM ------------------------------------------------------------
REM   REMOVE Substring
SET EXAMPLE=Hello World
SET DAT_REMOVE=%EXAMPLE:Hello=%
ECHO EXAMPLE = [ %EXAMPLE% ],  DAT_REMOVE = [ %DAT_REMOVE% ]


REM ------------------------------------------------------------
REM   Get the Leftmost [ X ] chars in a string variable
SET EXAMPLE=Hello World
SET DAT_LEFT_CHARSET=%EXAMPLE:~0,4%
ECHO EXAMPLE = [ %EXAMPLE% ],  DAT_LEFT_CHARSET = [ %DAT_LEFT_CHARSET% ]


REM ------------------------------------------------------------
REM   Get the Rightmost [ X ] chars in a string variable
SET EXAMPLE=Hello World
SET DAT_RIGHT_CHARSET=%EXAMPLE:~-4%
ECHO EXAMPLE = [ %EXAMPLE% ],  DAT_RIGHT_CHARSET = [ %DAT_RIGHT_CHARSET% ]


REM ------------------------------------------------------------
REM Citation(s)
REM
REM   ss64.com  |  "How-To: Edit/Replace text within a Variable"  |  https://ss64.com/nt/syntax-replace.html
REM
REM ------------------------------------------------------------