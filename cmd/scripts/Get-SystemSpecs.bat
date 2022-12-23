@ECHO OFF
REM ------------------------------------------------------------
REM
REM Hardware Spec 'Getter' using WMIC         MCavallo, 2017-07-06
REM
REM ------------------------------------------------------------
REM RUN THIS SCRIPT (via PowerShell):
REM
REM    (New-Object System.Net.WebClient).DownloadFile("https://raw.githubusercontent.com/mcavallo-git/Coding/main/cmd/scripts/Get-SystemSpecs.bat","${Env:TEMP}\Get-SystemSpecs.bat"); Start-Process -Filepath ("${Env:ComSpec}") -ArgumentList (@("/C","${Env:TEMP}\Get-SystemSpecs.bat"));
REM
REM ------------------------------------------------------------
REM   MAIN FUNCTION
REM ------------------------------------------------------------

  SETLOCAL
  CALL :WELCOME_USER
  CALL :SETUP_FILESTREAM   REM /* DATETIME FILENAME*/
  CALL :WMIC_CPU           REM /* PROCESSOR */
  CALL :WMIC_GRAPHICS      REM /* VIDEO CARD */
  CALL :WMIC_RAM           REM /* MEMORY */
  CALL :WMIC_DISKS         REM /* DISK(S) */
  CALL :WMIC_OS            REM /* OPERATING SYSTEM */
  CALL :WMIC_MANUFACTURER  REM /* PC MODEL/NAME */
  CALL :WMIC_MOTHERBOARD   REM /* MOTHERBOARD/BIOS */
  CALL :WMIC_USER          REM /* LOGIN USERNAME/DOMAIN */
  CALL :WMIC_NIC           REM /* NETWORK INTERFACE CARDS */
  CALL :.

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
  ECHO. >> %output_file%
  ECHO. >> %output_file%
  ECHO ------------------------------------------------------------ >> %output_file%
  EXIT /b

REM ------------------------------------------------------------
REM    SETUP FILESTREAM
REM ------------------------------------------------------------

: SETUP_FILESTREAM
  REM  \*/*\   Get the domain name
  FOR /f "tokens=2 delims==" %%I in ('wmic computersystem get Domain /format:list') do SET "domain=%%I"
  REM  \*/*\   Get the username
  FOR /f "tokens=2 delims==" %%I in ('wmic computersystem get UserName /format:list') do SET "username=%%I"
  REM  \*/*\   Get the hostname (computer name)
  FOR /f "tokens=2 delims==" %%I in ('wmic computersystem get Name /format:list') do SET "hostname=%%I"
  REM SET date=date /T
  SET output_file=%USERPROFILE%\Desktop\Get-SystemSpecs.%hostname%.%domain%.txt
  CALL :SETUP_DATETIME
  ECHO SYSTEM INFO FOR PC [%hostname%] RAN [%dt_spaces%] BY [%username%] > %output_file%
  ECHO. >> %output_file%
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
  CALL :.
  ECHO --- >> %output_file%
  ECHO --- Processor (CPU) Info >> %output_file%
  ECHO --- >> %output_file%
  ECHO. >> %output_file%
  wmic cpu get Name,numberofcores,numberoflogicalprocessors | findstr /r /v "^\s*$" >> %output_file%
  ECHO. >> %output_file%
  wmic cpu get Name,CurrentClockSpeed,MaxClockSpeed | findstr /r /v "^\s*$" >> %output_file%
  EXIT /b

: WMIC_DISKS
  CALL :.
  ECHO --- >> %output_file%
  ECHO --- Disk Info (size in bytes) >> %output_file%
  ECHO --- >> %output_file%
  ECHO. >> %output_file%
  wmic diskdrive get Caption,DeviceID,Index,Partitions,Size | findstr /r /v "^\s*$" >> %output_file%
  EXIT /b

: WMIC_GRAPHICS
  CALL :.
  ECHO --- >> %output_file%
  ECHO --- Graphics/Video Card Info >> %output_file%
  ECHO --- >> %output_file%
  ECHO. >> %output_file%
  wmic path Win32_VideoController get Name,description,adapterram,driverversion | findstr /r /v "^\s*$" >> %output_file%
  EXIT /b

: WMIC_MOTHERBOARD
  CALL :.
  ECHO --- >> %output_file%
  ECHO --- Motherboard Info >> %output_file%
  ECHO --- >> %output_file%
  ECHO. >> %output_file%
  wmic baseboard get manufacturer,product,serialnumber | findstr /r /v "^\s*$" >> %output_file%
  ECHO. >> %output_file%
  ECHO --- >> %output_file%
  ECHO --- BIOS Info >> %output_file%
  ECHO --- >> %output_file%
  ECHO. >> %output_file%
  wmic bios get SMBIOSBIOSVersion,SMBIOSMajorVersion,SMBIOSMinorVersion,ReleaseDate | findstr /r /v "^\s*$" >> %output_file%
  EXIT /b

: WMIC_MANUFACTURER
  CALL :.
  ECHO --- >> %output_file%
  ECHO --- PC Hostname / Model / Manufacturer >> %output_file%
  ECHO --- >> %output_file%
  ECHO. >> %output_file%
  wmic computersystem get model,manufacturer,Name,systemtype | findstr /r /v "^\s*$" >> %output_file%
  EXIT /b

: WMIC_NIC
  CALL :.
  ECHO --- >> %output_file%
  ECHO --- NIC (Network Inferface Card) Info >> %output_file%
  ECHO --- >> %output_file%
  ECHO. >> %output_file%
  wmic nicconfig where "macaddress is not null" get macaddress,ipaddress,index,defaultipgateway,dhcpserver,description | findstr /r /v "^\s*$" >> %output_file%
  EXIT /b

: WMIC_OS
  CALL :.
  ECHO --- >> %output_file%
  ECHO --- OS (Operating System) Info >> %output_file%
  ECHO --- >> %output_file%
  ECHO. >> %output_file%
  wmic os get caption,osarchitecture,version | findstr /r /v "^\s*$" >> %output_file%
  EXIT /b

: WMIC_RAM
  CALL :.
  ECHO --- >> %output_file%
  ECHO --- Memory/RAM Info (Capacity is in Bytes) >> %output_file%
  ECHO --- >> %output_file%
  ECHO. >> %output_file%
  wmic memorychip get BankLabel,Capacity,DeviceLocator,FormFactor,Manufacturer,PartNumber,Speed | findstr /r /v "^\s*$" >> %output_file%
  ECHO. >> %output_file%
  ECHO --- >> %output_file%
  ECHO --- Motherboard RAM Limits (MaxCapacity is max compatible RAM in Kilobytes, MemoryDevices is total RAM Slots) >> %output_file%
  ECHO --- >> %output_file%
  ECHO. >> %output_file%
  wmic memphysical get memorydevices,maxcapacity | findstr /r /v "^\s*$" >> %output_file%
  EXIT /b

: WMIC_USER
  CALL :.
  ECHO --- >> %output_file%
  ECHO --- User / Domain Info >> %output_file%
  ECHO --- >> %output_file%
  ECHO. >> %output_file%
  wmic computersystem get domain,UserName,partofdomain,primaryownername | findstr /r /v "^\s*$" >> %output_file%
  EXIT /b
