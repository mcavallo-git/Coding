@ECHO off
SETLOCAL EnableDelayedExpansion

:: Here we create the RAM drive for the temporary files used by all the PRTG bat scripts
:: -P (persistent) doesnt work, it will be unformatted after reboot
IF NOT EXIST Z: ( C:\windows\system32\imdisk.exe -a -u 0 -m Z: -s 64M -p "/fs:ntfs /q /y /v:RAMDRIVE" -o awe )

C:
CD \prtg

ECHO ^<?xml version="1.0" encoding="Windows-1252" ?^>
ECHO ^<prtg^>

REM CALL D:\prtg\pingcheck.bat %1
CALL :PINGCHECK %1

REM CALL D:\prtg\ohm-computer1.bat %1 %2 %3
CALL :OHMCOMPUTERHW %1 %2 %3


REM ------------------------------------------------------------

:CALC
@ECHO off
:: Copyright (C) 2016 unknown14725
:: version 1    (2014.12.15)
:: version 1.01 (2016.06.27) Removed a typo in the Perl function
:: Requires Perl
::
:: These perl one-liners should handle any calculation, but please avoid using too many spaces, as batch arguments are limited to 9.
:: Windows' shell SET /A is limited to 32bit integer, and I tried using a "calc.exe" found on sourceforge, but it had some nasty
:: bugs with certain calculations. So here I'm trying my luck with Perl instead.
:: These one-liners require the use of quotes, and I got really stuck trying to figure out how to get it implemented in FOR /F
:: without causing problems in the syntax, so I had to give up. That's why I chose to use this external bat file instead.
::
:: EXAMPLES:
::              calc.bat float 10/3
::              calc.bat round2 10/3
::
:: I'm no good at perl stuff, and I spent like a total of two minutes writing this bat, so if anyone has a better
:: solution for a one-liner, feel free to suggest.

IF /I "%1" EQU "float"  perl -w -e "print eval(join('',@ARGV));print \"\n\"" %2 %3 %4 %5 %6 %7 %8 %9
IF /I "%1" EQU "Round0" perl -W -e "print sprintf('%%.0f ',eval(join('',@ARGV)));print \"\n\""  %2 %3 %4 %5 %6 %7 %8 %9
IF /I "%1" EQU "Round1" perl -W -e "print sprintf('%%.1f ',eval(join('',@ARGV)));print \"\n\""  %2 %3 %4 %5 %6 %7 %8 %9
IF /I "%1" EQU "Round2" perl -W -e "print sprintf('%%.2f ',eval(join('',@ARGV)));print \"\n\""  %2 %3 %4 %5 %6 %7 %8 %9
IF /I "%1" EQU "Round3" perl -W -e "print sprintf('%%.3f ',eval(join('',@ARGV)));print \"\n\""  %2 %3 %4 %5 %6 %7 %8 %9
IF /I "%1" EQU "Round4" perl -W -e "print sprintf('%%.4f ',eval(join('',@ARGV)));print \"\n\""  %2 %3 %4 %5 %6 %7 %8 %9
IF /I "%1" EQU "Round5" perl -W -e "print sprintf('%%.5f ',eval(join('',@ARGV)));print \"\n\""  %2 %3 %4 %5 %6 %7 %8 %9
IF /I "%1" EQU "Round6" perl -W -e "print sprintf('%%.6f ',eval(join('',@ARGV)));print \"\n\""  %2 %3 %4 %5 %6 %7 %8 %9
IF /I "%1" EQU "Round7" perl -W -e "print sprintf('%%.7f ',eval(join('',@ARGV)));print \"\n\""  %2 %3 %4 %5 %6 %7 %8 %9
IF /I "%1" EQU "Round8" perl -W -e "print sprintf('%%.8f ',eval(join('',@ARGV)));print \"\n\""  %2 %3 %4 %5 %6 %7 %8 %9
IF /I "%1" EQU "Round9" perl -W -e "print sprintf('%%.9f ',eval(join('',@ARGV)));print \"\n\""  %2 %3 %4 %5 %6 %7 %8 %9

EXIT /B


REM ------------------------------------------------------------

:PINGCHECK
@ECHO off
SETLOCAL EnableDelayedExpansion
:: This script will check to see if a host is reachable by ping. If not it will generate an error and wil quit the current cmd.exe
:: Usage
::      pingcheck.bat hostname

