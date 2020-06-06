REM @ECHO off
SETLOCAL EnableDelayedExpansion
REM ------------------------------------------------------------
REM 
REM 
REM    "%USERPROFILE%\Documents\GitHub\Coding\prtg\Custom Sensors\EXEXML\ohm-computer1.bat"
REM 
REM 
REM ------------------------------------------------------------
REM
REM 
REM  ! ! !   Pre-Req - Open Hardware Monitor  -->  https://openhardwaremonitor.org/downloads/
REM
REM
REM  ! ! !   Pre-Req - Perl  -->  https://www.perl.org/get.html

PowerShell -Command "Set-ExecutionPolicy ByPass -Scope CurrentUser -Force; If (-Not (Get-Command 'perl' -ErrorAction SilentlyContinue)) { [Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; If (-Not (Get-Command 'choco' -ErrorAction SilentlyContinue)) { Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) -ErrorAction SilentlyContinue; }; Start-Process -Filepath ('choco') -ArgumentList (@('feature','enable','-n=allowGlobalConfirmation')) -NoNewWindow -Wait -PassThru -ErrorAction SilentlyContinue | Out-Null; Start-Process -Filepath ('choco') -ArgumentList (@('install','strawberryperl')) -NoNewWindow -Wait -PassThru -ErrorAction SilentlyContinue | Out-Null; };" >nul 2>&1

CALL :SETUP_LOGGING

CALL :PING_CHECK %1

CALL :GET_TEMPS_FROM_OPEN_HARDWARE_MONITOR %1 %2 %3

CALL :OUTPUT_XML_HEADER

CALL :OUTPUT_RESULTS %1 %2 %3

PAUSE

CALL :OUTPUT_XML_FOOTER

EXIT /B


