@ECHO OFF

SET KeyName=HKCU\Control Panel\Desktop
SET ValueName=AutoEndTasks
SET DataType=REG_SZ
SET DataValue=1

FOR /F "tokens=* USEBACKQ" %%a IN (
`REG QUERY "%KeyName%" /v "AutoEndTasks" /t "%DataType%" /f "%DataValue%"`
) DO ( 
	SET QUERY_KEY_VAL=%%a
)

SET ARE_REGEDITS_NEEDED=%QUERY_KEY_VAL:End of search: 1 match(es) found.=NO_REGEDITS_ARE_NEEDED%

ECHO.
IF "%ARE_REGEDITS_NEEDED%"=="NO_REGEDITS_ARE_NEEDED" (
	ECHO Registry-key "%KeyName%" already has a value with name="%ValueName%", type="%DataType%", and data="%DataValue%"
) ELSE (
	ECHO Adding a value with name="%ValueName%", type="%DataType%", and data="%DataValue%" to registry-key "%KeyName%"
	REG ADD "%KeyName%" /v "%ValueName%" /t "%DataType%" /d "%DataValue%" /f
)

ECHO.
ECHO Final state of registry key "%KeyName%", value "%ValueName%":
REG QUERY "%KeyName%" /v "%ValueName%"

TIMEOUT /T 30

REM	------------------------------------------------------------
REM
REM	Citation(s)
REM
REM		askvg.com  |  "Disable 'This App is Preventing Shutdown or Restart' Screen"  |  https://www.askvg.com/windows-tip-disable-this-app-is-preventing-shutdown-or-restart-screen
REM
REM	------------------------------------------------------------