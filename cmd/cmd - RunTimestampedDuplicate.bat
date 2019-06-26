@ECHO OFF
SETLOCAL
		
REM
REM ********************************     MAIN FUNCTION     *****************************
REM
	
	CALL :RUN_DUPLICATE_OF_PROGRAM %1 %2 %3 %4
	CALL :LOOP_WHILE_PROGRAM_IS_RUNNING %1 %2 %3 %4
	CALL :DELETE_DUPLICATED_FILE %1 %2 %3 %4
	
	EXIT

REM
REM ********************************     SUBROUTINES     *****************************
REM

	
	REM
	REM     GET_FILE_ATTRIBUTES
	REM 
	: GET_FILE_ATTRIBUTES
		
		SET TARGET_FILE=%1>>%logfile%
		FOR %%i IN ("%TARGET_FILE%") DO (
			SET basefile_drive=%%~di>>%logfile%
			SET basefile_path=%%~pi>>%logfile%
			SET basefile_basename=%%~ni>>%logfile%
			SET basefile_extension=%%~xi>>%logfile%
		)
		
		ECHO param1=%1 >> %logfile%
		ECHO param2=%2 >> %logfile%
		ECHO param3=%3 >> %logfile%
		ECHO param4=%4 >> %logfile%
		ECHO basefile_drive:%basefile_drive% >> %logfile%
		ECHO basefile_path:%basefile_path% >> %logfile%
		ECHO basefile_basename:%basefile_basename% >> %logfile%
		ECHO basefile_extension:%basefile_extension% >> %logfile%
		
		SET basefile_fullpath=%basefile_drive%%basefile_path%%basefile_basename%%basefile_extension%>>%logfile%

		SET tempfile_filename=%basefile_basename%__%timestamp%__%host_name%__%domain_name%%basefile_extension%>>%logfile%
		SET tempfile_directory=%basefile_drive%\temp\>>%logfile%
		IF NOT EXIST "%tempfile_directory%" (mkdir %tempfile_directory%)
		SET tempfile_fullpath=%tempfile_directory%%tempfile_filename%>>%logfile%
		
