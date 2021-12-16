REM ------------------------------------------------------------
REM
REM REG QUERY + REG ADD  -  Set a registry key property (if not already set as-intended)
REM

IF 1==1 (
  @ECHO OFF
  ECHO.
  ECHO.

  REM HKCU\Control Panel\Desktop > AutoEndTasks > Setting to "1" disables the 'This App is Preventing Shutdown or Restart' screen on reboot-shutdown)
  SET KeyName=HKCU\Control Panel\Desktop
  SET ValueName=AutoEndTasks
  SET DataType=REG_SZ
  SET DataValue=1
  SET REG_ADD_REQUIRED=1
  REM Note: Use  [ %%a ] if running from within a batch script
  REM Note: Use  [  %a ] if running directly in a CMD terminal
  FOR /F "tokens=3 USEBACKQ" %a IN (
    `REG QUERY "%KeyName%" /v "%ValueName%" /t "%DataType%" ^| findstr "%ValueName%" ^| findstr "%DataType%"`
  ) DO (
    SET Current_DataValue=%a
    IF %Current_DataValue%==%DataValue% (
      SET REG_ADD_REQUIRED=0
    ) ELSE (
      SET REG_ADD_REQUIRED=1
    )
  )
  IF %REG_ADD_REQUIRED%==1 (
    REG ADD "%KeyName%" /v "%ValueName%" /t "%DataType%" /d "%DataValue%" /f
  )

  REG QUERY "%KeyName%" /v "%ValueName%"
  ECHO.
  @ECHO ON
)

REM	------------------------------------------------------------
REM
REM	Citation(s)
REM
REM		askvg.com  |  "Disable 'This App is Preventing Shutdown or Restart' Screen"  |  https://www.askvg.com/windows-tip-disable-this-app-is-preventing-shutdown-or-restart-screen
REM
REM	------------------------------------------------------------