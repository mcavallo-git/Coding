@SETLOCAL enableextensions enabledelayedexpansion
@ECHO OFF
	
REM		This program is designed to run via scheduled task every [x time period] to ping a host IP or URL.

CALL :PingTest www.google.com Google_NTP_Hostname
CALL :PingTest 216.239.35.0 Google_NTP_IPv4

CALL :PingTest 8.8.8.8 Google_DNS_IPv4

CALL :PingTest 8.8.8.2 Forced_Failure
	
EXIT
	
REM
REM	PingTest
REM		%1  (parameter 01)  :::  Hostname or IPv4 to Ping
REM		%2  (parameter 02)  :::  Nickname of Host, used for logging
REM 
: PingTest
	SET PingHostname=%1
	SET PingNickname=%2
	SET PingResponse=offline
	FOR /f "tokens=5,6,7" %%a in ('Ping -n 1 !PingHostname!') DO (
		IF "x%%a"=="xReceived" IF "x%%c"=="x1," SET PingResponse=online
	)
	IF "!PingResponse!"=="offline" (
		REM	Log on failed pings
		ECHO [%date:~-4%-%date:~4,2%-%date:~7,2% @ %time:~0,2%:%time:~3,2%:%time:~6,2%] FAILED PING to %PingNickname% at {%PingHostname%} >> "%~dp0PingTest_Log.txt"
	) ELSE (
		REM	Log on successful pings
		REM ECHO [%date:~-4%-%date:~4,2%-%date:~7,2% @ %time:~0,2%:%time:~3,2%:%time:~6,2%] SUCCESSFUL PING to %PingNickname% at {%PingHostname%} >> "%~dp0PingTest_Log.txt"
	)
	EXIT /B
