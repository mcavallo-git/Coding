@SETLOCAL enableextensions enabledelayedexpansion
@ECHO off
	
	REM     This program is designed to run via scheduled task (every minute) to ping a host IP or URL.
	REM     Logging only occurs on failed pings.
	
	CALL :PING_TEST time.nist.gov NIST_Time
	CALL :PING_TEST time.google.com Google_Time
	CALL :PING_TEST 8.8.8.8 Google_DNS
	REM CALL :PING_TEST 8.8.8.2 Forced_Failure
	
	EXIT
	
REM
REM     PING_TEST
REM         %1 = Host IP / URL to ping
REM         %2 = Host Nickname (for logging)
REM 
: PING_TEST
	SET ping_hostname=%1
	SET ping_nickname=%2
	SET ping_response=offline
	FOR /f "tokens=5,6,7" %%a in ('PING -n 1 !ping_hostname!') DO (
		IF "x%%a"=="xReceived" IF "x%%c"=="x1," SET ping_response=online
	)
	IF "!ping_response!"=="offline" (
		ECHO [%date:~-4%-%date:~4,2%-%date:~7,2% @ %time:~0,2%:%time:~3,2%:%time:~6,2%] FAILED PING to %ping_nickname% at {%ping_hostname%} >> "%~dp0ping_test.log"
	)
	EXIT /B
