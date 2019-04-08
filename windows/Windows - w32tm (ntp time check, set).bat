
REM Technet - Windows Time Service Tools and Settings
REM   --> https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/get-started/windows-time-service/windows-time-service-tools-and-settings

REM  Get the status of the local Windows Time service
w32tm /query /status
REM  Get the configuration of the local Windows Time service
w32tm /query /configuration
REM  Get NTP server currently being synced-to (non-verbose)
w32tm /query /source
REM  Get NTP server(s) currently being synced-to (verbose)
w32tm /query /peers /verbose 

REM  Get the time-differential between selected NTP server and the local Windows Time
SET NTP_SERVER=us.pool.ntp.org
SET NTP_SERVER=time.windows.com
SET NTP_SERVER=time.google.com
w32tm /stripchart /computer:%NTP_SERVER% /samples:5 /dataonly

REM  Update local device's time (manually)
SET NTP_SERVER=us.pool.ntp.org
SET NTP_SERVER=time.windows.com
SET NTP_SERVER=time.google.com
w32tm /config /syncfromflags:MANUAL /manualpeerlist:%NTP_SERVER%
w32tm /config /update

REM  Force Windows Time to re-sync
w32tm /resync

REM  Force Windows Time to re-detect network resources, then re-sync
w32tm /resync /rediscover
