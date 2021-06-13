@ECHO OFF

REM SETLOCAL EnableDelayedExpansion

REM ------------------------------------------------------------
REM 
REM 
REM    "%USERPROFILE%\Documents\GitHub\Coding\prtg\Custom Sensors\EXEXML\get_cpu_mobo_temperatures.bat"
REM 
REM 
REM ------------------------------------------------------------
REM
REM 
REM  ! ! !   Pre-Req - Open Hardware Monitor  -->  https://openhardwaremonitor.org/downloads/
REM
REM
REM  ! ! !   Pre-Req - Perl  -->  https://www.perl.org/get.html

PowerShell -Command "Set-ExecutionPolicy ByPass -Scope CurrentUser -Force; If (-Not (Get-Command 'perl' -ErrorAction SilentlyContinue)) { [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; If (-Not (Get-Command 'choco' -ErrorAction SilentlyContinue)) { Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) -ErrorAction SilentlyContinue; }; Start-Process -Filepath ('choco') -ArgumentList (@('feature','enable','-n=allowGlobalConfirmation')) -NoNewWindow -Wait -PassThru -ErrorAction SilentlyContinue | Out-Null; Start-Process -Filepath ('choco') -ArgumentList (@('install','strawberryperl')) -NoNewWindow -Wait -PassThru -ErrorAction SilentlyContinue | Out-Null; };" >nul 2>&1

CALL :SETUP_LOGGING

CALL :START_OPEN_HARDWARE_MONITOR

CALL :PING_CHECK %1

CALL :GET_TEMPS_FROM_OPEN_HARDWARE_MONITOR %1 %2 %3

CALL :OUTPUT_RESULTS %1 %2 %3

EXIT /B


