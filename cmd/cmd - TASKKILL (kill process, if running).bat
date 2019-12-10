@ECHO OFF
REM
REM ------------------------------------------------------------
REM
REM Get PID --> Splashtop remote connection(s)
REM
SET EXE_SPLASHTOP=SRFeature.exe

SET PID_SPLASHTOP=No
FOR /F "tokens=2-2" %%a IN ('TASKLIST /FI "IMAGENAME eq %EXE_SPLASHTOP%"') DO (
	SET PID_SPLASHTOP=%%a
)
ECHO PID_SPLASHTOP = %PID_SPLASHTOP%

REM		Kill PID --> Splashtop remote connection(s)
IF NOT %PID_SPLASHTOP%==No (
	TASKKILL /F /FI "IMAGENAME eq %EXE_SPLASHTOP%"
	REM TASKKILL /F /PID %PID_SPLASHTOP%
	TIMEOUT /T 1 > NUL
)

TIMEOUT /T 60


REM ------------------------------------------------------------
REM 
REM Kill NGINX
REM 
TASKKILL /F /FI "IMAGENAME eq nginx.exe"
TIMEOUT /T 60


REM ------------------------------------------------------------
REM 
REM Kill VMWare
REM 
TASKKILL /F /FI "IMAGENAME eq vmware.exe"
TIMEOUT /T 60


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