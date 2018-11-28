@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

REM *** This file is intended to be targeted by shortcut, placed into the 'Startup' folder, which calls:   cmd /c LOGON.bat
REM
REM		Created by Matt Cavallo <mcavallo@boneal.com>
REM
REM		Creation Date: [ 2018-11-28 ]
REM		 Last Updated:	[ 2018-11-28 ]

SET TARGET_HOSTNAME=%COMPUTERNAME%
SET SAGE_PUNCHIN=.\BNL-Time.lnk
SET SAGE_PROCESS_NAME=pvxwin32.exe

SET TARGET_USERNAME=%USERNAME%
SET TARGET_USERDOMAIN=%USERDOMAIN%

REM	 Optionally, target specific domain\username (instead of self)
REM SET TARGET_USERNAME=mcavallo
REM SET TARGET_USERDOMAIN=BONEAL


REM	 Find Session-ID tied to [target-user]
SET USER_SESSION_ID=NOTFOUND
FOR /F "tokens=3-4" %%a IN ('QUERY SESSION %TARGET_USERNAME%') DO (
	@IF "%%b"=="Active" (
		SET USER_SESSION_ID=%%a
	)
)

REM	 Determine if [target-user] is logged-in or not
IF NOT %USER_SESSION_ID%==NOTFOUND (

	ECHO BS-CAVAMAT| clip

	.\BNL-Time.lnk

	SECONDS_TO_CLOSE_SAGE_PUNCHIN_AFTER=180

	TIMEOUT /T %SECONDS_TO_CLOSE_SAGE_PUNCHIN_AFTER% > NUL

	REM	 Safely end any open SAGE sessions which were started by [target-user]
	TASKKILL /FI "USERNAME eq %TARGET_USERDOMAIN%\%TARGET_USERNAME%" /FI "IMAGENAME eq %SAGE_PROCESS_NAME%"

	EXIT

)

REM	 Allow any boot-up processes (for this user's session) to complete before forcing logoff
REM	 	(Handler for login followed by immediate logoff scenario)
REM TIMEOUT /T 30
