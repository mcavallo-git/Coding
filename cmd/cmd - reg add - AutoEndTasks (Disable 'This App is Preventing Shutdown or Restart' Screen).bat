@ECHO OFF

ECHO Calling [ REG ADD "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t "REG_SZ" /d "1" /f ]...

REG ADD "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t "REG_SZ" /d "1" /f


REM	------------------------------------------------------------
REM
REM	Citation(s)
REM
REM		askvg.com  |  "Disable 'This App is Preventing Shutdown or Restart' Screen"  |  https://www.askvg.com/windows-tip-disable-this-app-is-preventing-shutdown-or-restart-screen
REM
REM	------------------------------------------------------------