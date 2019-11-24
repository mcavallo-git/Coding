@ECHO OFF
EXIT
REM ------------------------------------------------------------
REM
REM CMD - Get Timestamp (the robust way)
REM 


REM Get Last Sync-Time from WMMIC
FOR /F "tokens=5 delims= " %a IN ('w32tm /query /status /verbose ^| find "Last Successful Sync Time:" ') DO SET LAST_SYNC_DATE=%a
REM SET LAST_SYNC_DATE=11/24/2019
SET LAST_SYNC_DATE=11/24/2019
FOR /f "tokens=3 delims=//" %a IN ('ECHO %LAST_SYNC_DATE%') DO SET /A LAST_SYNC_YEAR=%a
FOR /f "tokens=1 delims=//" %a IN ('ECHO %LAST_SYNC_DATE%') DO SET /A LAST_SYNC_MONTH=%a
FOR /f "tokens=2 delims=//" %a IN ('ECHO %LAST_SYNC_DATE%') DO SET /A LAST_SYNC_DAY=%a
FOR /F "tokens=6 delims= " %a IN ('w32tm /query /status /verbose ^| find "Last Successful Sync Time:" ') DO SET LAST_SYNC_TIME=%a
REM SET LAST_SYNC_TIME=2:00:03
SET LAST_SYNC_TIME=23:59:59
FOR /f "tokens=1 delims=/:" %a IN ('ECHO %LAST_SYNC_TIME%') DO SET /A LAST_SYNC_HOUR=%a
FOR /f "tokens=2 delims=/:" %a IN ('ECHO %LAST_SYNC_TIME%') DO SET /A LAST_SYNC_MIN=%a
FOR /f "tokens=3 delims=/:" %a IN ('ECHO %LAST_SYNC_TIME%') DO SET /A LAST_SYNC_SEC=%a
FOR /F "tokens=7 delims= " %a IN ('w32tm /query /status /verbose ^| find "Last Successful Sync Time:" ') DO SET LAST_SYNC_AM_PM=%a
SET LAST_SYNC_HRS_TO_ADD=%LAST_SYNC_AM_PM:AM=00%
SET LAST_SYNC_HRS_TO_ADD=%LAST_SYNC_AM_PM:PM=12%
SET /A LAST_SYNC_HOUR=(LAST_SYNC_HOUR+LAST_SYNC_HRS_TO_ADD)

FOR /F "tokens=7 delims= " %a IN ('w32tm /query /status /verbose ^| find "Time since Last Good Sync Time:" ') DO SET ELAPSED_TIME_SINCE_LAST_SYNC=%a
REM SET ELAPSED_TIME_SINCE_LAST_SYNC=6.8288064s
SET ELAPSED_TIME_SINCE_LAST_SYNC=2147483644.5
FOR /f "tokens=1 delims=/." %a IN ('ECHO %ELAPSED_TIME_SINCE_LAST_SYNC:s=%') DO SET /A SECONDS_SINCE_LAST_SYNC=%a
FOR /f "tokens=2 delims=/." %a IN ('ECHO %ELAPSED_TIME_SINCE_LAST_SYNC:s=%') DO SET /A DECIMAL_SEC_SINCE_LAST_SYNC=%a
SET /A DAYS_TO_ADD=(((SECONDS_SINCE_LAST_SYNC/86400)%86400+86400)%86400)
SET /A HRS_TO_ADD=((((SECONDS_SINCE_LAST_SYNC/3600)%3600+3600)%3600)-(DAYS_TO_ADD*24))
SET /A MIN_TO_ADD=((((SECONDS_SINCE_LAST_SYNC/60)%60+60)%60)-(HRS_TO_ADD*60)-(DAYS_TO_ADD*1440))
SET /A SEC_TO_ADD=(SECONDS_SINCE_LAST_SYNC-(MIN_TO_ADD*60)-(HRS_TO_ADD*3600)-(DAYS_TO_ADD*86400))

SET /A NOW_SEC=(LAST_SYNC_SEC+SEC_TO_ADD)%60
SET /A MIN_TO_ADD=(MIN_TO_ADD+((((LAST_SYNC_SEC+SEC_TO_ADD)/60)%60+60)%60))
SET /A NOW_MIN=(LAST_SYNC_MIN+MIN_TO_ADD)%60
SET /A HRS_TO_ADD=(HRS_TO_ADD+((((LAST_SYNC_MIN+MIN_TO_ADD)/60)%60+60)%60))
SET /A NOW_HR=(LAST_SYNC_HOUR+HRS_TO_ADD)%24
SET /A DAYS_TO_ADD=(DAYS_TO_ADD+((((LAST_SYNC_HOUR+HRS_TO_ADD)/24)%24+24)%24))
SET /A NOW_DAY=(LAST_SYNC_DAY+DAYS_TO_ADD)
SET /A NOW_MONTH=LAST_SYNC_MONTH
SET /A NOW_YEAR=LAST_SYNC_YEAR

