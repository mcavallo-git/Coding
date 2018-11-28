
@ECHO OFF

  REM Matt Cavallo - mcavallo@boneal.com
  REM 2016-09-29

  REM Define a username to single out and log off
  REM SET USER_TO_LOGOFF=mcavallo

  REM  Log off the user running this batch file (%username%)
SET USER_TO_LOGOFF=%username%

  REM Find User's Session
SET USER_SESSION_ID=DECLARATION
ECHO.
FOR /F "tokens=3-4" %%a IN ('QUERY SESSION %USER_TO_LOGOFF%') DO (
	@IF "%%b"=="Active" (
		SET USER_SESSION_ID=%%a
	)
)

  REM Stop any Session found matching specified user
IF NOT %USER_SESSION_ID%==DECLARATION (
	ECHO  Stopping session for [%USER_TO_LOGOFF%]
	ECHO.
	TSDISCON %USER_SESSION_ID%
	ECHO  Waiting 60s, then logging off [%USER_TO_LOGOFF%]
	ECHO      (Close this window to cancel logoff)
	ECHO.
	REM Give the user a chance to log back in and stop the logoff process
	TIMEOUT /T 60
	SHUTDOWN -L -F
) ELSE (
	REM Give the user a chance to see any error messages
	TIMEOUT /T 30
)