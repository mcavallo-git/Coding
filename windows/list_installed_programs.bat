@ECHO OFF
REM /* Matt Cavallo --- 07/06/2016 */
REM /* System Spec Getter using WMIC */

REM *****************
REM   MAIN FUNCTION  
REM *****************
 
	SETLOCAL
	CALL :WELCOME_USER
	CALL :SETUP_FILESTREAM   REM /* DATETIME FILENAME*/
	CALL :.
	REM CALL :WMIC_PROGRAMS 	 REM /* PROGRAMS INSTALLED */
	CALL :WMIC_PROGRAMS 	 REM /* PROGRAMS INSTALLED */
	START notepad.exe %output_file%
	
	EXIT

REM **********************
REM   NO UI AWARDS HERE   
REM **********************

: WELCOME_USER
	ECHO.	
	ECHO | SET /P=Acquiring data .
	EXIT /b
	
: .
	ECHO | SET /P=^.
	EXIT /b
	
REM **********************
REM    SETUP FILESTREAM   
REM **********************

: SETUP_FILESTREAM
	REM  \*/*\   Get the domain name
	FOR /f "tokens=2 delims==" %%I in ('wmic computersystem get domain /format:list') do set "domain=%%I"
	REM  \*/*\   Get the username
	FOR /f "tokens=2 delims==" %%I in ('wmic computersystem get username /format:list') do set "username=%%I"
	REM  \*/*\   Get the hostname (computer name)
	FOR /f "tokens=2 delims==" %%I in ('wmic computersystem get name /format:list') do set "hostname=%%I"
	REM set date=date /T
	set output_file=.\ProgramsInstalledWMIC___%hostname%___%domain%.txt
	CALL :SETUP_DATETIME
	echo PROGRAMS INSTALLED (CONTROL PANEL) FOR PC [%hostname%] RAN [%dt_spaces%] BY [%username%] > %output_file%
	EXIT /b

: SETUP_DATETIME
	set hour=%time:~0,2%
	REM  \*/*\   Datetime with underscores (no spaces, for filenames etc.)
	set dt_underscores9=%date:~-4%-%date:~4,2%-%date:~7,2%_0%time:~1,1%-%time:~3,2%-%time:~6,2% 
	set dt_underscores24=%date:~-4%-%date:~4,2%-%date:~7,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%
	if "%hour:~0,1%" == " " (set dt_underscores=%dt_underscores9%) else (set dt_underscores=%dt_underscores24%)
	REM  \*/*\   Datetime with spaces, for cleaner viewing
	set dt_spaces9=%date:~-4%-%date:~4,2%-%date:~7,2% 0%time:~1,1%:%time:~3,2%:%time:~6,2% 
	set dt_spaces24=%date:~-4%-%date:~4,2%-%date:~7,2% %time:~0,2%:%time:~3,2%:%time:~6,2%
	if "%hour:~0,1%" == " " (set dt_spaces=%dt_spaces9%) else (set dt_spaces=%dt_spaces24%)
	EXIT /b
	
REM *****************
REM   WMIC ROUTINES
REM *****************

: WMIC_PROGRAMS
	echo. >> %output_file%
	echo. >> %output_file%
	echo              -- PROGRAMS INSTALLED -- >> %output_file%
	wmic product get name,version,vendor | findstr /r /v "^$" >> %output_file%
	EXIT /b
	
	
	
: WMIC_PROGRAMS2
	echo. >> %output_file%
	echo. >> %output_file%
	echo              -- PROGRAMS INSTALLED -- >> %output_file%
	wmic product get name,version,vendor | findstr /r /v "^$" >> %output_file%

	FOR /f "delims==" %%i IN ('set $ 2^>nul') DO SET "%%i="
	SET /A COUNT=0
	FOR /f "delims=" %%i IN ('wmic product get name^, version^, vendor ') DO (
	 IF DEFINED $0 (
		SET wss=%%i
		CALL %%lopcmd%%
		CALL SET wss2=%%wss2: =%%
		SET /A COUNT+=1
		CALL SET wss=$%%wss2:~-20%%%%COUNT%%
		CALL SET %%wss%%=%%i
	 ) ELSE (SET $0=%%i&set/a wsscol=0&CALL :findcol&SET $0=%%i)
	)
	FOR /f "tokens=1*delims==" %%i IN ('set $') DO ECHO(%%j
	GOTO :eof

	:findcol
	IF "%$0:~0,1%"=="W" SET lopcmd=CALL SET wss2=0000000000000000000%%wss:~%wsscol%%%&GOTO :eof
	SET $0=%$0:~1%
	SET /a wsscol+=1
	GOTO findcol
	timeout -t 50
	EXIT /b
	
	
	
	

	