REM ------------------------------------------------------------
REM
REM     SETUP_LOGGING
REM
:SETUP_LOGGING

	REM Create temp-directory (if it doesn't already exist)

	SET "tempdrive=C:\temp\"
	IF NOT EXIST "%tempdrive%" MKDIR "%tempdrive%"

	EXIT /B


REM ------------------------------------------------------------
REM
REM     PING_CHECK
REM
:PING_CHECK
	SETLOCAL EnableDelayedExpansion
	REM HERE WE CHECK TO SEE IF HOST IS ONLINE. IF NOT, WE GENERATE A WARNING, FINALIZE THE XML, AND QUIT CMD.EXE
	REM Ping the host 1 time and store it in the temp file

	SET "tempdrive=C:\temp\"
	IF NOT EXIST "%tempdrive%" MKDIR "%tempdrive%"

	SET "tempfilename=%tempdrive%~%~n0_%1.tmp"

	PING -n 1 %1>%tempfilename%

	FOR /F "tokens=*" %%A IN ('FINDSTR /I /C:"unreachable" %tempfilename%') DO          (
			ECHO ^<Error^>1^</Error^>
			ECHO ^<Text^>^[%~n0^] %%A^</Text^>
			ECHO ^</prtg^>
			EXIT 5
	)

	FOR /F "tokens=*" %%A IN ('FINDSTR /I /C:"could not find" %tempfilename%') DO       (
			ECHO ^<Error^>1^</Error^>
			ECHO ^<Text^>^[%~n0^] %%A^</Text^>
			ECHO ^</prtg^>
			EXIT 5
	)

	FOR /F "tokens=*" %%A IN ('FINDSTR /I /C:"timed out" %tempfilename%') DO    (
			ECHO ^<Error^>1^</Error^>
			ECHO ^<Text^>^[%~n0^] %1: %%A^</Text^>
			ECHO ^</prtg^>
			EXIT 5
	)

	FOR /F "tokens=*" %%A IN ('FINDSTR /I /C:"expired" %tempfilename%') DO          (
			ECHO ^<Error^>1^</Error^>
			ECHO ^<Text^>^[%~n0^] %%A^</Text^>
			ECHO ^</prtg^>
			EXIT 5
	)

	FOR /F "tokens=*" %%A IN ('FINDSTR /I /C:"failed" %tempfilename%') DO      (
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

	REM Open Hardware Monitor for computer1

	REM Here you can change the drive and working directory used by this script. Remember to create the directory first!

	PowerShell -Command "Get-Service 'OpenHardwareMonitor' | Where-Object { $_.Running -Eq $False } | Start-Service;";

	REM TASKLIST /V /NH /FI "IMAGENAME eq OpenHardwareMonitor.exe"

	SET "tempdrive=C:\temp\"
	IF NOT EXIST "%tempdrive%" MKDIR "%tempdrive%"

	SET "tempfilename=%tempdrive%_%~n0_%1_2.tmp"

	IF [%1]==[] ( SET "remoteaccess=" ) ELSE ( SET "remoteaccess=/NODE:%1 /USER:%2 /PASSWORD:%3" )

	REM Because WMIC outputs UNICODE we need to use MORE to 'convert' it to UTF-8 (to avoid all characters having a space inbetween)
	WMIC %remoteaccess% /namespace:\\Root\OpenHardwareMonitor Path Sensor  Get Value,Identifier |MORE > %tempfilename%

	REM Fan RPM
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6776f/fan/0" %tempfilename%`) DO ( CALL :SET_VARIABLE fan1 %%B )
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6776f/fan/1" %tempfilename%`) DO ( CALL :SET_VARIABLE fan2 %%B )
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6776f/fan/2" %tempfilename%`) DO ( CALL :SET_VARIABLE fan3 %%B )
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6776f/fan/3" %tempfilename%`) DO ( CALL :SET_VARIABLE fan4 %%B )
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6776f/fan/4" %tempfilename%`) DO ( CALL :SET_VARIABLE fan5 %%B )

	REM Intel CPU temperatures
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/intelcpu/0/temperature/0" %tempfilename%`) DO ( CALL :SET_VARIABLE intel0 %%B )
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/intelcpu/0/temperature/1" %tempfilename%`) DO ( CALL :SET_VARIABLE intel1 %%B )
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/intelcpu/0/temperature/2" %tempfilename%`) DO ( CALL :SET_VARIABLE intel2 %%B )
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/intelcpu/0/temperature/3" %tempfilename%`) DO ( CALL :SET_VARIABLE intel3 %%B )
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/intelcpu/0/temperature/4" %tempfilename%`) DO ( CALL :SET_VARIABLE intel4 %%B )

	REM Motherboard temperatures
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6776f/temperature/0" %tempfilename%`) DO ( CALL :SET_VARIABLE motherboard0 %%B )
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6776f/temperature/2" %tempfilename%`) DO ( CALL :SET_VARIABLE motherboard2 %%B )
	FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6776f/temperature/3" %tempfilename%`) DO ( CALL :SET_VARIABLE motherboard3 %%B )

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

	REM Create subroutine file "calc.bat"
	SET "tempdrive=C:\temp\"
	IF NOT EXIST "%tempdrive%" MKDIR "%tempdrive%"

	SET "calc_dot_bat=%tempdrive%calc.bat"

	ECHO IF /I "%%1" EQU "float"  perl -w -e "print eval(join('',@ARGV)); print ""\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9"" " > %calc_dot_bat%
	ECHO IF /I "%%1" EQU "Round0" perl -W -e "print sprintf('%%%%.0f ',eval(join('',@ARGV))); print ""\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9""" >> %calc_dot_bat%
	ECHO IF /I "%%1" EQU "Round1" perl -W -e "print sprintf('%%%%.1f ',eval(join('',@ARGV))); print ""\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9""" >> %calc_dot_bat%
	ECHO IF /I "%%1" EQU "Round2" perl -W -e "print sprintf('%%%%.2f ',eval(join('',@ARGV))); print ""\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9""" >> %calc_dot_bat%
	ECHO IF /I "%%1" EQU "Round3" perl -W -e "print sprintf('%%%%.3f ',eval(join('',@ARGV))); print ""\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9""" >> %calc_dot_bat%
	ECHO IF /I "%%1" EQU "Round4" perl -W -e "print sprintf('%%%%.4f ',eval(join('',@ARGV))); print ""\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9""" >> %calc_dot_bat%
	ECHO IF /I "%%1" EQU "Round5" perl -W -e "print sprintf('%%%%.5f ',eval(join('',@ARGV))); print ""\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9""" >> %calc_dot_bat%
	ECHO IF /I "%%1" EQU "Round6" perl -W -e "print sprintf('%%%%.6f ',eval(join('',@ARGV))); print ""\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9""" >> %calc_dot_bat%
	ECHO IF /I "%%1" EQU "Round7" perl -W -e "print sprintf('%%%%.7f ',eval(join('',@ARGV))); print ""\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9""" >> %calc_dot_bat%
	ECHO IF /I "%%1" EQU "Round8" perl -W -e "print sprintf('%%%%.8f ',eval(join('',@ARGV))); print ""\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9""" >> %calc_dot_bat%
	ECHO IF /I "%%1" EQU "Round9" perl -W -e "print sprintf('%%%%.9f ',eval(join('',@ARGV))); print ""\n %%2 %%3 %%4 %%5 %%6 %%7 %%8 %%9""" >> %calc_dot_bat%

	CD "%tempdrive%"

	FOR /F "tokens=* usebackq" %%A IN (`"calc.bat round2 (%intel0%+%intel1%+%intel2%+%intel3%)/4"`) DO SET intelavg=%%A

	REM CPU core0-3 average temp
	ECHO    ^<result^>
	ECHO        ^<Channel^>CPU Cores Average Temp^</Channel^>
	ECHO        ^<Value^>%intelavg%^</Value^>
	ECHO        ^<Mode^>Absolute^</Mode^>
	ECHO        ^<Unit^>Temperature^</Unit^>
	ECHO        ^<Float^>1^</Float^>
	ECHO        ^<ShowChart^>1^</ShowChart^>
	ECHO        ^<ShowTable^>1^</ShowTable^>
	ECHO    ^</result^>

	REM Motherboard CPU temp
	ECHO    ^<result^>
	ECHO        ^<Channel^>Motherboard CPU Temp^</Channel^>
	ECHO        ^<Value^>%motherboard0%^</Value^>
	ECHO        ^<Mode^>Absolute^</Mode^>
	ECHO        ^<Unit^>Temperature^</Unit^>
	ECHO        ^<Float^>1^</Float^>
	ECHO        ^<ShowChart^>1^</ShowChart^>
	ECHO        ^<ShowTable^>1^</ShowTable^>
	ECHO    ^</result^>

	REM Motherboard case temp
	ECHO    ^<result^>
	ECHO        ^<Channel^>Motherboard 3 Temp^</Channel^>
	ECHO        ^<Value^>%motherboard3%^</Value^>
	ECHO        ^<Mode^>Absolute^</Mode^>
	ECHO        ^<Unit^>Temperature^</Unit^>
	ECHO        ^<Float^>1^</Float^>
	ECHO        ^<ShowChart^>1^</ShowChart^>
	ECHO        ^<ShowTable^>1^</ShowTable^>
	ECHO    ^</result^>

	REM Side fan auto (CHA_FAN1) (4 pin header)
	ECHO    ^<result^>
	ECHO        ^<Channel^>Fan 1^</Channel^>
	ECHO        ^<Value^>%fan1%^</Value^>
	ECHO        ^<Mode^>Absolute^</Mode^>
	ECHO        ^<Unit^>Custom^</Unit^>
	ECHO        ^<CustomUnit^>rpm^</CustomUnit^>
	ECHO        ^<Float^>1^</Float^>
	ECHO        ^<ShowChart^>1^</ShowChart^>
	ECHO        ^<ShowTable^>1^</ShowTable^>
	ECHO    ^</result^>

	REM H60 radiator/rear fan auto (CPU_FAN) (4 pin header)
	ECHO    ^<result^>
	ECHO        ^<Channel^>Fan 2^</Channel^>
	ECHO        ^<Value^>%fan2%^</Value^>
	ECHO        ^<Mode^>Absolute^</Mode^>
	ECHO        ^<Unit^>Custom^</Unit^>
	ECHO        ^<CustomUnit^>rpm^</CustomUnit^>
	ECHO        ^<Float^>1^</Float^>
	ECHO        ^<ShowChart^>1^</ShowChart^>
	ECHO        ^<ShowTable^>1^</ShowTable^>
	ECHO    ^</result^>

	REM Top fan adj auto (PWR_FAN1) (4 pin header)
	ECHO    ^<result^>
	ECHO        ^<Channel^>Fan 3^</Channel^>
	ECHO        ^<Value^>%fan3%^</Value^>
	ECHO        ^<Mode^>Absolute^</Mode^>
	ECHO        ^<Unit^>Custom^</Unit^>
	ECHO        ^<CustomUnit^>rpm^</CustomUnit^>
	ECHO        ^<Float^>1^</Float^>
	ECHO        ^<ShowChart^>1^</ShowChart^>
	ECHO        ^<ShowTable^>1^</ShowTable^>
	ECHO    ^</result^>

	REM H60 cpu pump auto (CHA_FAN2) (3 pin header)
	ECHO    ^<result^>
	ECHO        ^<Channel^>Fan 4^</Channel^>
	ECHO        ^<Value^>%fan4%^</Value^>
	ECHO        ^<Mode^>Absolute^</Mode^>
	ECHO        ^<Unit^>Custom^</Unit^>
	ECHO        ^<CustomUnit^>rpm^</CustomUnit^>
	ECHO        ^<Float^>1^</Float^>
	ECHO        ^<ShowChart^>1^</ShowChart^>
	ECHO        ^<ShowTable^>1^</ShowTable^>
	ECHO    ^</result^>

	REM External fan adj (PWR_FAN2) (3 pin header)
	ECHO    ^<result^>
	ECHO        ^<Channel^>Fan 5^</Channel^>
	ECHO        ^<Value^>%fan5%^</Value^>
	ECHO        ^<Mode^>Absolute^</Mode^>
	ECHO        ^<Unit^>Custom^</Unit^>
	ECHO        ^<CustomUnit^>rpm^</CustomUnit^>
	ECHO        ^<Float^>1^</Float^>
	ECHO        ^<ShowChart^>1^</ShowChart^>
	ECHO        ^<ShowTable^>1^</ShowTable^>
	ECHO    ^</result^>

	REM CPU single cores
	ECHO    ^<result^>
	ECHO        ^<Channel^>CPU Core 0 Temp^</Channel^>
	ECHO        ^<Value^>%intel0%^</Value^>
	ECHO        ^<Mode^>Absolute^</Mode^>
	ECHO        ^<Unit^>Temperature^</Unit^>
	ECHO        ^<Float^>1^</Float^>
	ECHO        ^<ShowChart^>0^</ShowChart^>
	ECHO        ^<ShowTable^>0^</ShowTable^>
	ECHO    ^</result^>
	ECHO    ^<result^>
	ECHO        ^<Channel^>CPU Core 1 Temp^</Channel^>
	ECHO        ^<Value^>%intel1%^</Value^>
	ECHO        ^<Mode^>Absolute^</Mode^>
	ECHO        ^<Unit^>Temperature^</Unit^>
	ECHO        ^<Float^>1^</Float^>
	ECHO        ^<ShowChart^>0^</ShowChart^>
	ECHO        ^<ShowTable^>0^</ShowTable^>
	ECHO    ^</result^>
	ECHO    ^<result^>
	ECHO        ^<Channel^>CPU Core 2 Temp^</Channel^>
	ECHO        ^<Value^>%intel2%^</Value^>
	ECHO        ^<Mode^>Absolute^</Mode^>
	ECHO        ^<Unit^>Temperature^</Unit^>
	ECHO        ^<Float^>1^</Float^>
	ECHO        ^<ShowChart^>0^</ShowChart^>
	ECHO        ^<ShowTable^>0^</ShowTable^>
	ECHO    ^</result^>
	ECHO    ^<result^>
	ECHO        ^<Channel^>CPU Core 3 Temp^</Channel^>
	ECHO        ^<Value^>%intel3%^</Value^>
	ECHO        ^<Mode^>Absolute^</Mode^>
	ECHO        ^<Unit^>Temperature^</Unit^>
	ECHO        ^<Float^>1^</Float^>
	ECHO        ^<ShowChart^>0^</ShowChart^>
	ECHO        ^<ShowTable^>0^</ShowTable^>
	ECHO    ^</result^>
	ECHO    ^<result^>
	ECHO        ^<Channel^>CPU Package Temp^</Channel^>
	ECHO        ^<Value^>%intel4%^</Value^>
	ECHO        ^<Mode^>Absolute^</Mode^>
	ECHO        ^<Unit^>Temperature^</Unit^>
	ECHO        ^<Float^>1^</Float^>
	ECHO        ^<ShowChart^>0^</ShowChart^>
	ECHO        ^<ShowTable^>0^</ShowTable^>
	ECHO    ^</result^>

	REM Motherboard chipset (?) temp
	ECHO    ^<result^>
	ECHO        ^<Channel^>Motherboard 2 Temp^</Channel^>
	ECHO        ^<Value^>%motherboard2%^</Value^>
	ECHO        ^<Mode^>Absolute^</Mode^>
	ECHO        ^<Unit^>Temperature^</Unit^>
	ECHO        ^<Float^>1^</Float^>
	ECHO        ^<ShowChart^>1^</ShowChart^>
	ECHO        ^<ShowTable^>1^</ShowTable^>
	ECHO    ^</result^>

	EXIT /B


REM ------------------------------------------------------------
REM
REM     OUTPUT_XML_HEADER
REM
: OUTPUT_XML_HEADER

	ECHO ^<?xml version="1.0" encoding="Windows-1252" ?^>
	ECHO ^<prtg^>

	EXIT /B


REM ------------------------------------------------------------
REM
REM     OUTPUT_XML_FOOTER
REM
: OUTPUT_XML_FOOTER

	ECHO ^</prtg^>

	EXIT /B


REM ------------------------------------------------------------
REM
REM Citation(s)
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
REM ------------------------------------------------------------