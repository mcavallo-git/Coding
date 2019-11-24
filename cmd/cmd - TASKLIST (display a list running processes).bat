@ECHO OFF
EXIT
REM ------------------------------------------------------------
REM 
REM TASKLIST (display a list running processes).bat
REM
REM ------------------------------------------------------------


TASKLIST /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%"


TASKLIST /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%" | FIND /I "VM"


TASKLIST /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%" /FI "IMAGENAME eq ${Name}"

tasklist /v | find "UniqueIdentifier"


REM ------------------------------------------------------------
REM Citation(s)
REM 
REM   docs.microsoft.com  |  "tasklist - Displays a list of currently running processes on the local computer or on a remote computer. Tasklist replaces the tlist tool."  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/tasklist
REM 
REM   docs.microsoft.com  |  "find - Searches for a string of text in a file or files, and displays lines of text that contain the specified string."  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/find
REM 
REM ------------------------------------------------------------