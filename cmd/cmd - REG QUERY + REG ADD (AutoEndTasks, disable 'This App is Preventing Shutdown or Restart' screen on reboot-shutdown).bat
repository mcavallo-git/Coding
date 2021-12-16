REM ------------------------------------------------------------
REM
REM REG QUERY + REG ADD  -  Set a registry key property (if not already set as-intended)
REM


REM @SETLOCAL DisableDelayedExpansion
@SETLOCAL EnableDelayedExpansion
IF 1==1 (
  @ECHO OFF

  ECHO.
  ECHO.

  REM HKCU\Control Panel\Desktop > AutoEndTasks > Setting to "1" disables the 'This App is Preventing Shutdown or Restart' screen on reboot-shutdown)
  SET KeyName=HKCU\Control Panel\Desktop
  SET ValueName=AutoEndTasks
  SET DataType=REG_SZ
  SET Set_Value=1
  SET Current_Value=VALUE_IS_UNDEFINED

  REM ------------------
  REM Note: Use  [ %%a ] if running from within a batch script
  REM Note: Use  [  %a ] if running directly in a CMD terminal
  FOR /F "tokens=3 USEBACKQ" %a IN (
    `REG QUERY "%KeyName%" /v "%ValueName%" /t "%DataType%" ^| findstr "%ValueName%" ^| findstr "%DataType%"`
  ) DO (
    SET Current_Value=%a
  )

  ECHO Set_Value = [ %Set_Value% ]

  ECHO Current_Value = [ %Current_Value% ]

  IF NOT %Current_Value%==%Set_Value% ( REG ADD "%KeyName%" /v "%ValueName%" /t "%DataType%" /d "%Set_Value%" /f )

  REG QUERY "%KeyName%" /v "%ValueName%"
  ECHO.

  @ECHO ON
)


REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   ss64.com  |  "For - Loop through command output - Windows CMD - SS64.com"  |  https://ss64.com/nt/for_cmd.html
REM
REM   ss64.com  |  "Setlocal - Local variables - Windows CMD - SS64.com"  |  https://ss64.com/nt/setlocal.html
REM
REM   www.askvg.com  |  "Disable 'This App is Preventing Shutdown or Restart' Screen"  |  https://www.askvg.com/windows-tip-disable-this-app-is-preventing-shutdown-or-restart-screen
REM
REM ------------------------------------------------------------