REM ECHO. >> %logfile%
		
		
		EXIT /B


	REM
	REM     GET_TIMESTAMP
	REM          SET     yyyy_mm_dd = yyyy-mm-dd                  --   2017-06-15
	REM          SET      timestamp = yyyy-mm-dd_hh-mm-ss         --   2017-06-15_10-39-04
	REM          SET  timestamp_spc = yyyy-mm-dd_hh-mm-ss         --   2017-06-15 10:39:04
	: GET_TIMESTAMP
		SET hour=%time:~0,2%
		SET yyyy_mm_dd=%date:~-4%-%date:~4,2%-%date:~7,2%
		SET dt_underscores9=%yyyy_mm_dd%_0%time:~1,1%-%time:~3,2%-%time:~6,2%
		SET dt_underscores24=%yyyy_mm_dd%_%time:~0,2%-%time:~3,2%-%time:~6,2%
		IF "%hour:~0,1%" == " " (set timestamp=%dt_underscores9%) else (set timestamp=%dt_underscores24%)
		SET dt_spaces9=%yyyy_mm_dd% 0%time:~1,1%:%time:~3,2%:%time:~6,2%
		SET dt_spaces24=%yyyy_mm_dd% %time:~0,2%:%time:~3,2%:%time:~6,2%
		IF "%hour:~0,1%" == " " (set timestamp_spaces=%dt_spaces9%) else (set timestamp_spaces=%dt_spaces24%)
		EXIT /B
	
	
	REM
	REM     GET_USER_HOST_DOMAIN_NAMES
	REM 
	: GET_USER_HOST_DOMAIN_NAMES
		REM  \*/*\   Get the domain
		FOR /f "tokens=2 delims==" %%I in ('wmic computersystem get domain /format:list') do set "domain_name=%%I"
		REM  \*/*\   Get the username
		FOR /f "tokens=2 delims==" %%I in ('wmic computersystem get username /format:list') do set "user_name=%%I"
		REM  \*/*\   Get the hostname (computer name)
		FOR /f "tokens=2 delims==" %%I in ('wmic computersystem get name /format:list') do set "host_name=%%I"
		EXIT /B
	
	
	REM
	REM     SETUP_LOG_FILE
	REM												To Use: place [>> %logfile%] at the end of a line of code to append it to this session's logfile
	REM
	: SETUP_LOG_FILE
		REM   Create directory [.\logs\]  (if it doesn't already exist)
		SET logdirectory=%~dp0logs\
		IF NOT EXIST "%logdirectory%" (
			MKDIR "%logdirectory%"
		)
		SET logfile="%logdirectory%logfile___%yyyy_mm_dd%___%host_name%___%domain_name%.txt"
		REM SET logfile="logfile.txt"
		ECHO. >> %logfile%
		ECHO [%yyyy_mm_dd% %time:~0,2%:%time:~3,2%:%time:~6,2%] Beginning Batch Job >> %logfile%
		REM ECHO [%yyyy_mm_dd% %time:~0,2%:%time:~3,2%:%time:~6,2%] Parameters Passed: 0=[%0], 1=[%1], 2=[%2], 3=[%3], 4=[%4]  >> %logfile%
		EXIT /B
		
		
	REM
	REM     RUN_DUPLICATE_OF_PROGRAM
	REM												       Run [Filename] as a copy of itself, renamed to: "FileName_[Timestamp]___[PCName]___[UserName].FileExtension"
	REM
	: RUN_DUPLICATE_OF_PROGRAM
	
REM /*\*/		Instantiate Global Variables && Setup Log-File
		CALL :GET_TIMESTAMP %1 %2 %3 %4
		CALL :GET_USER_HOST_DOMAIN_NAMES %1 %2 %3 %4
		CALL :SETUP_LOG_FILE %1 %2 %3 %4
		CALL :GET_FILE_ATTRIBUTES %1 %2 %3 %4
		
		REM    in-line parameters  for  [TEMP]        (passed at runtime)
		
		IF [%DEBUG_MODE%] == [1] (     REM /*\*/   DEBUG-mode   (use UION and MANUAL)
			ECHO [%yyyy_mm_dd% %time:~0,2%:%time:~3,2%:%time:~6,2%] Running in DEBUG-Mode >> %logfile%
			
			SET tempfile_inline_parameters="">>%logfile%
			
		) ELSE (
			
			SET tempfile_inline_parameters="">>%logfile%
			
		)
		
		REM  \*/*\   Copy [BASE] to [TEMP]   -   If [BASE] doesn't exist, save (in the log) that the file doesn't exist, then exit out
		IF NOT EXIST "%basefile_fullpath%" (
			ECHO [%yyyy_mm_dd% %time:~0,2%:%time:~3,2%:%time:~6,2%] ERROR: File Not Found - [%basefile_fullpath%] >> %logfile%
			ECHO [%yyyy_mm_dd% %time:~0,2%:%time:~3,2%:%time:~6,2%] TERMINATING BATCH JOB  >> %logfile%
			EXIT
		)
		ECHO [%yyyy_mm_dd% %time:~0,2%:%time:~3,2%:%time:~6,2%] SUCCESS: File was Found - [%basefile_fullpath%] >> %logfile%
		ECHO [%yyyy_mm_dd% %time:~0,2%:%time:~3,2%:%time:~6,2%] Attempting to Create Temporary Copy - [%tempfile_fullpath%] >> %logfile%
		COPY /y "%basefile_fullpath%" "%tempfile_fullpath%" >> %logfile%
		
		REM /*\*/   Run [TEMP] with any extra in-line parameters
		ECHO [%yyyy_mm_dd% %time:~0,2%:%time:~3,2%:%time:~6,2%] Running Temporary Copy - [%tempfile_fullpath%] >> %logfile%
		ECHO [%yyyy_mm_dd% %time:~0,2%:%time:~3,2%:%time:~6,2%] 
		ECHO Running [%tempfile_fullpath%] ...
		
		REM /*\*/   Kill any AutoHotkey instances already running
		REM SET image_to_kill=AutoHotkey.exe
		REM TASKKILL /F /FI "IMAGENAME eq %image_to_kill%"
		
		CMD /C ""%tempfile_fullpath%" %tempfile_inline_parameters%"
		
		EXIT /B
		
	REM
	REM     LOOP_WHILE_PROGRAM_IS_RUNNING
	REM												           Keep current Batch-Job running until %tempfile_filename% is no longer running
	REM
	: LOOP_WHILE_PROGRAM_IS_RUNNING
		TIMEOUT -T 2
		SET program_to_wait_for=AutoHotkey.exe
		TASKLIST /FI "IMAGENAME eq %tempfile_filename%" 2>NUL | find /I /N "%tempfile_filename%">NUL
		IF ERRORLEVEL 1 (
			ECHO [%yyyy_mm_dd% %time:~0,2%:%time:~3,2%:%time:~6,2%] Image [%tempfile_fullpath%] is no longer Running >> %logfile%
		) ELSE (
			ECHO [%yyyy_mm_dd% %time:~0,2%:%time:~3,2%:%time:~6,2%] Image [%tempfile_fullpath%] still Running, waiting until it has finished >> %logfile%
			GOTO LOOP_WHILE_PROGRAM_IS_RUNNING
		)
		EXIT /B
		
	REM
	REM     DELETE_DUPLICATED_FILE
	REM												           Attempt to Delete File --> Keep Log of System's Response
	REM
	: DELETE_DUPLICATED_FILE
		REM  \*/*\   Delete [TEMP]
		REM @ECHO ON
		ECHO [%yyyy_mm_dd% %time:~0,2%:%time:~3,2%:%time:~6,2%] Attempting to Delete [%tempfile_fullpath%] >> %logfile%
		DEL "%tempfile_fullpath%"
		IF EXIST "%tempfile_fullpath%" (
			ECHO [%yyyy_mm_dd% %time:~0,2%:%time:~3,2%:%time:~6,2%] ERROR: Unable to Delete [%tempfile_fullpath%] >> %logfile%
		)
		IF NOT EXIST "%tempfile_fullpath%" (
			ECHO [%yyyy_mm_dd% %time:~0,2%:%time:~3,2%:%time:~6,2%] SUCCESS: Deleted [%tempfile_fullpath%] Successfully >> %logfile%
		)
		ECHO [%yyyy_mm_dd% %time:~0,2%:%time:~3,2%:%time:~6,2%] Batch Job Complete >> %logfile%
		EXIT /B
		