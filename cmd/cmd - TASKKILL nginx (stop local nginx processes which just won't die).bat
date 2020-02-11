@ECHO OFF
REM ------------------------------------------------------------
REM 
REM Kill all NGINX Instances
REM 
TASKKILL /F /FI "IMAGENAME eq nginx.exe"


REM ------------------------------------------------------------