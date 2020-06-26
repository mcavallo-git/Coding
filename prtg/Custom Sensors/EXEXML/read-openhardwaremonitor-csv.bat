REM ------------------------------------------------------------
REM
REM Read the logs which get automatically output by OpenHardware Monitor
REM
REM To setup OpenHardware Monitor to output to CSV file (at a given rate of time):
REM  > Run OpenHardware Monitor
REM   > Select "Options" (top)
REM    > Select "Log Sensors" (will have a checkmark next to it if actively logging to CSV)
REM

REM Static Directory equal to the dirname of wherever OpenHardware Monitor's EXE file
OPEN_HARDWARE_MONITOR_LOGS_DIRNAME="C:\ISO\OpenHardwareMonitor"

FOR /F "tokens=3 delims=/" %a IN ('ECHO %NOW_DATE%') DO SET NOW_YEAR=%a
FOR /F "tokens=1 delims=/" %a IN ('ECHO %NOW_DATE%') DO SET NOW_MONTH=%a
FOR /F "tokens=2 delims=/" %a IN ('ECHO %NOW_DATE%') DO SET NOW_DAY=%a

ECHO NOW_YEAR=%NOW_YEAR%
ECHO NOW_MONTH=%NOW_MONTH%
ECHO NOW_DAY=%NOW_DAY%

REM Dynamic filename which cannot be changed (unless OpenHardware Monitor's developers change)
OPEN_HARDWARE_MONITOR_LOGS_BASENAME="OpenHardwareMonitorLog-%NOW_YEAR%-%NOW_MONTH%-%NOW_DAY%.csv"

OPEN_HARDWARE_MONITOR_LOGS_FULLPATH="%OPEN_HARDWARE_MONITOR_LOGS_DIRNAME%\%OPEN_HARDWARE_MONITOR_LOGS_BASENAME%"


REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   domain  |  "title"  |  url
REM
REM ------------------------------------------------------------