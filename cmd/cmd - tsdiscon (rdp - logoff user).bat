
@ECHO OFF
REM
REM	RDP Logoff - Disconnects RDP (remote desktop protocol) stream for target user
REM			- Matt Cavallo, 2016-09-29
REM

REM Target user to logoff (defaults to self)
SET UserNameToLogOff=%USERNAME%

REM Obtain the target-user's current Session-ID (if any)
SET UserSessionID=NULL

FOR /F "tokens=3-4" %%a IN ('QUERY SESSION %UserNameToLogOff%') DO (
	@IF "%%b"=="Active" (
		SET UserSessionID=%%a
	)
)

REM Stop any Session found matching specified user
IF NOT %UserSessionID%==NULL (

	ECHO.
	ECHO  Stopping session for [%UserNameToLogOff%]
	ECHO.

	tsdiscon %UserSessionID%

	ECHO.
	ECHO  Waiting 60s, then logging off [%UserNameToLogOff%]
	ECHO      (Close this window to cancel logoff)
	ECHO.

	REM Give the user a chance to log back in and stop the logoff process
	TIMEOUT /T 60

	shutdown.exe /l /f

) ELSE (

	REM Give the user a chance to see any error messages
	TIMEOUT /T 30

)


REM
REM Citation(s)
REM
REM		docs.microsoft.com
REM			"tsdiscon" - Disconnects a session from a Remote Desktop Session Host (rd Session Host) server
REM			 https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/tsdiscon
REM
