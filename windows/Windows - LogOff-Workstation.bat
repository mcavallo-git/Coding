@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

REM
REM		Created by Matt Cavallo <mcavallo@boneal.com>
REM		Creation Date: [ 2016-09-29 ]
REM		Updated:	[ 2018-11-28 ]
REM		Updated:	[ 2018-12-12 ] Generalized IMAGENAME_TO_KILL as parameter #1
REM		Updated:	[ 2019-08-02 ] Replaced 'SHUTDOWN /L /F' with 'logoff.exe' implementation
REM		Updated:	[ 2019-08-02 ] Added logging to disk
REM		Updated:	[ 2019-08-02 ] Added TIMESTAMP to output
REM

SET LOGFILE=%TEMP%\logoff.log
SET IMAGENAME_TO_KILL=
IF NOT "%1"=="" (
	SET IMAGENAME_TO_KILL=%1
)

SET RUNTIME_USERNAME=%USERNAME%
SET RUNTIME_USERDOMAIN=%USERDOMAIN%

SET TARGET_USERNAME=%RUNTIME_USERNAME%
SET TARGET_USERDOMAIN=%RUNTIME_USERDOMAIN%

REM
REM Show the current runtime's Timestamp
REM
FOR /F "tokens=* USEBACKQ" %%F IN (`DATE /T`) DO SET TIMESTAMP=%TIMESTAMP%%%F
FOR /F "tokens=* USEBACKQ" %%F IN (`TIME /T`) DO SET TIMESTAMP=%TIMESTAMP%%%F
ECHO. >> %LOGFILE% 2>&1
ECHO TIMESTAMP = %TIMESTAMP% >> %LOGFILE% 2>&1
ECHO. >> %LOGFILE% 2>&1

REM
REM	Find Session-ID tied to [target-user]
REM
SET USER_SESSION_ID=NOTFOUND
FOR /F "tokens=3-4" %%a IN ('QUERY SESSION %TARGET_USERNAME%') DO (
	@IF "%%b"=="Active" (
		SET USER_SESSION_ID=%%a
	)
)

REM
REM	Determine if [target-user] is logged-in or not
REM
IF NOT %USER_SESSION_ID%==NOTFOUND (

	REM
	REM	Safely end processes for sessions started by runtime-user
	REM
	IF NOT "%IMAGENAME_TO_KILL%"=="" (
		TASKKILL /F /FI "USERNAME eq %TARGET_USERDOMAIN%\%TARGET_USERNAME%" /FI "IMAGENAME eq %IMAGENAME_TO_KILL%"
		REM Wait 1 second (to give the user visual confirmation that their session is locked before closing their tunnel)
			TIMEOUT /T 1 >> %LOGFILE% 2>&1
	)

	REM	Lock the Session for [target-user]
	REM	  |--> Visually depicted the same as if they selected 'lock' (from the start menu) on a local Windows workstation
		RUNDLL32 USER32.DLL,LockWorkStation >> %LOGFILE% 2>&1

	REM Wait 1 second
		TIMEOUT /T 1 >> %LOGFILE% 2>&1

	REM	 Kill the RDP Session (Closes the Remote-Deskop window on the Client's End)
		TSDISCON %USER_SESSION_ID% >> %LOGFILE% 2>&1

	ECHO. >> %LOGFILE% 2>&1
	ECHO LOGGING OFF >> %LOGFILE% 2>&1
	ECHO	 To cancel, close this CMD Window (Hit the top-right "X") >> %LOGFILE% 2>&1
	ECHO. >> %LOGFILE% 2>&1


	REM
	REM	Allow any boot-up processes (for this user's session) to complete before forcing logoff
	REM	  |--> Use-Case: Log-on followed immediately by a log-off
	REM
	TIMEOUT /T 30 >> %LOGFILE% 2>&1

	REM
	REM Logoff (specific user-session)
	REM
	%SystemRoot%\System32\logoff.exe %USER_SESSION_ID% /V >> %LOGFILE% 2>&1

) ELSE (

	REM
	REM Logoff
	REM
	%SystemRoot%\System32\logoff.exe /V >> %LOGFILE% 2>&1

)

EXIT
