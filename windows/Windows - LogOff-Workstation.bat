REM @ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

SET IMAGENAME_TO_KILL=
IF NOT "%1"=="" (
	SET IMAGENAME_TO_KILL=%1
)

SET RUNTIME_USERNAME=%USERNAME%
SET RUNTIME_USERDOMAIN=%USERDOMAIN%

SET TARGET_USERNAME=%RUNTIME_USERNAME%
SET TARGET_USERDOMAIN=%RUNTIME_USERDOMAIN%

REM	 Find Session-ID tied to [target-user]
SET USER_SESSION_ID=NOTFOUND
FOR /F "tokens=3-4" %%a IN ('QUERY SESSION %TARGET_USERNAME%') DO (
	@IF "%%b"=="Active" (
		SET USER_SESSION_ID=%%a
	)
)

REM	 Determine if [target-user] is logged-in or not
IF NOT %USER_SESSION_ID%==NOTFOUND (

	REM	 Safely end processes for sessions started by runtime-user
	IF NOT "%IMAGENAME_TO_KILL%"=="" (
		TASKKILL /FI "USERNAME eq %TARGET_USERDOMAIN%\%TARGET_USERNAME%" /FI "IMAGENAME eq %IMAGENAME_TO_KILL%"
		REM Show the screen (to see the action just performed) for just a second before proceeding (visual confirmation)
		TIMEOUT /T 1 > NUL
	)

	REM	Lock the remote user-session, Wait 1 second, then Kill the RDP Session
	REM *** Note that this 'wait exactly 1 second' is so that we show (during that second) the remote PC being locked before cutting the video feed to the user's remote desktop & closing it for-them (Next Step)
	REM *** This gives the power to the user's visual inspection because it does exactly the same action as what they're used to when locking/logging-off of a PC
	
	REM	 Lock the Session for [target-user] (acts exactly the same as them selecting 'lock' from the start menu)
	RUNDLL32 USER32.DLL,LockWorkStation

	REM Show the screen (to see the action just performed) for just a second before proceeding (visual confirmation)
	TIMEOUT /T 1 > NUL

	REM	 Kill the RDP Session (Closes the Remote-Deskop window on the Client's End)
	TSDISCON %USER_SESSION_ID%

	ECHO.
	ECHO LOGGING OFF
	ECHO	 To cancel, close this window.
	ECHO.
	
)

REM	 Allow any boot-up processes (for this user's session) to complete before forcing logoff
REM	 	(Handler for login followed by immediate logoff scenario)
TIMEOUT /T 30
	
REM Log off (Ends the current session)
SHUTDOWN -L

EXIT

REM	------------------------------------------------------------
REM	Revisioning | 2016-09-29 | Created
REM	Revisioning | 2018-11-28 | Updated | (Details missing)
REM	Revisioning | 2018-12-12 | Updated | Generalized IMAGENAME_TO_KILL as parameter #1
REM	------------------------------------------------------------
REM	Author | Matt Cavallo | https://github.com/mcavallo-git
REM	------------------------------------------------------------