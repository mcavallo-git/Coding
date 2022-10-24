@ECHO OFF
REM ------------------------------------------------------------
REM
REM Hardware Spec 'Getter' using WMIC         MCavallo, 2017-07-06
REM
REM ------------------------------------------------------------
REM RUN THIS SCRIPT (via PowerShell):
REM 
REM    (New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/mcavallo-git/Coding/main/cmd/cmd%20-%20Get-SystemSpecs.bat","${Env:TEMP}\Get-SystemSpecs.bat"); Start-Process -Filepath ("${Env:ComSpec}") -ArgumentList (@("/C","${Env:TEMP}\Get-SystemSpecs.bat"));
REM
REM ------------------------------------------------------------
REM   MAIN FUNCTION  
REM ------------------------------------------------------------
 
	SETLOCAL
	CALL :WELCOME_USER
	CALL :SETUP_FILESTREAM   REM /* DATETIME FILENAME*/
	CALL :.
	CALL :WMIC_OS 	 REM /* OPERATING SYSTEM */
	CALL :WMIC_MODEL  REM /* PC MODEL/NAME */
	CALL :.
	CALL :WMIC_LOGIN   REM /* LOGIN USERNAME/DOMAIN */
	CALL :WMIC_MOTHERBOARD     REM /* MOTHERBOARD */
	CALL :.
	CALL :WMIC_RAM       REM /* MEMORY */
	CALL :WMIC_CPU        REM /* PROCESSOR(S) */
	CALL :.
	CALL :WMIC_DISKS       REM /* DRIVE INFO */
	CALL :WMIC_GRAPHICS     REM /* GRAPHICS INFO */
	CALL :WMIC_NIC           REM /* NETWORK INFO */
	
	START notepad.exe %output_file%

	REM TIMEOUT /T 5
	
	EXIT

REM ------------------------------------------------------------
REM   NO UI AWARDS HERE   
REM ------------------------------------------------------------

: WELCOME_USER
	ECHO.	
	ECHO | SET /P=Acquiring data .
	EXIT /b
	
: .
	ECHO | SET /P=^.
	EXIT /b
	
REM ------------------------------------------------------------
REM    SETUP FILESTREAM   
REM ------------------------------------------------------------

: SETUP_FILESTREAM
	REM  \*/*\   Get the domain name
	FOR /f "tokens=2 delims==" %%I in ('wmic computersystem get domain /format:list') do SET "domain=%%I"
	REM  \*/*\   Get the username
	FOR /f "tokens=2 delims==" %%I in ('wmic computersystem get username /format:list') do SET "username=%%I"
	REM  \*/*\   Get the hostname (computer name)
	FOR /f "tokens=2 delims==" %%I in ('wmic computersystem get name /format:list') do SET "hostname=%%I"
	REM SET date=date /T
	SET output_file=%USERPROFILE%\Desktop\Get-SystemSpecs.%hostname%.%domain%.txt
	CALL :SETUP_DATETIME
	ECHO SYSTEM INFO FOR PC [%hostname%] RAN [%dt_spaces%] BY [%username%] > %output_file%
	EXIT /b

: SETUP_DATETIME
	SET hour=%time:~0,2%
	REM  \*/*\   Datetime with underscores (no spaces, for filenames etc.)
	SET dt_underscores_1d_hour=%date:~0,4%-%date:~5,2%-%date:~8,2%_0%time:~1,1%-%time:~3,2%-%time:~6,2% 
	SET dt_underscores_2d_hour=%date:~0,4%-%date:~5,2%-%date:~8,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%
	if "%hour:~0,1%" == " " (SET dt_underscores=%dt_underscores_1d_hour%) else (SET dt_underscores=%dt_underscores_2d_hour%)
	REM  \*/*\   Datetime with spaces, for cleaner viewing
	SET dt_spaces_1d_hour=%date:~0,4%-%date:~5,2%-%date:~8,2% 0%time:~1,1%:%time:~3,2%:%time:~6,2% 
	SET dt_spaces_2d_hour=%date:~0,4%-%date:~5,2%-%date:~8,2% %time:~0,2%:%time:~3,2%:%time:~6,2%
	if "%hour:~0,1%" == " " (SET dt_spaces=%dt_spaces_1d_hour%) else (SET dt_spaces=%dt_spaces_2d_hour%)
	EXIT /b
	
REM ------------------------------------------------------------
REM   WMIC ROUTINES
REM ------------------------------------------------------------
	
: WMIC_CPU
	ECHO. >> %output_file%
	ECHO. >> %output_file%
	ECHO              -- PROCESSOR CORE INFO -- >> %output_file%
	wmic cpu get name,numberofcores,numberoflogicalprocessors | findstr /r /v "^$" >> %output_file%
	ECHO. >> %output_file%
	ECHO              -- PROCESSOR CACHE, CLOCK INFO -- >> %output_file%
	wmic cpu get name,l2cachesize,l3cachesize,currentclockspeed,maxclockspeed | findstr /r /v "^$" >> %output_file%
	EXIT /b	

: WMIC_DISKS
	ECHO. >> %output_file%
	ECHO. >> %output_file%
	ECHO              -- STORAGE DEVICES/DISKS (SIZE IN BYTES) -- >> %output_file%
	wmic diskdrive get Caption,DeviceID,Index,Partitions,Size | findstr /r /v "^$" >> %output_file%
	EXIT /b	
	
: WMIC_GRAPHICS
	ECHO. >> %output_file%
	ECHO. >> %output_file%
	ECHO              -- GRAPHICS INFO -- >> %output_file%
	wmic path Win32_VideoController get name,description,adapterram,driverversion | findstr /r /v "^$" >> %output_file%
	EXIT /b

: WMIC_LOGIN
	ECHO. >> %output_file%
	ECHO. >> %output_file%
	ECHO              -- USERNAME / DOMAIN -- >> %output_file%
	wmic computersystem get domain,username,partofdomain,primaryownername | findstr /r /v "^$" >> %output_file%
	EXIT /b	
	
: WMIC_MOTHERBOARD
	ECHO. >> %output_file%
	ECHO. >> %output_file%
	ECHO              -- MOTHERBOARD GENERAL INFO -- >> %output_file%
	wmic baseboard get manufacturer,product,serialnumber | findstr /r /v "^$" >> %output_file%
	ECHO. >> %output_file%
	ECHO              -- MOTHERBOARD RAM LIMITS (MAXCAPACITY IN KILOBYTES) -- >> %output_file%
	wmic memphysical get memorydevices,maxcapacity | findstr /r /v "^$" >> %output_file%
	EXIT /b	
	
: WMIC_MODEL
	ECHO. >> %output_file%
	ECHO. >> %output_file%
	ECHO              -- PC NAME / MODEL -- >> %output_file%
	wmic computersystem get model,manufacturer,name,systemtype | findstr /r /v "^$" >> %output_file%
	EXIT /b	

: WMIC_NIC 
	ECHO. >> %output_file%
	ECHO. >> %output_file%
	ECHO              -- NIC INFO -- >> %output_file%
	wmic nicconfig where "macaddress is not null" get macaddress,ipaddress,index,defaultipgateway,dhcpserver,description | findstr /r /v "^$" >> %output_file%
	EXIT /b	
	
: WMIC_OS
	ECHO. >> %output_file%
	ECHO. >> %output_file%
	ECHO              -- OPERATING SYSTEM -- >> %output_file%
	wmic os get caption,osarchitecture,version | findstr /r /v "^$" >> %output_file%
	EXIT /b
		
: WMIC_RAM
	ECHO. >> %output_file%
	ECHO. >> %output_file%
	ECHO              -- RAM MODULES (CAPACITY IN BYTES) -- >> %output_file%
	wmic memorychip get BankLabel,Capacity,DeviceLocator,FormFactor,Manufacturer,PartNumber,Speed | findstr /r /v "^$" >> %output_file%

	EXIT /b
