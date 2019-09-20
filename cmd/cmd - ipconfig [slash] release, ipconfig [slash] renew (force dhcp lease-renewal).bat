@ECHO OFF
REM ------------------------------------------------------------
REM  IPv4 LAN Connection(s) - Disconnect-Flush-Connect-Register

ECHO Calling [ ipconfig /release ] ...
ipconfig /release
ECHO Calling [ ipconfig /registerdns ] ...
ipconfig /registerdns
ECHO Calling [ ipconfig /flushdns ] ...
ipconfig /flushdns
ECHO Calling [ ipconfig /renew ] ...
ipconfig /renew

TIMEOUT -T 30

EXIT

REM ------------------------------------------------------------
REM  IPv6 LAN Connection(s) - Disconnect-Flush-Connect-Register

ECHO Calling [ ipconfig /release6 ] ...
ipconfig /release6
ECHO Calling [ ipconfig /registerdns ] ...
ipconfig /registerdns
ECHO Calling [ ipconfig /flushdns ] ...
ipconfig /flushdns
ECHO Calling [ ipconfig /renew6 ] ...
ipconfig /renew6

TIMEOUT -T 30

REM ------------------------------------------------------------