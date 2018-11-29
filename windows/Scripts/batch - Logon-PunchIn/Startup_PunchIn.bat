@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

REM		Created by Matt Cavallo <mcavallo@boneal.com>
REM		Creation Date: [ 2018-11-28 ]
REM		 Last Updated:	[ 2018-11-28 ]

SET TARGET_HOSTNAME=%COMPUTERNAME%
SET BGINFO_UPDATER=C:\ISO\UpdateBGInfo.lnk
SET SAGE_PUNCHIN_BNL=C:\ISO\BNL-Time.lnk
SET SAGE_PROCESS_NAME=pvxwin32.exe

SET TARGET_USERNAME=%USERNAME%
SET TARGET_USERDOMAIN=%USERDOMAIN%

SET SECONDS_TO_CLOSE_SAGE_PUNCHIN_AFTER=180

REM	 Optionally, target specific domain\username (instead of self)
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
IF NOT "%USER_SESSION_ID%"=="NOTFOUND" (

	IF NOT "%1"=="" (
		ECHO %1| clip
	)
	
	IF EXIST %BGINFO_UPDATER% (
		START %BGINFO_UPDATER%
	)

	IF EXIST %SAGE_PUNCHIN_BNL% (
	
		START %SAGE_PUNCHIN_BNL%
	
		TIMEOUT /T %SECONDS_TO_CLOSE_SAGE_PUNCHIN_AFTER% > NUL
	
		REM	 Safely end SAGE sessions which were started by [target-user]
		TASKKILL /FI "USERNAME eq %TARGET_USERDOMAIN%\%TARGET_USERNAME%" /FI "IMAGENAME eq %SAGE_PROCESS_NAME%"
	
	)

)

REM	 Allow any boot-up processes (for this user's session) to complete before forcing logoff
REM	 	(Handler for login followed by immediate logoff scenario)
TIMEOUT /T 30

EXIT
