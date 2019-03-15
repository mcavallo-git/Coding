@ECHO OFF

CALL :START_SERVICE_IF_STOPPED WinHttpAutoProxySvc

TIMEOUT -T 30
EXIT


: START_SERVICE_IF_STOPPED
	SET service_name=%1
	SET /A service_is_running=0
	FOR /F "tokens=3 delims=: " %%H IN ('sc query "%service_name%" ^| findstr "        STATE"') DO (
		IF /I "%%H" NEQ "RUNNING" (
			REM Service NOT running - Try to start it
			net start %service_name%
			IF ERRORLEVEL 1 (
				REM Service had trouble starting
				ECHO net start %service_name% failed with ERRORLEVEL=%ERRORLEVEL%
			) ELSE (
				SET /A service_is_running=1
			)
		) ELSE (
			REM Service IS running
			SET /A service_is_running=1
		)
	)
	REM Return whether the service is running or not
	IF "%service_is_running%"=="1" (
		ECHO Service [%service_name%] is currently running
	) ELSE (
		ECHO Service [%service_name%] is NOT running, and was unable to be started
	)
	EXIT /B

