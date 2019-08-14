@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

REM
REM	 logoff_killprocs
REM			|
REM			|-->  Notepad.exe "%LOCALAPPDATA%\Microsoft\WindowsApps\logoff_killprocs.bat"
REM



REM
REM	Defined the filepath to this runtime's logfile
REM
SET LOGFILE=%TEMP%\logoff.log


REM
REM Get the Start Date & Time
REM
FOR /F "tokens=* USEBACKQ" %%F IN (`DATE /T`) DO SET START_DATETIME=%START_DATETIME%%%F
FOR /F "tokens=* USEBACKQ" %%F IN (`TIME /T`) DO SET START_DATETIME=%START_DATETIME%%%F
ECHO RUNTIME STARTING AT %START_DATETIME% >> %LOGFILE% 2>&1


REM
REM	TIMEOUT_SECONDS_TO_BOMBOUT_AFTER
REM		|--> Inline-Parameter #1 --> Seconds to wait before ending the user's session, programs, etc.
REM
SET TIMEOUT_SECONDS_TO_BOMBOUT_AFTER=
IF "%1"=="" (
	SET TIMEOUT_SECONDS_TO_BOMBOUT_AFTER=30
) ELSE (
	SET TIMEOUT_SECONDS_TO_BOMBOUT_AFTER=%1
)


REM
REM	Get the current User's Session-ID
REM
FOR /F "tokens=3-4" %%a IN ('QUERY SESSION %USERNAME%') DO (
	@IF "%%b"=="Active" (
		ECHO Calling [ SET USER_SESSION_ID=%%a ]... >> %LOGFILE% 2>&1
			SET USER_SESSION_ID=%%a
	)
)


REM
REM Get the End Date & Time
REM
FOR /F "tokens=* USEBACKQ" %%F IN (`DATE /T`) DO SET END_DATETIME=%END_DATETIME%%%F
FOR /F "tokens=* USEBACKQ" %%F IN (`TIME /T`) DO SET END_DATETIME=%END_DATETIME%%%F


REM
REM Avoid the classic Windows popup 'This App is Preventing Shutdown', etc. by disabling it via a 'Registry tweak'
REM
SET RegKey=HKCU\Control Panel\Desktop
SET RegName=AutoEndTasks
SET RegType=REG_SZ
SET RegData=1
FOR /F "tokens=* USEBACKQ" %%a IN (
`REG QUERY "%RegKey%" /v "AutoEndTasks" /t "%RegType%" /f "%RegData%"`
) DO ( 
	SET QUERY_KEY_VAL=%%a
)
SET ARE_REGEDITS_NEEDED=%QUERY_KEY_VAL:End of search: 1 match(es) found.=NO_REGEDITS_ARE_NEEDED%
IF NOT "%ARE_REGEDITS_NEEDED%"=="NO_REGEDITS_ARE_NEEDED" (
	ECHO Registry-key "%RegKey%" is already up-to-date contains value with name="%RegName%", type="%RegType%", and data="%RegData%"
) ELSE (
	ECHO Adding a value with name="%RegName%", type="%RegType%", and data="%RegData%" to registry-key "%RegKey%"
	REG ADD "%RegKey%" /v "%RegName%" /t "%RegType%" /d "%RegData%" /f
)

REM
REM Wait the alotted number of seconds before bombing-out (e.g. before logging-out)
REM
TIMEOUT /T %TIMEOUT_SECONDS_TO_BOMBOUT_AFTER%


REM
REM Logoff user (and auto-kill all their running processes thanks to the 'AutoEndTasks' Registry Tweak)
REM
IF "%USER_SESSION_ID%"=="" (
	REM Nix the Runtime User's Session
	ECHO %SystemRoot%\System32\logoff.exe /V >> %LOGFILE% 2>&1
	ECHO RUNTIME FINISHED AT %END_DATETIME% >> %LOGFILE% 2>&1
	%SystemRoot%\System32\logoff.exe /V >> %LOGFILE% 2>&1
) ELSE (
	REM	Nix one, specific Session-ID's Session
	ECHO %END_DATETIME%    %SystemRoot%\System32\logoff.exe %USER_SESSION_ID% /V >> %LOGFILE% 2>&1
	ECHO RUNTIME FINISHED AT %END_DATETIME% >> %LOGFILE% 2>&1
	%SystemRoot%\System32\logoff.exe %USER_SESSION_ID% /V >> %LOGFILE% 2>&1
)


REM
REM		Changelog  |  2019-08-14  |  Removed targeted username, domain, and session-id (defaulted all current-user)
REM		Changelog  |  2019-08-14  |  Removed IMAGENAME_TO_KILL
REM		Changelog  |  2019-08-14  |  Ensure that user logs-off 100% of the time by defining 'AutoEndTasks' in the Registry
REM		Changelog  |  2019-08-02  |  Added TIMESTAMP to output
REM		Changelog  |  2019-08-02  |  Added runtime-output logging to a persistent logfile
REM		Changelog  |  2019-08-02  |  Replaced 'SHUTDOWN /L /F' with 'logoff.exe' implementation
REM		Changelog  |  2018-12-12  |  Generalized IMAGENAME_TO_KILL as parameter #1
REM		Changelog  |  2018-11-28  |  Added target Domain\User implementation
REM		Changelog  |  2016-09-29  |  Created script
REM


REM	------------------------------------------------------------
REM
REM	Citation(s)
REM
REM		support.microsoft.com  |  "How To Automatically close non-responsive programs"  |  https://support.microsoft.com/en-us/help/555619
REM
REM	------------------------------------------------------------