REM ------------------------------------------------------------
REM
REM     SETUP_LOGGING
REM
:SETUP_LOGGING

	REM Create temp-directory (if it doesn't already exist) - Note (from "MKDIR /?"): "MKDIR creates any intermediate directories in the path, if needed"
	SET "tempdrive=C:\temp\get_cpu_mobo_temperatures\"
	IF NOT EXIST "%tempdrive%" ( MKDIR "%tempdrive%" )

	EXIT /B


REM ------------------------------------------------------------
REM
REM     START_OPEN_HARDWARE_MONITOR
REM
:START_OPEN_HARDWARE_MONITOR

	REM Start OpenHardwareMonitor as admin and wait long enough for the service to get on its feet (if its not already running)
	SET EXE_OHW=OpenHardwareMonitor.exe
	SET PID_OHW=No
	FOR /F "tokens=2-2" %%a IN ('TASKLIST /FI "IMAGENAME eq %EXE_OHW%"') DO (
		SET PID_OHW=%%a
	)
	IF %PID_OHW%==No (
		PowerShell -Command "Start-Process -Filepath ('C:\ISO\OpenHardwareMonitor\OpenHardwareMonitor.exe') -Verb 'RunAs' -PassThru; Start-Sleep -Seconds 5;"
	)

	EXIT /B


REM ------------------------------------------------------------
REM
REM     PING_CHECK
REM
:PING_CHECK

	REM Check to see if target host is online
	REM  > If host IS online, continue with the script as-intended
	REM  > If host is NOT online, throw a warning & exit the script

	SET "tempdrive=C:\temp\get_cpu_mobo_temperatures\"
	SET "tempfilename=%tempdrive%PING_CHECK_%1.tmp"

	PING -n 1 %1 > %tempfilename%

	FOR /F "tokens=*" %%A IN ('FINDSTR /I /C:"unreachable" %tempfilename%') DO (
		ECHO ^<Error^>1^</Error^>
		ECHO ^<Text^>^[%~n0^] %%A^</Text^>
		ECHO ^</prtg^>
		EXIT 5
	)

	FOR /F "tokens=*" %%A IN ('FINDSTR /I /C:"could not find" %tempfilename%') DO (
		ECHO ^<Error^>1^</Error^>
		ECHO ^<Text^>^[%~n0^] %%A^</Text^>
		ECHO ^</prtg^>
		EXIT 5
	)

	FOR /F "tokens=*" %%A IN ('FINDSTR /I /C:"timed out" %tempfilename%') DO (
		ECHO ^<Error^>1^</Error^>
		ECHO ^<Text^>^[%~n0^] %1: %%A^</Text^>
		ECHO ^</prtg^>
		EXIT 5
	)

	FOR /F "tokens=*" %%A IN ('FINDSTR /I /C:"expired" %tempfilename%') DO (
		ECHO ^<Error^>1^</Error^>
		ECHO ^<Text^>^[%~n0^] %%A^</Text^>
		ECHO ^</prtg^>
		EXIT 5
	)

	FOR /F "tokens=*" %%A IN ('FINDSTR /I /C:"failed" %tempfilename%') DO (
		ECHO ^<Error^>1^</Error^>
		ECHO ^<Text^>^[%~n0^] %%A^</Text^>
		ECHO ^</prtg^>
		EXIT 5
	)

	EXIT /B


REM ------------------------------------------------------------
REM
REM     GET_TEMPS_FROM_OPEN_HARDWARE_MONITOR
REM
:GET_TEMPS_FROM_OPEN_HARDWARE_MONITOR

	SETLOCAL EnableDelayedExpansion

	SET "tempdrive=C:\temp\get_cpu_mobo_temperatures\"
	SET "tempfilename=%tempdrive%GET_TEMPS_FROM_OPEN_HARDWARE_MONITOR_%1.tmp"

	REM IF [%1]==[] ( SET "remoteaccess=" ) ELSE ( SET "remoteaccess=/NODE:%1 /USER:%2 /PASSWORD:%3" )
	REM ECHO "CALLING [ WMIC %remoteaccess% /namespace:\\Root\OpenHardwareMonitor Path Sensor  Get Value,Identifier |MORE > %tempfilename% ] ..."
	REM WMIC %remoteaccess% /namespace:\\Root\OpenHardwareMonitor Path Sensor  Get Value,Identifier |MORE > %tempfilename%


	REM Because WMIC outputs UNICODE we need to use MORE to 'convert' it to UTF-8 (to avoid all characters having a space inbetween)
	IF [%1]==[] (
		REM No node-name/username/password
		ECHO "CALLING [ WMIC /namespace:\\Root\OpenHardwareMonitor Path Sensor  Get Value,Identifier |MORE > %tempfilename% ] ..."
		WMIC /namespace:\\Root\OpenHardwareMonitor Path Sensor  Get Value,Identifier |MORE > %tempfilename%
	) ELSE (
		REM Try using node-name/username/password
		ECHO "CALLING [ WMIC /NODE:%1 /USER:%2 /PASSWORD:%3 /namespace:\\Root\OpenHardwareMonitor Path Sensor  Get Value,Identifier |MORE > %tempfilename% ] ..."
		WMIC /NODE:%1 /USER:%2 /PASSWORD:%3 /namespace:\\Root\OpenHardwareMonitor Path Sensor  Get Value,Identifier |MORE > %tempfilename%
	)
	REM PowerShell -Command "Start-Process -Filepath ('C:\Windows\System32\Wbem\WMIC.exe') -ArgumentList (@('%remoteaccess% /namespace:\\Root\OpenHardwareMonitor','Path Sensor','Get Value,Identifier')) -Verb 'RunAs' -PassThru | More | Out-File '%tempfilename%';"

	REM 
	REM  WMIC - Formatting WMIC queries to handle Open Hardware Monitor requests for "Your" hardware
	REM   >  Run "Open Hardware Monitor" -->  click "File" (top-left) then "Save Report...".
	REM    >  Inspect the exported report - notice that most lines in the report should have a description at the start of each line (just like OpenHardware's Table), followed by Avg/Min/Max Values, with the path to the sensor in parenthesis just after
	REM 

	REM Fan RPM
	REM    FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6776f/fan/0" %tempfilename%`) DO ( CALL :SET_VARIABLE fan1 %%B )  ### REFERENCE ONLY
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6798d/fan/0" %tempfilename%`) DO ( CALL :SET_VARIABLE mobo_fan1 %%B )
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6798d/fan/1" %tempfilename%`) DO ( CALL :SET_VARIABLE mobo_fan2 %%B )
	REM FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6798d/fan/2" %tempfilename%`) DO ( CALL :SET_VARIABLE mobo_fan3 %%B )
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6798d/fan/3" %tempfilename%`) DO ( CALL :SET_VARIABLE mobo_fan3 %%B )
	REM FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6798d/fan/4" %tempfilename%`) DO ( CALL :SET_VARIABLE mobo_fan4 %%B )
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6798d/fan/5" %tempfilename%`) DO ( CALL :SET_VARIABLE mobo_fan5 %%B )
	REM FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6798d/fan/6" %tempfilename%`) DO ( CALL :SET_VARIABLE mobo_fan6 %%B )
	REM FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6798d/fan/7" %tempfilename%`) DO ( CALL :SET_VARIABLE mobo_fan7 %%B )
	REM FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6798d/fan/8" %tempfilename%`) DO ( CALL :SET_VARIABLE mobo_fan8 %%B )


	REM AMD CPU temperatures
	REM    FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/intelcpu/0/temperature/0" %tempfilename%`) DO ( CALL :SET_VARIABLE cputemp0 %%B )  ### REFERENCE ONLY
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/amdcpu/0/temperature/0" %tempfilename%`) DO ( CALL :SET_VARIABLE cputemp0 %%B )
	REM FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/amdcpu/0/temperature/1" %tempfilename%`) DO ( CALL :SET_VARIABLE cputemp1 %%B )
	REM FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/amdcpu/0/temperature/2" %tempfilename%`) DO ( CALL :SET_VARIABLE cputemp2 %%B )
	REM FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/amdcpu/0/temperature/3" %tempfilename%`) DO ( CALL :SET_VARIABLE cputemp3 %%B )
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/amdcpu/0/temperature/4" %tempfilename%`) DO ( CALL :SET_VARIABLE cputemp4 %%B )
	REM FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/amdcpu/0/temperature/5" %tempfilename%`) DO ( CALL :SET_VARIABLE cputemp4 %%B )
	REM FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/amdcpu/0/temperature/6" %tempfilename%`) DO ( CALL :SET_VARIABLE cputemp4 %%B )

	REM Motherboard temperatures
	REM FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6776f/temperature/0" %tempfilename%`) DO ( CALL :SET_VARIABLE motherboard1 %%B )
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6798d/temperature/1" %tempfilename%`) DO ( CALL :SET_VARIABLE motherboard1 %%B )
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6798d/temperature/2" %tempfilename%`) DO ( CALL :SET_VARIABLE motherboard2 %%B )
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6798d/temperature/3" %tempfilename%`) DO ( CALL :SET_VARIABLE motherboard3 %%B )
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6798d/temperature/4" %tempfilename%`) DO ( CALL :SET_VARIABLE motherboard4 %%B )
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6798d/temperature/5" %tempfilename%`) DO ( CALL :SET_VARIABLE motherboard5 %%B )
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6798d/temperature/6" %tempfilename%`) DO ( CALL :SET_VARIABLE motherboard6 %%B )
	

	EXIT /B


REM ------------------------------------------------------------
REM
REM     SET_VARIABLE
REM
:SET_VARIABLE

	SET "%1=%2"

	EXIT /B


REM ------------------------------------------------------------
REM
REM     OUTPUT_RESULTS
REM
:OUTPUT_RESULTS

	SET "tempdrive=C:\temp\get_cpu_mobo_temperatures\"
	SET "tempfilename=%tempdrive%OUTPUT_RESULTS_%1.tmp"

	SET "calc_dot_bat=%tempdrive%calc.bat"

	REM Create subroutine batch-file "calc.bat"
	ECHO IF /I "%%1" EQU "float"  perl -w -e "print eval(join('',@ARGV)); print \"\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9\" " > %calc_dot_bat%
	ECHO IF /I "%%1" EQU "Round0" perl -W -e "print sprintf('%%%%.0f ',eval(join('',@ARGV))); print \"\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9\"" >> %calc_dot_bat%
	ECHO IF /I "%%1" EQU "Round1" perl -W -e "print sprintf('%%%%.1f ',eval(join('',@ARGV))); print \"\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9\"" >> %calc_dot_bat%
	ECHO IF /I "%%1" EQU "Round2" perl -W -e "print sprintf('%%%%.2f ',eval(join('',@ARGV))); print \"\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9\"" >> %calc_dot_bat%
	ECHO IF /I "%%1" EQU "Round3" perl -W -e "print sprintf('%%%%.3f ',eval(join('',@ARGV))); print \"\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9\"" >> %calc_dot_bat%
	ECHO IF /I "%%1" EQU "Round4" perl -W -e "print sprintf('%%%%.4f ',eval(join('',@ARGV))); print \"\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9\"" >> %calc_dot_bat%
	ECHO IF /I "%%1" EQU "Round5" perl -W -e "print sprintf('%%%%.5f ',eval(join('',@ARGV))); print \"\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9\"" >> %calc_dot_bat%
	ECHO IF /I "%%1" EQU "Round6" perl -W -e "print sprintf('%%%%.6f ',eval(join('',@ARGV))); print \"\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9\"" >> %calc_dot_bat%
	ECHO IF /I "%%1" EQU "Round7" perl -W -e "print sprintf('%%%%.7f ',eval(join('',@ARGV))); print \"\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9\"" >> %calc_dot_bat%
	ECHO IF /I "%%1" EQU "Round8" perl -W -e "print sprintf('%%%%.8f ',eval(join('',@ARGV))); print \"\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9\"" >> %calc_dot_bat%
	ECHO IF /I "%%1" EQU "Round9" perl -W -e "print sprintf('%%%%.9f ',eval(join('',@ARGV))); print \"\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9\"" >> %calc_dot_bat%

	CD "%tempdrive%"


	REM Output XML Header
	ECHO ^<?xml version="1.0" encoding="Windows-1252" ?^> > %tempfilename%
	ECHO ^<prtg^> >> %tempfilename%


	REM REM CPU core0-3 average temp
	REM FOR /F "tokens=* usebackq" %%A IN (`"calc.bat round2 (%cputemp0%+%cputemp1%+%cputemp2%+%cputemp3%)/4"`) DO SET cputempavg=%%A
	REM ECHO    ^<result^>
	REM ECHO        ^<Channel^>CPU Cores Average Temp^</Channel^>
	REM ECHO        ^<Value^>%cputempavg%^</Value^>
	REM ECHO        ^<Mode^>Absolute^</Mode^>
	REM ECHO        ^<Unit^>Temperature^</Unit^>
	REM ECHO        ^<Float^>1^</Float^>
	REM ECHO        ^<ShowChart^>1^</ShowChart^>
	REM ECHO        ^<ShowTable^>1^</ShowTable^>
	REM ECHO    ^</result^>


	REM Motherboard Temps
	ECHO    ^<result^> >> %tempfilename%
	ECHO        ^<Channel^>Motherboard Temperature #1^</Channel^> >> %tempfilename%
	ECHO        ^<Value^>%motherboard1%^</Value^> >> %tempfilename%
	ECHO        ^<Mode^>Absolute^</Mode^> >> %tempfilename%
	ECHO        ^<Unit^>Temperature^</Unit^> >> %tempfilename%
	ECHO        ^<Float^>1^</Float^> >> %tempfilename%
	ECHO        ^<ShowChart^>1^</ShowChart^> >> %tempfilename%
	ECHO        ^<ShowTable^>1^</ShowTable^> >> %tempfilename%
	ECHO    ^</result^> >> %tempfilename%

	ECHO    ^<result^> >> %tempfilename%
	ECHO        ^<Channel^>Motherboard Temperature #2^</Channel^> >> %tempfilename%
	ECHO        ^<Value^>%motherboard2%^</Value^> >> %tempfilename%
	ECHO        ^<Mode^>Absolute^</Mode^> >> %tempfilename%
	ECHO        ^<Unit^>Temperature^</Unit^> >> %tempfilename%
	ECHO        ^<Float^>1^</Float^> >> %tempfilename%
	ECHO        ^<ShowChart^>1^</ShowChart^> >> %tempfilename%
	ECHO        ^<ShowTable^>1^</ShowTable^> >> %tempfilename%
	ECHO    ^</result^> >> %tempfilename%
	
	ECHO    ^<result^> >> %tempfilename%
	ECHO        ^<Channel^>Motherboard Temperature #3^</Channel^> >> %tempfilename%
	ECHO        ^<Value^>%motherboard3%^</Value^> >> %tempfilename%
	ECHO        ^<Mode^>Absolute^</Mode^> >> %tempfilename%
	ECHO        ^<Unit^>Temperature^</Unit^> >> %tempfilename%
	ECHO        ^<Float^>1^</Float^> >> %tempfilename%
	ECHO        ^<ShowChart^>1^</ShowChart^> >> %tempfilename%
	ECHO        ^<ShowTable^>1^</ShowTable^> >> %tempfilename%
	ECHO    ^</result^> >> %tempfilename%
	
	ECHO    ^<result^> >> %tempfilename%
	ECHO        ^<Channel^>Motherboard Temperature #4^</Channel^> >> %tempfilename%
	ECHO        ^<Value^>%motherboard4%^</Value^> >> %tempfilename%
	ECHO        ^<Mode^>Absolute^</Mode^> >> %tempfilename%
	ECHO        ^<Unit^>Temperature^</Unit^> >> %tempfilename%
	ECHO        ^<Float^>1^</Float^> >> %tempfilename%
	ECHO        ^<ShowChart^>1^</ShowChart^> >> %tempfilename%
	ECHO        ^<ShowTable^>1^</ShowTable^> >> %tempfilename%
	ECHO    ^</result^> >> %tempfilename%

	ECHO    ^<result^> >> %tempfilename%
	ECHO        ^<Channel^>Motherboard Temperature #5^</Channel^> >> %tempfilename%
	ECHO        ^<Value^>%motherboard5%^</Value^> >> %tempfilename%
	ECHO        ^<Mode^>Absolute^</Mode^> >> %tempfilename%
	ECHO        ^<Unit^>Temperature^</Unit^> >> %tempfilename%
	ECHO        ^<Float^>1^</Float^> >> %tempfilename%
	ECHO        ^<ShowChart^>1^</ShowChart^> >> %tempfilename%
	ECHO        ^<ShowTable^>1^</ShowTable^> >> %tempfilename%
	ECHO    ^</result^> >> %tempfilename%

	ECHO    ^<result^> >> %tempfilename%
	ECHO        ^<Channel^>Motherboard Temperature #6^</Channel^> >> %tempfilename%
	ECHO        ^<Value^>%motherboard6%^</Value^> >> %tempfilename%
	ECHO        ^<Mode^>Absolute^</Mode^> >> %tempfilename%
	ECHO        ^<Unit^>Temperature^</Unit^> >> %tempfilename%
	ECHO        ^<Float^>1^</Float^> >> %tempfilename%
	ECHO        ^<ShowChart^>1^</ShowChart^> >> %tempfilename%
	ECHO        ^<ShowTable^>1^</ShowTable^> >> %tempfilename%
	ECHO    ^</result^> >> %tempfilename%


	REM Motherboard 4-Pin headers (All)
	ECHO    ^<result^> >> %tempfilename%
	ECHO        ^<Channel^>Fan #1^</Channel^> >> %tempfilename%
	ECHO        ^<Value^>%mobo_fan1%^</Value^> >> %tempfilename%
	ECHO        ^<Mode^>Absolute^</Mode^> >> %tempfilename%
	ECHO        ^<Unit^>Custom^</Unit^> >> %tempfilename%
	ECHO        ^<CustomUnit^>rpm^</CustomUnit^> >> %tempfilename%
	ECHO        ^<Float^>1^</Float^> >> %tempfilename%
	ECHO        ^<ShowChart^>1^</ShowChart^> >> %tempfilename%
	ECHO        ^<ShowTable^>1^</ShowTable^> >> %tempfilename%
	ECHO    ^</result^> >> %tempfilename%

	ECHO    ^<result^> >> %tempfilename%
	ECHO        ^<Channel^>Fan #2^</Channel^> >> %tempfilename%
	ECHO        ^<Value^>%mobo_fan2%^</Value^> >> %tempfilename%
	ECHO        ^<Mode^>Absolute^</Mode^> >> %tempfilename%
	ECHO        ^<Unit^>Custom^</Unit^> >> %tempfilename%
	ECHO        ^<CustomUnit^>rpm^</CustomUnit^> >> %tempfilename%
	ECHO        ^<Float^>1^</Float^> >> %tempfilename%
	ECHO        ^<ShowChart^>1^</ShowChart^> >> %tempfilename%
	ECHO        ^<ShowTable^>1^</ShowTable^> >> %tempfilename%
	ECHO    ^</result^> >> %tempfilename%

	ECHO    ^<result^> >> %tempfilename%
	ECHO        ^<Channel^>Fan #3^</Channel^> >> %tempfilename%
	ECHO        ^<Value^>%mobo_fan3%^</Value^> >> %tempfilename%
	ECHO        ^<Mode^>Absolute^</Mode^> >> %tempfilename%
	ECHO        ^<Unit^>Custom^</Unit^> >> %tempfilename%
	ECHO        ^<CustomUnit^>rpm^</CustomUnit^> >> %tempfilename%
	ECHO        ^<Float^>1^</Float^> >> %tempfilename%
	ECHO        ^<ShowChart^>1^</ShowChart^> >> %tempfilename%
	ECHO        ^<ShowTable^>1^</ShowTable^> >> %tempfilename%
	ECHO    ^</result^> >> %tempfilename%

	ECHO    ^<result^> >> %tempfilename%
	ECHO        ^<Channel^>Fan #4^</Channel^> >> %tempfilename%
	ECHO        ^<Value^>%mobo_fan4%^</Value^> >> %tempfilename%
	ECHO        ^<Mode^>Absolute^</Mode^> >> %tempfilename%
	ECHO        ^<Unit^>Custom^</Unit^> >> %tempfilename%
	ECHO        ^<CustomUnit^>rpm^</CustomUnit^> >> %tempfilename%
	ECHO        ^<Float^>1^</Float^> >> %tempfilename%
	ECHO        ^<ShowChart^>1^</ShowChart^> >> %tempfilename%
	ECHO        ^<ShowTable^>1^</ShowTable^> >> %tempfilename%
	ECHO    ^</result^> >> %tempfilename%

	ECHO    ^<result^> >> %tempfilename%
	ECHO        ^<Channel^>Fan #5^</Channel^> >> %tempfilename%
	ECHO        ^<Value^>%mobo_fan5%^</Value^> >> %tempfilename%
	ECHO        ^<Mode^>Absolute^</Mode^> >> %tempfilename%
	ECHO        ^<Unit^>Custom^</Unit^> >> %tempfilename%
	ECHO        ^<CustomUnit^>rpm^</CustomUnit^> >> %tempfilename%
	ECHO        ^<Float^>1^</Float^> >> %tempfilename%
	ECHO        ^<ShowChart^>1^</ShowChart^> >> %tempfilename%
	ECHO        ^<ShowTable^>1^</ShowTable^> >> %tempfilename%
	ECHO    ^</result^> >> %tempfilename%

	ECHO    ^<result^> >> %tempfilename%
	ECHO        ^<Channel^>Fan #6^</Channel^> >> %tempfilename%
	ECHO        ^<Value^>%mobo_fan6%^</Value^> >> %tempfilename%
	ECHO        ^<Mode^>Absolute^</Mode^> >> %tempfilename%
	ECHO        ^<Unit^>Custom^</Unit^> >> %tempfilename%
	ECHO        ^<CustomUnit^>rpm^</CustomUnit^> >> %tempfilename%
	ECHO        ^<Float^>1^</Float^> >> %tempfilename%
	ECHO        ^<ShowChart^>1^</ShowChart^> >> %tempfilename%
	ECHO        ^<ShowTable^>1^</ShowTable^> >> %tempfilename%
	ECHO    ^</result^> >> %tempfilename%



	REM CPU single cores
	ECHO    ^<result^> >> %tempfilename%
	ECHO        ^<Channel^>CPU Core 0 Temp^</Channel^> >> %tempfilename%
	ECHO        ^<Value^>%cputemp0%^</Value^> >> %tempfilename%
	ECHO        ^<Mode^>Absolute^</Mode^> >> %tempfilename%
	ECHO        ^<Unit^>Temperature^</Unit^> >> %tempfilename%
	ECHO        ^<Float^>1^</Float^> >> %tempfilename%
	ECHO        ^<ShowChart^>0^</ShowChart^> >> %tempfilename%
	ECHO        ^<ShowTable^>0^</ShowTable^> >> %tempfilename%
	ECHO    ^</result^> >> %tempfilename%
	ECHO    ^<result^> >> %tempfilename%
	ECHO        ^<Channel^>CPU Core 1 Temp^</Channel^> >> %tempfilename%
	ECHO        ^<Value^>%cputemp1%^</Value^> >> %tempfilename%
	ECHO        ^<Mode^>Absolute^</Mode^> >> %tempfilename%
	ECHO        ^<Unit^>Temperature^</Unit^> >> %tempfilename%
	ECHO        ^<Float^>1^</Float^> >> %tempfilename%
	ECHO        ^<ShowChart^>0^</ShowChart^> >> %tempfilename%
	ECHO        ^<ShowTable^>0^</ShowTable^> >> %tempfilename%
	ECHO    ^</result^> >> %tempfilename%
	ECHO    ^<result^> >> %tempfilename%
	ECHO        ^<Channel^>CPU Core 2 Temp^</Channel^> >> %tempfilename%
	ECHO        ^<Value^>%cputemp2%^</Value^> >> %tempfilename%
	ECHO        ^<Mode^>Absolute^</Mode^> >> %tempfilename%
	ECHO        ^<Unit^>Temperature^</Unit^> >> %tempfilename%
	ECHO        ^<Float^>1^</Float^> >> %tempfilename%
	ECHO        ^<ShowChart^>0^</ShowChart^> >> %tempfilename%
	ECHO        ^<ShowTable^>0^</ShowTable^> >> %tempfilename%
	ECHO    ^</result^> >> %tempfilename%
	ECHO    ^<result^> >> %tempfilename%
	ECHO        ^<Channel^>CPU Core 3 Temp^</Channel^> >> %tempfilename%
	ECHO        ^<Value^>%cputemp3%^</Value^> >> %tempfilename%
	ECHO        ^<Mode^>Absolute^</Mode^> >> %tempfilename%
	ECHO        ^<Unit^>Temperature^</Unit^> >> %tempfilename%
	ECHO        ^<Float^>1^</Float^> >> %tempfilename%
	ECHO        ^<ShowChart^>0^</ShowChart^> >> %tempfilename%
	ECHO        ^<ShowTable^>0^</ShowTable^> >> %tempfilename%
	ECHO    ^</result^> >> %tempfilename%
	ECHO    ^<result^> >> %tempfilename%
	ECHO        ^<Channel^>CPU Package Temp^</Channel^> >> %tempfilename%
	ECHO        ^<Value^>%cputemp4%^</Value^> >> %tempfilename%
	ECHO        ^<Mode^>Absolute^</Mode^> >> %tempfilename%
	ECHO        ^<Unit^>Temperature^</Unit^> >> %tempfilename%
	ECHO        ^<Float^>1^</Float^> >> %tempfilename%
	ECHO        ^<ShowChart^>0^</ShowChart^> >> %tempfilename%
	ECHO        ^<ShowTable^>0^</ShowTable^> >> %tempfilename%
	ECHO    ^</result^> >> %tempfilename%


	REM Output XML Footer
	ECHO ^</prtg^> >> %tempfilename%

	REM Send the ECHO'ed contents to STDOUT
	TYPE %tempfilename%

	EXIT /B


REM ------------------------------------------------------------
REM 
REM Citation(s)
REM
REM   community.spiceworks.com  |  "[SOLVED] Invalid Global Switch - wmic - Spiceworks General Support - Spiceworks"  |  https://community.spiceworks.com/topic/218342-invalid-global-switch-wmic
REM 
REM   docs.microsoft.com  |  "Get-Content"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-content?view=powershell-5.1
REM 
REM   docs.microsoft.com  |  "Get-WmiObject"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-wmiobject?view=powershell-5.1
REM 
REM   docs.microsoft.com  |  "wmic - Win32 apps | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/win32/wmisdk/wmic?redirectedfrom=MSDN
REM
REM   docs.microsoft.com  |  "WMIC switches: Windows Management Instrumentation (WMI); Scripting | Microsoft Docs"  |  https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc787035(v=ws.10)?redirectedfrom=MSDN
REM
REM   pastebin.com  |  "[Batch] calc - Pastebin.com"  |  https://pastebin.com/Kr35D3A4
REM
REM   pastebin.com  |  "[Batch] EXEXML/ohm-computer1.bat - Pastebin.com"  |  https://pastebin.com/V5dU1GSf
REM
REM   pastebin.com  |  "[Batch] ohm-computer1-hw - Pastebin.com"  |  https://pastebin.com/4GjHWeTn
REM
REM   pastebin.com  |  "[Batch] pingcheck - Pastebin.com"  |  https://pastebin.com/1ESd9Tv9
REM
REM   sites.google.com  |  "Example 2 (WMI/OHM) - Custom sensors for PRTG"  |  https://sites.google.com/site/prtghowto/example-2
REM 
REM 
REM ------------------------------------------------------------