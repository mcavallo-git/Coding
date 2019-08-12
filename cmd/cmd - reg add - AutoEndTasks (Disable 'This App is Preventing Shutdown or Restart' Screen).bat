@ECHO OFF

SET KeyName=HKCU\Control Panel\Desktop
SET ValueName=AutoEndTasks
SET DataType=REG_SZ
SET DataValue=1

ECHO.
ECHO --- Calling [ REG QUERY "%KeyName%" /v "%ValueName%" ] (Before Update)...
REG QUERY  "%KeyName%" /v "AutoEndTasks"

ECHO.
ECHO --- Calling [ REG ADD "%KeyName%" /v "%ValueName%" /t "%DataType%" /d "%DataValue%" /f ]...
REG ADD "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t "REG_SZ" /d "1" /f

ECHO.
ECHO --- Calling [ REG QUERY "%KeyName%" /v "%ValueName%" ]  (After Update)...
REG QUERY  "%KeyName%" /v "AutoEndTasks"

TIMEOUT /T 30

REM	------------------------------------------------------------
REM
REM	Citation(s)
REM
REM		askvg.com  |  "Disable 'This App is Preventing Shutdown or Restart' Screen"  |  https://www.askvg.com/windows-tip-disable-this-app-is-preventing-shutdown-or-restart-screen
REM
REM	------------------------------------------------------------