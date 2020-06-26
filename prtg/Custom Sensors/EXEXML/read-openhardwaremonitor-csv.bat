@ECHO OFF
@SETLOCAL enableextensions disabledelayedexpansion

REM ------------------------------------------------------------
REM
REM PRTG - Parse OpenHardware Monitor's CSV logs
REM
REM ------------------------------------------------------------
REM
REM Setting-up CSV logging in OpenHardware Monitor:
REM  > Run OpenHardware Monitor
REM   > Select "Options" (top)
REM    > Select "Log Sensors" (will have a checkmark next to it if actively logging to CSV)
REM
REM ------------------------------------------------------------

REM Static Directory equal to the dirname of wherever OpenHardware Monitor's EXE file
SET OPEN_HARDWARE_MONITOR_LOGS_DIRNAME=C:\ISO\OpenHardwareMonitor

FOR /F "tokens=1,2,3 delims=/" %%a IN ("%NOW_DATE%") DO (
	SET NOW_YEAR=%%c
	SET NOW_MONTH=%%a
	SET NOW_DAY=%%b
)

REM FOR /F "tokens=3 delims=/" %%a IN ("%NOW_DATE%") DO SET NOW_YEAR=%a
REM FOR /F "tokens=1 delims=/" %%a IN ("%NOW_DATE%") DO SET NOW_MONTH=%a
REM FOR /F "tokens=2 delims=/" %%a IN ("%NOW_DATE%") DO SET NOW_DAY=%a

ECHO NOW_YEAR=%NOW_YEAR%
ECHO NOW_MONTH=%NOW_MONTH%
ECHO NOW_DAY=%NOW_DAY%

REM Dynamic filename which cannot be changed (unless OpenHardware Monitor's developers change)
SET OPEN_HARDWARE_MONITOR_LOGS_BASENAME=OpenHardwareMonitorLog-%NOW_YEAR%-%NOW_MONTH%-%NOW_DAY%.csv

SET OPEN_HARDWARE_MONITOR_LOGS_FULLPATH=%OPEN_HARDWARE_MONITOR_LOGS_DIRNAME%\%OPEN_HARDWARE_MONITOR_LOGS_BASENAME%

ECHO OPEN_HARDWARE_MONITOR_LOGS_FULLPATH=%OPEN_HARDWARE_MONITOR_LOGS_FULLPATH%


REM ------------------------------------------------------------

for /F "tokens=*" %%G in ('type "%%~x"') do set "lastline=%%G"

FOR /f "usebackq tokens=1-4 delims=," %%a IN ("%OPEN_HARDWARE_MONITOR_LOGS_FULLPATH%") DO (ECHO %%a %%b %%c %%d )


REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   stackoverflow.com  |  "read csv file through windows batch file and create txt file - Stack Overflow"  |  https://stackoverflow.com/a/24928087
REM
REM ------------------------------------------------------------