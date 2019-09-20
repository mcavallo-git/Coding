@ECHO OFF

ping -t -4 192.168.0.1
ping -t -4 -w 200 192.168.0.1

ping -t -4 -w 200 8.8.8.8

REM ------------------------------------------------------------
REM USING [ BATCH-FILES ] + [ VARIABLES ]:
for /f "tokens=14" %%a in ('ipconfig ^| findstr IPv4') do set _IPaddr=%%a
ping -t -4 -w 200 %_IPaddr%

REM USING [ BATCH-FILES ] + [ DIRECT ]:
for /f "tokens=14" %%a in ('ipconfig ^| findstr IPv4') do ping -t -4 -w 200 %%a

EXIT

REM ------------------------------------------------------------

REM USING [ CMD ] + [ VARIABLES ]:
for /f "tokens=13" %a in ('ipconfig ^| findstr "Default Gateway"') do set _IPaddr=%a
ping -t -4 -w 200 %_IPaddr%

REM USING [ CMD ] + [ DIRECT ]:
for /f "tokens=14" %a in ('ipconfig ^| findstr IPv4') do ping -t -4 -w 200 %a

REM ------------------------------------------------------------