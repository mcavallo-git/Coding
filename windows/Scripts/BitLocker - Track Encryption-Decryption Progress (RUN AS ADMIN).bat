@ECHO OFF
:LOOP
  CLS
  MANAGE-BDE -STATUS C:
  TIMEOUT /T 5 > NUL
GOTO LOOP

REM Reference: https://superuser.com/questions/191063/what-is-the-windows-analog-of-the-linux-watch-command
REM User - "harrymc", Site - "superuser.com"