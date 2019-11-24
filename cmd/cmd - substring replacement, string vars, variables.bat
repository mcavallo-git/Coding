@ECHO OFF
EXIT

@SET EXAMPLE=~~~ Hello World ~~~
@ECHO EXAMPLE (Before) = [ %EXAMPLE% ]
@SET EXAMPLE=%EXAMPLE:Hello =%
@ECHO EXAMPLE (After) = [ %EXAMPLE% ]



REM ------------------------------------------------------------
REM Citation(s)
REM
REM   ss64.com  |  "How-To: Edit/Replace text within a Variable"  |  https://ss64.com/nt/syntax-replace.html
REM
REM ------------------------------------------------------------