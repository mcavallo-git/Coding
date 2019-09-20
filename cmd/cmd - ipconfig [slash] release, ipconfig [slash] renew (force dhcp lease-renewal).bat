@ECHO OFF
REM ------------------------------------------------------------
REM  IPv4 LAN Connection(s) - Disconnect-Flush-Connect-Register

ipconfig /release
ipconfig /registerdns
ipconfig /flushdns
ipconfig /renew

EXIT

REM ------------------------------------------------------------
REM  IPv6 LAN Connection(s) - Disconnect-Flush-Connect-Register

ipconfig /release6
ipconfig /flushdns
ipconfig /renew6
ipconfig /registerdns

REM ------------------------------------------------------------