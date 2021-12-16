@ECHO OFF
SET LOGFILE=C:\ISO\OpenHardwareMonitor\OHW-Current-Clock-GPU-Core-Min.txt
IF NOT EXIST "%LOGFILE%" (
ECHO :ERROR - File not found: %LOGFILE%
EXIT 2
) ELSE (
TYPE %LOGFILE%
FOR /F "tokens=* delims=: USEBACKQ" %%a IN ( `TYPE %LOGFILE% ^| FINDSTR "ERROR"` ) DO ( EXIT 2 )
EXIT 0
)