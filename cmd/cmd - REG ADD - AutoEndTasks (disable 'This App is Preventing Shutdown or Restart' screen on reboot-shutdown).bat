IF 1==1 (
  @ECHO OFF
  ECHO.
  ECHO.
  SET KeyName=HKCU\Control Panel\Desktop
  SET ValueName=AutoEndTasks
  SET DataType=REG_SZ
  SET DataValue=1
  REM Note: Use  [ %%a ] if running from within a batch script
  REM Note: Use  [  %a ] if running directly in a CMD terminal
  FOR /F "tokens=* USEBACKQ" %a IN (
  `REG QUERY "%KeyName%" /v "AutoEndTasks" /t "%DataType%" /f "%DataValue%"`
  ) DO (
    SET QUERY_KEY_VAL=%a
  )
  SET ARE_REGEDITS_NEEDED=%QUERY_KEY_VAL:End of search: 1 match(es) found.=NO_REGEDITS_ARE_NEEDED%
  IF "%ARE_REGEDITS_NEEDED%"=="NO_REGEDITS_ARE_NEEDED" (
    ECHO %KeyName%
    ECHO   %ValueName% ^(%DataType%^) - No update^(s^) required - property is already set to "%DataValue%"^
  ) ELSE (
    ECHO %KeyName%
    ECHO   %ValueName% ^(%DataType%^) - Setting to "%DataValue%" ...
    REG ADD "%KeyName%" /v "%ValueName%" /t "%DataType%" /d "%DataValue%" /f
  )
  ECHO.
  ECHO ON
)

@REM ECHO.
@REM ECHO Final state of registry key "%KeyName%", value "%ValueName%":
@REM REG QUERY "%KeyName%" /v "%ValueName%"

@REM TIMEOUT /T 30


REM	------------------------------------------------------------
REM
REM	Citation(s)
REM
REM		askvg.com  |  "Disable 'This App is Preventing Shutdown or Restart' Screen"  |  https://www.askvg.com/windows-tip-disable-this-app-is-preventing-shutdown-or-restart-screen
REM
REM	------------------------------------------------------------