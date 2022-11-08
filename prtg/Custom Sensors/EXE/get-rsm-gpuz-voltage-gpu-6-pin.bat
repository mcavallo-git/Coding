@ECHO OFF
SET LOGFILE=C:\ISO\RemoteSensorMonitor\results\GPU-Z.GPU.6-Pin #1 Voltage.txt
IF NOT EXIST "%LOGFILE%" (
ECHO :ERROR - File not found: %LOGFILE%
EXIT 2
) ELSE (
TYPE %LOGFILE%
FOR /F "tokens=* delims=: USEBACKQ" %%a IN ( `TYPE %LOGFILE% ^| FINDSTR "ERROR"` ) DO ( EXIT 2 )
EXIT 0
)
REM https://www.paessler.com/manuals/prtg/custom_sensors#standard_exescript