C:
CD \prtg
IF EXIST Z: (
    IF NOT EXIST Z:\temp MKDIR Z:\temp
    SET "tempdrive=Z:\temp\"
) ELSE ( SET "tempdrive=temp\" )

:: HERE WE CHECK TO SEE IF HOST IS ONLINE. IF NOT, WE GENERATE A WARNING, FINALIZE THE XML, AND QUIT  CMD.EXE
:: Ping the host 1 time and store it in the temp file (we also check to see if RAM drive Z: is available)
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

:OHMCOMPUTERHW
@ECHO off
SETLOCAL EnableDelayedExpansion

:: Open Hardware Monitor for computer1

:: Here you can change the drive and working directory used by this script. Remember to create the directory first!
C:
CD \prtg
IF EXIST Z: (
    IF NOT EXIST Z:\temp MKDIR Z:\temp
    SET "tempdrive=Z:\temp\"
) ELSE ( SET "tempdrive=temp\" )

SET "tempfilename=%tempdrive%~%~n0_%1.tmp"

IF [%1]==[] ( SET "remoteaccess=" ) ELSE ( SET "remoteaccess=/NODE:%1 /USER:%2 /PASSWORD:%3" )

:: Because WMIC outputs UNICODE we need to use MORE to 'convert' it to UTF-8 (to avoid all characters having a space inbetween)
WMIC %remoteaccess% /namespace:\\Root\OpenHardwareMonitor Path Sensor  Get Value,Identifier |MORE > %tempfilename%

:: Fan RPM
FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6776f/fan/0" %tempfilename%`) DO ( CALL :setVariable fan1 %%B )
FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6776f/fan/1" %tempfilename%`) DO ( CALL :setVariable fan2 %%B )
FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6776f/fan/2" %tempfilename%`) DO ( CALL :setVariable fan3 %%B )
FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6776f/fan/3" %tempfilename%`) DO ( CALL :setVariable fan4 %%B )
FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6776f/fan/4" %tempfilename%`) DO ( CALL :setVariable fan5 %%B )

:: Intel CPU temperatures
FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/intelcpu/0/temperature/0" %tempfilename%`) DO ( CALL :setVariable intel0 %%B )
FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/intelcpu/0/temperature/1" %tempfilename%`) DO ( CALL :setVariable intel1 %%B )
FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/intelcpu/0/temperature/2" %tempfilename%`) DO ( CALL :setVariable intel2 %%B )
FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/intelcpu/0/temperature/3" %tempfilename%`) DO ( CALL :setVariable intel3 %%B )
FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/intelcpu/0/temperature/4" %tempfilename%`) DO ( CALL :setVariable intel4 %%B )

:: Motherboard temperatures
FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6776f/temperature/0" %tempfilename%`) DO ( CALL :setVariable motherboard0 %%B )
FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6776f/temperature/2" %tempfilename%`) DO ( CALL :setVariable motherboard2 %%B )
FOR /F "tokens=1,2 usebackq" %%A IN (`FINDSTR /I /C:"/lpc/nct6776f/temperature/3" %tempfilename%`) DO ( CALL :setVariable motherboard3 %%B )

GOTO :Finalize

:setVariable
    SET "%1=%2"
GOTO :eof

:Finalize

:: CPU core0-3 average temp

FOR /F "tokens=* usebackq" %%A IN (`"calc.bat round2 (%intel0%+%intel1%+%intel2%+%intel3%)/4"`) DO SET intelavg=%%A
ECHO    ^<result^>
ECHO        ^<Channel^>CPU Cores Average Temp^</Channel^>
ECHO        ^<Value^>%intelavg%^</Value^>
ECHO        ^<Mode^>Absolute^</Mode^>
ECHO        ^<Unit^>Temperature^</Unit^>
ECHO        ^<Float^>1^</Float^>
ECHO        ^<ShowChart^>1^</ShowChart^>
ECHO        ^<ShowTable^>1^</ShowTable^>
ECHO    ^</result^>

:: Motherboard CPU temp

ECHO    ^<result^>
ECHO        ^<Channel^>Motherboard CPU Temp^</Channel^>
ECHO        ^<Value^>%motherboard0%^</Value^>
ECHO        ^<Mode^>Absolute^</Mode^>
ECHO        ^<Unit^>Temperature^</Unit^>
ECHO        ^<Float^>1^</Float^>
ECHO        ^<ShowChart^>1^</ShowChart^>
ECHO        ^<ShowTable^>1^</ShowTable^>
ECHO    ^</result^>

:: Motherboard case temp

ECHO    ^<result^>
ECHO        ^<Channel^>Motherboard 3 Temp^</Channel^>
ECHO        ^<Value^>%motherboard3%^</Value^>
ECHO        ^<Mode^>Absolute^</Mode^>
ECHO        ^<Unit^>Temperature^</Unit^>
ECHO        ^<Float^>1^</Float^>
ECHO        ^<ShowChart^>1^</ShowChart^>
ECHO        ^<ShowTable^>1^</ShowTable^>
ECHO    ^</result^>

:: Fans

:: Side fan auto (CHA_FAN1) (4 pin header)
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

:: H60 radiator/rear fan auto (CPU_FAN) (4 pin header)
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

:: Top fan adj auto (PWR_FAN1) (4 pin header)
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

:: H60 cpu pump auto (CHA_FAN2) (3 pin header)
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

:: External fan adj (PWR_FAN2) (3 pin header)
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

:: CPU single cores

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

:: Motherboard chipset (?) temp

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

:END

ECHO ^</prtg^>


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