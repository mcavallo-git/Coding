@ECHO OFF
EXIT
REM https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/tasklist
REM ------------------------------------------------------------
REM 
REM TASKLIST  |Displays a list of currently running processes on the local computer or on a remote computer. Tasklist replaces the tlist tool.
REM   /V     |Displays verbose task information in the output. For complete verbose output without truncation, use /v and /svc together.
REM   /FI    |Specifies the types of processes to include in or exclude from the query. See the following table for valid filter names, operators, and values.
REM   /NH    |Specifies that the "Column Header" should not be displayed in the output.
REM 


REM Get PIDs, only
FOR /F "tokens=2-2" %a IN ('TASKLIST /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%"') DO @ECHO %a


REM Get PIDs & Image (Process) Names
FOR /F "tokens=1-2" %a IN ('TASKLIST /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%"') DO @ECHO %b  %a


REM Exact-Match based on Image (Process) Name
TASKLIST /V /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%" /FI "IMAGENAME eq explorer.exe"


REM Near-Match based on Image (Process) Name
TASKLIST /V /NH | FIND /I "vm"


REM ------------------------------------------------------------
REM
REM Tasklist, Verbose (9-column)
REM  |  Image Name  |  PID  |  Session Name  |  Session#  |  Mem Usage  |  Status  |  User Name  |  CPU Time  |  Window Title  |
REM  |  %a          |  %b   |  %c            |  %d        |  %e         |  %f      |  %g         |  %h        |  %i            |
REM
FOR /F "tokens=1-9" %a IN ('TASKLIST /V /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%"') DO @ECHO Image Name=[%a], PID=[%b], Session Name=[%c], Session#=[%d], Mem Usage=[%e], User Name=[%f], Status=[%g], CPU Time=[%h], Window Title=[%i]


REM ------------------------------------------------------------
REM
REM Tasklist, Non-Verbose (5-column)
REM  |  Image Name  |  PID  |  Session Name  |  Session#  |  Mem Usage  |
REM  |  %a          |  %b   |  %c            |  %d        |  %e         |
REM
FOR /F "tokens=1-5" %a IN ('TASKLIST /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%"') DO @ECHO %a  -  %b  -  %c  -  %d  -  %e


REM ------------------------------------------------------------
REM Citation(s)
REM 
REM   docs.microsoft.com  |  "find - Searches for a string of text in a file or files"  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/find
REM 
REM   docs.microsoft.com  |  "taskkill - Ends one or more tasks or processes"  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/taskkill
REM 
REM   docs.microsoft.com  |  "tasklist - Displays a list of currently running processes (local or remote computer)"  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/tasklist
REM 
REM   ss64.com  |  "LSS - is a 'Less Than' comparison operator for the IF command"  |  https://ss64.com/nt/lss.html
REM 
REM   ss64.com  |  "How-To: Edit/Replace text within a Variable"  |  https://ss64.com/nt/syntax-replace.html
REM 
REM   stackoverflow.com  |  "Multiplying Two Whole Numbers In Batch"  |  https://stackoverflow.com/a/20452873
REM 
REM   stackoverflow.com  |  "CMD set /a, modulus, and negative numbers"  |  https://stackoverflow.com/a/27894447
REM 
REM   stackoverflow.com  |  "How to create a unique temporary file path in command prompt without external tools? [duplicate]"  |  https://stackoverflow.com/a/32109191
REM 
REM   stackoverflow.com  |  "String processing in windows batch files: How to pad value with leading zeros?"  |  https://stackoverflow.com/a/13398719
REM 
REM ------------------------------------------------------------