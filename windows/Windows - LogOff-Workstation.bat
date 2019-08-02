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
SET RUNTIME_DOMAIN=%USERDOMAIN%
SET RUNTIME_UNAME=%USERNAME%


REM
REM Show the current runtime's Timestamp
REM
FOR /F "tokens=* USEBACKQ" %%F IN (`DATE /T`) DO SET TIMESTAMP=%TIMESTAMP%%%F
FOR /F "tokens=* USEBACKQ" %%F IN (`TIME /T`) DO SET TIMESTAMP=%TIMESTAMP%%%F
ECHO. >> %LOGFILE% 2>&1
ECHO Starting Script >> %LOGFILE% 2>&1
ECHO TIMESTAMP = %TIMESTAMP% >> %LOGFILE% 2>&1


REM
REM	Inline-Parameter #1 --> Add task before logging off which is ending a specific process (if it is found to be running)
REM
SET IMAGENAME_TO_KILL=
IF NOT "%1"=="" (
	SET IMAGENAME_TO_KILL=%1
)


REM
REM	Set current User & Domain as the target User & Domain
REM
SET TARGET_UNAME=%RUNTIME_UNAME%
SET TARGET_DOMAIN=%RUNTIME_DOMAIN%


REM
REM	Set current Session-ID as the target Session-ID
REM
SET TARGET_SESSION_ID=NOTFOUND
FOR /F "tokens=3-4" %%a IN ('QUERY SESSION %TARGET_UNAME%') DO (
	@IF "%%b"=="Active" (
		ECHO Calling [ SET TARGET_SESSION_ID=%%a ]... >> %LOGFILE% 2>&1
			SET TARGET_SESSION_ID=%%a
	)
)


REM
REM	Determine if [target-user] is logged-in or not
REM
ECHO TARGET_SESSION_ID = %TARGET_SESSION_ID%
IF NOT %TARGET_SESSION_ID%==NOTFOUND (

	REM
	REM	End processes for sessions started by target-user
	REM
	IF NOT "%IMAGENAME_TO_KILL%"=="" (
		ECHO Calling [ TASKKILL /F /FI "USERNAME eq %TARGET_DOMAIN%\%TARGET_UNAME%" /FI "IMAGENAME eq %IMAGENAME_TO_KILL%" ]... >> %LOGFILE% 2>&1
			TASKKILL /F /FI "USERNAME eq %TARGET_DOMAIN%\%TARGET_UNAME%" /FI "IMAGENAME eq %IMAGENAME_TO_KILL%"
		TIMEOUT /T 1
	)

	REM	Lock the Session for [target-user]
	REM	  |--> Visually depicted the same as if they selected 'lock' (from the start menu) on a local Windows workstation
	ECHO Calling [ RUNDLL32 USER32.DLL,LockWorkStation ]... >> %LOGFILE% 2>&1
		RUNDLL32 USER32.DLL,LockWorkStation >> %LOGFILE% 2>&1
	TIMEOUT /T 1

	REM	 Kill the RDP Session (Closes the Remote-Deskop window on the Client's End)
	ECHO Calling [ TSDISCON %TARGET_SESSION_ID% ]... >> %LOGFILE% 2>&1
		TSDISCON %TARGET_SESSION_ID% >> %LOGFILE% 2>&1

	REM
	REM	Logoff
	REM	  |--> Add a small wait-period before logging-off (to allow startup processes to complete as-intended)
	REM	        |--> Use-Case: Log-on followed immediately by a log-off
	REM
	TIMEOUT /T 30
	ECHO Calling [ %SystemRoot%\System32\logoff.exe %TARGET_SESSION_ID% /V ]... >> %LOGFILE% 2>&1
		%SystemRoot%\System32\logoff.exe %TARGET_SESSION_ID% /V >> %LOGFILE% 2>&1

) ELSE (

	REM
	REM Logoff (current user)
	REM
	ECHO Calling [ %SystemRoot%\System32\logoff.exe /V ]... >> %LOGFILE% 2>&1
		%SystemRoot%\System32\logoff.exe /V >> %LOGFILE% 2>&1

)

ECHO Finished Script (this command will probably never ran if it always logs out the user running it before it gets to this line) >> %LOGFILE% 2>&1
