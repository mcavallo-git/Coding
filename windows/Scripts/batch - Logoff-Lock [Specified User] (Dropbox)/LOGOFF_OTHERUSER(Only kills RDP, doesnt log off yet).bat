
@ECHO OFF
  
	REM    Created by 
	REM      [ Matt Cavallo ]
	REM      [ mcavallo@boneal.com ]
	REM      [ 2017-11-30 ]
	
  REM   Get the Username of the Current User
SET USERNAME_TARGET=%username%

  REM   Find Session-ID tied to specified user
SET USER_SESSION_ID=NOTFOUND
ECHO.
FOR /F "tokens=3-4" %%a IN ('QUERY SESSION %USERNAME_TARGET%') DO (
	@IF "%%b"=="Active" (
		SET USER_SESSION_ID=%%a
	)
)

 REM   If a Session is found for this Username
 REM     ( If this User is currently logged in )
IF NOT %USER_SESSION_ID%==NOTFOUND (

		REM   Kill the RDP Session
		REM   (Closes the Remote-Deskop window on the Client's End)
	ECHO  Stopping Session for [%USERNAME_TARGET%]
	ECHO.
	TSDISCON %USER_SESSION_ID%

	REM Give the user a chance to log back in and stop the logoff process
	REM TIMEOUT /T 60
	REM SHUTDOWN -L -F
) ELSE (
		REM  If Session wasn't found, show this instead
		REM  of immediately closing the CMD window
	TIMEOUT /T 30
)
