@ECHO OFF
REM ------------------------------------------------------------
REM
REM Kill all Cyvera / Cortex / Traps Processes
REM
IF "1"=="1" (
TASKKILL /F /FI "IMAGENAME eq cyserver.exe"
TASKKILL /F /FI "IMAGENAME eq cytray.exe"
TASKKILL /F /FI "IMAGENAME eq CyveraService.exe"
)


REM ------------------------------------------------------------