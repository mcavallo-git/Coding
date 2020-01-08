
netsh http show sslcert ipport=0.0.0.0:443

netsh http show cachestate

netsh http show servicestate

netsh http update sslcert ipport=0.0.0.0:443 appid={SID} certhash=FINGERPRINT

REM HOST_NAME="FQDN"; echo | openssl s_client -servername "${HOST_NAME}" -connect "${HOST_NAME}:443";


REM ------------------------------------------------------------
REM
REM  Citation(s)
REM
REM    docs.microsoft.com  |  "Netsh commands for HTTP - Win32 apps | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/win32/http/netsh-commands-for-http
REM
REM    weblog.west-wind.com  |  "Hosting SignalR under SSL/https"  |  https://weblog.west-wind.com/posts/2013/sep/23/hosting-signalr-under-sslhttps
REM
REM ------------------------------------------------------------