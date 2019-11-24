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

TASKLIST /V /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%"

REM List only processes with name containing given string (defined as FIND search-variable)

TASKLIST /V /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%" | FIND /I "VMWARE"

REM List only processes with name exactly-matching given string (defined as FIND search-variable)

TASKLIST /V /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%" /FI "IMAGENAME eq ${Name}"



TASKLIST /V | find "UniqueIdentifier"



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