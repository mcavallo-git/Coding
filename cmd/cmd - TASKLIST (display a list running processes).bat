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

REM Filter TASKLIST using NON exact process-name matching (contains ...)
TASKLIST /V /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%" | FIND /I "explorer"

REM Filter TASKLIST using EXACT process-name matching
TASKLIST /V /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%" /FI "IMAGENAME eq explorer.exe"


TASKLIST /V | find "UniqueIdentifier"

REM PIDs - List only the set of matching PIDs for filtered process(es)
FOR /F "tokens=2-2" %a IN ('TASKLIST /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%"') DO @ECHO %a

REM Perform actions based on separate columns output from the TASKLIST command

REM ------------------------------------------------------------
REM Perform actions based on separate columns output from given TASKLIST command


REM ------------------------------------------------------------
REM
REM Verbose (9-column)
REM  |  Image Name  |  PID  |  Session Name  |  Session#  |  Mem Usage  |  Status  |  User Name  |  CPU Time  |  Window Title  |
REM  |  %a          |  %b   |  %c            |  %d        |  %e         |  %f      |  %g         |  %h        |  %i            |
REM
FOR /F "tokens=1-9" %a IN ('TASKLIST /V /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%"') DO @ECHO Image Name=[%a], PID=[%b], Session Name=[%c], Session#=[%d], Mem Usage=[%e], User Name=[%f], Status=[%g], CPU Time=[%h], Window Title=[%i]


REM ------------------------------------------------------------
REM
REM Non-Verbose (5-column)
REM  |  Image Name  |  PID  |  Session Name  |  Session#  |  Mem Usage  |
REM  |  %a          |  %b   |  %c            |  %d        |  %e         |
REM
FOR /F "tokens=1-5" %a IN ('TASKLIST /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%"') DO @ECHO %a  -  %b  -  %c  -  %d  -  %e


FOR /F "tokens=1-2" %a IN ('TASKLIST /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%"') DO @TASKLIST /V /NH /FI "PID eq %a" | FIND /I "VMWARE"

FOR /F "tokens=1-2" %a IN ('TASKLIST /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%"') DO @ECHO %b | FIND /I "VMWARE"

ECHO EXE_LIST = [ %EXE_LIST% ]


FOR /F "tokens=1-2" %a IN ('TASKLIST /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%"') DO ( @ECHO %b  %a )

REM ------------------------------------------------------------
REM 
REM  VAR:|  %a          |  %b   |  %c            |  %d        |  %e         |  %f      |  %g         |  %h        |  %i            |
REM  VAL:|  Image Name  |  PID  |  Session Name  |  Session#  |  Mem Usage  |  Status  |  User Name  |  CPU Time  |  Window Title  |
REM 


REM ------------------------------------------------------------
REM Citation(s)
REM 
REM   docs.microsoft.com  |  "find - Searches for a string of text in a file or files, and displays lines of text that contain the specified string."  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/find
REM 
REM   docs.microsoft.com  |  "taskkill - Ends one or more tasks or processes. Processes can be ended by process ID or image name. taskkill replaces the kill tool."  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/taskkill
REM 
REM   docs.microsoft.com  |  "tasklist - Displays a list of currently running processes on the local computer or on a remote computer. Tasklist replaces the tlist tool."  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/tasklist
REM 
REM ------------------------------------------------------------