@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

REM		Created by Matt Cavallo <mcavallo@boneal.com>
REM		Creation Date: [ 2016-09-29 ]
REM		Last Updated:	[ 2018-11-28 ]

SET TARGET_HOSTNAME=%COMPUTERNAME%
SET SAGE_PUNCHIN_BNL=C:\ISO\BNL-Time.lnk
SET SAGE_PROCESS_NAME=pvxwin32.exe

SET TARGET_USERNAME=%USERNAME%
SET TARGET_USERDOMAIN=%USERDOMAIN%

REM	Optionally, target specific domain\username (instead of self)
REM SET TARGET_USERNAME=user_name
REM SET TARGET_USERDOMAIN=company_name

REM	 Find Session-ID tied to [target-user]
SET USER_SESSION_ID=NOTFOUND
FOR /F "tokens=3-4" %%a IN ('QUERY SESSION %TARGET_USERNAME%') DO (
	@IF "%%b"=="Active" (
		SET USER_SESSION_ID=%%a
	)
)

REM	 Determine if [target-user] is logged-in or not
IF NOT %USER_SESSION_ID%==NOTFOUND (

	REM	 Lock the Session for [target-user] (acts exactly the same as them selecting 'lock' from the start menu)
		RUNDLL32 USER32.DLL,LockWorkStation

	REM Wait 1 second
		TIMEOUT /T 1 > NUL

	REM	 Kill the RDP Session (Closes the Remote-Deskop window on the Client's End)
		TSDISCON %USER_SESSION_ID%

	REM	Lock the remote user-session, Wait 1 second, then Kill the RDP Session
	REM *** Note that this 'wait exactly 1 second' is so that we show (during that second) the remote PC being locked before cutting the video feed to the user's remote desktop & closing it for-them (Next Step)
	REM *** This gives the power to the user's visual inspection because it does exactly the same action as what they're used to when locking/logging-off of a PC

	REM	 Safely end SAGE sessions which were started by [target-user]
	TASKKILL /FI "USERNAME eq %TARGET_USERDOMAIN%\%TARGET_USERNAME%" /FI "IMAGENAME eq %SAGE_PROCESS_NAME%"

	ECHO.
	ECHO LOGGING OFF
	ECHO	 To cancel, close this CMD Window (Hit the top-right "X")
	ECHO.
	
)

REM	 Allow any boot-up processes (for this user's session) to complete before forcing logoff
REM	 	(Handler for login followed by immediate logoff scenario)
TIMEOUT /T 30
	
REM Log [target-user] off of the machine (cleanly)
SHUTDOWN -L

EXIT
