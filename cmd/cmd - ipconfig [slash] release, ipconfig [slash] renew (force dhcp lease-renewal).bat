@ECHO OFF
REM ------------------------------------------------------------
REM  IPv4 LAN Connection(s) - Disconnect-Flush-Connect-Register

ECHO Calling [ ipconfig /release ] ...
ipconfig /release
ECHO Calling [ ipconfig /flushdns ] ...
ipconfig /flushdns
ECHO Calling [ ipconfig /renew ] ...
ipconfig /renew
ECHO Calling [ ipconfig /registerdns ] ...
ipconfig /registerdns

TIMEOUT -T 30

EXIT

REM ------------------------------------------------------------
REM  IPv6 LAN Connection(s) - Disconnect-Flush-Connect-Register

ECHO Calling [ ipconfig /release6 ] ...
ipconfig /release6
ECHO Calling [ ipconfig /flushdns ] ...
ipconfig /flushdns
ECHO Calling [ ipconfig /renew6 ] ...
ipconfig /renew6
ECHO Calling [ ipconfig /registerdns ] ...
ipconfig /registerdns

TIMEOUT -T 30

REM ------------------------------------------------------------
REM Manually Perform Above Task(s)

ipconfig /release
ipconfig /registerdns
ipconfig /flushdns
ipconfig /renew

ipconfig /release6
ipconfig /registerdns
ipconfig /flushdns
ipconfig /renew6

REM ------------------------------------------------------------