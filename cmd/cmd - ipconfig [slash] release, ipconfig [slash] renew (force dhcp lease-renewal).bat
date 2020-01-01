@ECHO OFF
REM ------------------------------------------------------------

REM  IPv4 LAN Connection(s) - Release-Renew
ECHO Calling [ ipconfig /release ] ...
ipconfig /release
ECHO Calling [ ipconfig /renew ] ...
ipconfig /renew

REM  IPv6 LAN Connection(s) - Release-Renew
ECHO Calling [ ipconfig /release6 ] ...
ipconfig /release6
ECHO Calling [ ipconfig /renew6 ] ...
ipconfig /renew6

REM  Local DNS Resolver/Cache - Flush-ReRegister
ECHO Calling [ ipconfig /flushdns ] ...
ipconfig /flushdns
ECHO Calling [ ipconfig /registerdns ] ...
ipconfig /registerdns

TIMEOUT -T 30

EXIT


REM ------------------------------------------------------------
REM Manually Perform Above Task(s)

ipconfig /release
ipconfig /renew

ipconfig /release6
ipconfig /renew6

ipconfig /flushdns
ipconfig /registerdns

ipconfig /all


REM ------------------------------------------------------------
REM 
REM Use the ipconfig /flushdns command to flush and refresh the DNS client resolver cache with just the entries in the Hosts file
REM 
ipconfig /flushdns

REM 
REM Use the ipconfig /displaydns command to view the contents of the DNS client resolver cache
REM 
ECHO. > %USERPROFILE%\Desktop\ipconfig.log
ECHO ------------------------------------------------------------ >> %USERPROFILE%\Desktop\ipconfig.log
ECHO. >> %USERPROFILE%\Desktop\ipconfig.log
ECHO ipconfig /displaydns >> %USERPROFILE%\Desktop\ipconfig.log
ECHO. >> %USERPROFILE%\Desktop\ipconfig.log
ipconfig /displaydns >> %USERPROFILE%\Desktop\ipconfig.log
ECHO ------------------------------------------------------------ >> %USERPROFILE%\Desktop\ipconfig.log
ECHO. >> %USERPROFILE%\Desktop\ipconfig.log
ECHO ipconfig /all >> %USERPROFILE%\Desktop\ipconfig.log
ECHO. >> %USERPROFILE%\Desktop\ipconfig.log
ipconfig /all >> %USERPROFILE%\Desktop\ipconfig.log
Notepad %USERPROFILE%\Desktop\ipconfig.log


REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   docs.microsoft.com  |  "Chapter 7 - Host Name Resolution"  |  https://docs.microsoft.com/en-us/previous-versions/bb727005
REM
REM ------------------------------------------------------------