SET ECHO_YEAR=%NOW_YEAR%
SET ECHO_MONTH=0%NOW_MONTH%
SET ECHO_MONTH=%ECHO_MONTH:~-2%
SET ECHO_DAY=0%NOW_DAY%
SET ECHO_DAY=%ECHO_DAY:~-2%
SET ECHO_HOUR=0%NOW_HR%
SET ECHO_HOUR=%ECHO_HOUR:~-2%
SET ECHO_MIN=0%NOW_MIN%
SET ECHO_MIN=%ECHO_MIN:~-2%
SET ECHO_SEC=0%NOW_SEC%
SET ECHO_SEC=%ECHO_SEC:~-2%

SET NOW_TIMESTAMP=%ECHO_YEAR%-%ECHO_MONTH%-%ECHO_DAY%_%ECHO_HOUR%-%ECHO_MIN%-%ECHO_SEC%

ECHO ------------------------------------------------------------
ECHO LAST_SYNC_DATE = %LAST_SYNC_DATE%
ECHO LAST_SYNC_TIME = %LAST_SYNC_TIME%
ECHO LAST_SYNC_AM_PM = %LAST_SYNC_AM_PM%
ECHO LAST_SYNC_HRS_TO_ADD = %LAST_SYNC_HRS_TO_ADD%
ECHO LAST_SYNC_HOUR = %LAST_SYNC_HOUR%
ECHO LAST_SYNC_MIN = %LAST_SYNC_MIN%
ECHO LAST_SYNC_SEC = %LAST_SYNC_SEC%
ECHO ------------------------------------------------------------
ECHO ELAPSED_TIME_SINCE_LAST_SYNC = %ELAPSED_TIME_SINCE_LAST_SYNC%
ECHO SECONDS_SINCE_LAST_SYNC = %SECONDS_SINCE_LAST_SYNC%
ECHO DECIMAL_SEC_SINCE_LAST_SYNC = %DECIMAL_SEC_SINCE_LAST_SYNC%
ECHO DAYS_TO_ADD = %DAYS_TO_ADD%
ECHO HRS_TO_ADD = %HRS_TO_ADD%
ECHO MIN_TO_ADD = %NOW_MIN%
ECHO SEC_TO_ADD = %SEC_TO_ADD%
ECHO ------------------------------------------------------------
ECHO NOW_YEAR = %NOW_YEAR%
ECHO NOW_MONTH = %NOW_MONTH%
ECHO NOW_DAY = %NOW_DAY%
ECHO NOW_HR = %NOW_HR%
ECHO NOW_MIN = %NOW_MIN%
ECHO NOW_SEC = %NOW_SEC%
ECHO ------------------------------------------------------------
ECHO NOW_TIMESTAMP = %NOW_TIMESTAMP%
ECHO ------------------------------------------------------------


REM ------------------------------------------------------------
REM
REM CMD - Get Timestamp (the lazy/dirty/cheap way way)
REM 
FOR /F "tokens=* USEBACKQ" %%F IN (`DATE /T`) DO SET CURRENT_DATE=%%F
FOR /F "tokens=* USEBACKQ" %%F IN (`TIME /T`) DO SET CURRENT_TIME=%%F
FOR /F "tokens=* USEBACKQ" %%F IN (`DATE /T`) DO SET TIMESTAMP=%TIMESTAMP%%%F
FOR /F "tokens=* USEBACKQ" %%F IN (`TIME /T`) DO SET TIMESTAMP=%TIMESTAMP%%%F
ECHO.
ECHO	CURRENT_DATE = %CURRENT_DATE%
ECHO	CURRENT_TIME = %CURRENT_TIME%
ECHO.
ECHO	TIMESTAMP = %TIMESTAMP%
ECHO.


REM ------------------------------------------------------------
REM Citation(s)
REM 
REM   docs.microsoft.com  |  "find - Searches for a string of text in a file or files"  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/find
REM 
REM   docs.microsoft.com  |  "taskkill - Ends one or more tasks or processes"  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/taskkill
REM 
REM   docs.microsoft.com  |  "tasklist - Displays a list of currently running processes (local or remote computer)"  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/tasklist
REM 
REM   ss64.com  |  "LSS - is a 'Less Than' comparison operator for the IF command"  |  https://ss64.com/nt/lss.html
REM 
REM   ss64.com  |  "How-To: Edit/Replace text within a Variable"  |  https://ss64.com/nt/syntax-replace.html
REM 
REM   stackoverflow.com  |  "Multiplying Two Whole Numbers In Batch"  |  https://stackoverflow.com/a/20452873
REM 
REM   stackoverflow.com  |  "CMD set /a, modulus, and negative numbers"  |  https://stackoverflow.com/a/27894447
REM 
REM   stackoverflow.com  |  "How to create a unique temporary file path in command prompt without external tools? [duplicate]"  |  https://stackoverflow.com/a/32109191
REM 
REM   stackoverflow.com  |  "String processing in windows batch files: How to pad value with leading zeros?"  |  https://stackoverflow.com/a/13398719
REM 
REM ------------------------------------------------------------