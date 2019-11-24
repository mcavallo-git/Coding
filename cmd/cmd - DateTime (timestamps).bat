@ECHO OFF
EXIT
REM ------------------------------------------------------------
REM Get a Timestamp (Date & Time, based on w32tm)

SET /A SEC_PER_MIN=60
SET /A SEC_PER_HR=(SEC_PER_MIN*60)
SET /A SEC_PER_DAY=(SEC_PER_HR*24)
SET /A SEC_PER_MONTH=(SEC_PER_DAY*365/12)
SET /A SEC_PER_YEAR=(SEC_PER_DAY*365)

FOR /F "tokens=5 delims= " %a IN ('w32tm /query /status /verbose ^| find "Last Successful Sync Time:" ') DO SET LAST_SYNC_DATE=%a
SET LAST_SYNC_DATE=01/01/1970
FOR /f "tokens=3 delims=//" %a IN ('ECHO %LAST_SYNC_DATE%') DO SET /A LAST_SYNC_YEAR=%a
FOR /f "tokens=1 delims=//" %a IN ('ECHO %LAST_SYNC_DATE%') DO SET /A LAST_SYNC_MONTH=%a
FOR /f "tokens=2 delims=//" %a IN ('ECHO %LAST_SYNC_DATE%') DO SET /A LAST_SYNC_DAY=%a
FOR /F "tokens=6 delims= " %a IN ('w32tm /query /status /verbose ^| find "Last Successful Sync Time:" ') DO SET LAST_SYNC_TIME=%a
SET LAST_SYNC_TIME=00:00:00
FOR /f "tokens=1 delims=/:" %a IN ('ECHO %LAST_SYNC_TIME%') DO SET /A LAST_SYNC_HR=%a
FOR /f "tokens=2 delims=/:" %a IN ('ECHO %LAST_SYNC_TIME%') DO SET /A LAST_SYNC_MIN=%a
FOR /f "tokens=3 delims=/:" %a IN ('ECHO %LAST_SYNC_TIME%') DO SET /A LAST_SYNC_SEC=%a
FOR /F "tokens=7 delims= " %a IN ('w32tm /query /status /verbose ^| find "Last Successful Sync Time:" ') DO SET LAST_SYNC_AM_PM=%a
SET LAST_SYNC_PM_HRS=%LAST_SYNC_AM_PM:AM=0%
SET LAST_SYNC_PM_HRS=%LAST_SYNC_PM_HRS:PM=12%
SET /A LAST_SYNC_HR=(LAST_SYNC_HR+LAST_SYNC_PM_HRS)

FOR /F "tokens=7 delims= " %a IN ('w32tm /query /status /verbose ^| find "Time since Last Good Sync Time:" ') DO SET TIME_SINCE_LAST_SYNC=%a
SET TIME_SINCE_LAST_SYNC=2147483647.123456700s
REM SET TIME_SINCE_LAST_SYNC=157680000.440s
FOR /f "tokens=1 delims=/." %a IN ('ECHO %TIME_SINCE_LAST_SYNC:s=%') DO SET /A FULL_SECONDS_SINCE_LAST_SYNC=%a
FOR /f "tokens=2 delims=/." %a IN ('ECHO %TIME_SINCE_LAST_SYNC:s=%') DO SET /A DECIMAL_SEC_SINCE_LAST_SYNC=%a
SET /A REMAINDER_SECONDS=FULL_SECONDS_SINCE_LAST_SYNC
SET /A YEARS_SINCE_LAST_SYNC=(((REMAINDER_SECONDS/SEC_PER_YEAR)%SEC_PER_YEAR+SEC_PER_YEAR)%SEC_PER_YEAR)
SET /A REMAINDER_SECONDS=REMAINDER_SECONDS-(YEARS_SINCE_LAST_SYNC*SEC_PER_YEAR)
SET /A MONTHS_SINCE_LAST_SYNC=(((REMAINDER_SECONDS/SEC_PER_MONTH)%SEC_PER_MONTH+SEC_PER_MONTH)%SEC_PER_MONTH)
SET /A REMAINDER_SECONDS=REMAINDER_SECONDS-(MONTHS_SINCE_LAST_SYNC*SEC_PER_MONTH)
SET /A DAYS_SINCE_LAST_SYNC=(((REMAINDER_SECONDS/SEC_PER_DAY)%SEC_PER_DAY+SEC_PER_DAY)%SEC_PER_DAY)
SET /A REMAINDER_SECONDS=REMAINDER_SECONDS-(DAYS_SINCE_LAST_SYNC*SEC_PER_DAY)
SET /A HRS_SINCE_LAST_SYNC=(((REMAINDER_SECONDS/SEC_PER_HR)%SEC_PER_HR+SEC_PER_HR)%SEC_PER_HR)
SET /A REMAINDER_SECONDS=REMAINDER_SECONDS-(HRS_SINCE_LAST_SYNC*SEC_PER_HR)
SET /A MIN_SINCE_LAST_SYNC=(((REMAINDER_SECONDS/SEC_PER_MIN)%SEC_PER_MIN+SEC_PER_MIN)%SEC_PER_MIN)
SET /A REMAINDER_SECONDS=REMAINDER_SECONDS-(MIN_SINCE_LAST_SYNC*SEC_PER_MIN)
SET /A SEC_SINCE_LAST_SYNC=REMAINDER_SECONDS

SET /A SEC_TO_ADD=SEC_SINCE_LAST_SYNC
SET /A NOW_SEC=(LAST_SYNC_SEC+SEC_TO_ADD)%60
SET /A MIN_TO_ADD=(MIN_SINCE_LAST_SYNC+((((LAST_SYNC_SEC+SEC_TO_ADD)/60)%60+60)%60))
SET /A NOW_MIN=(LAST_SYNC_MIN+MIN_TO_ADD)%60
SET /A HRS_TO_ADD=(HRS_SINCE_LAST_SYNC+((((LAST_SYNC_MIN+MIN_TO_ADD)/60)%60+60)%60))
SET /A NOW_HR=(LAST_SYNC_HR+HRS_TO_ADD)%24
SET /A DAYS_TO_ADD=(DAYS_SINCE_LAST_SYNC+((((LAST_SYNC_HR+HRS_TO_ADD)/24)%24+24)%24))
SET /A NOW_DAY=(LAST_SYNC_DAY+DAYS_TO_ADD)%31
SET /A MONTHS_TO_ADD=(MONTHS_SINCE_LAST_SYNC+((((LAST_SYNC_DAY+DAYS_TO_ADD)/31)%31+31)%31))
SET /A NOW_MONTH=(LAST_SYNC_MONTH+MONTHS_TO_ADD)%12
SET /A YEARS_TO_ADD=(YEARS_SINCE_LAST_SYNC+((((LAST_SYNC_MONTH+MONTHS_TO_ADD)/12)%12+12)%12))
SET /A NOW_YEAR=(LAST_SYNC_YEAR+YEARS_TO_ADD)
SET NOW_RAND=%RANDOM%

SET ECHO_YEAR=%NOW_YEAR%
SET ECHO_MONTH=0%NOW_MONTH%
SET ECHO_MONTH=%ECHO_MONTH:~-2%
SET ECHO_DAY=0%NOW_DAY%
SET ECHO_DAY=%ECHO_DAY:~-2%
SET ECHO_HR=0%NOW_HR%
SET ECHO_HR=%ECHO_HR:~-2%
SET ECHO_MIN=0%NOW_MIN%
SET ECHO_MIN=%ECHO_MIN:~-2%
SET ECHO_SEC=0%NOW_SEC%
SET ECHO_SEC=%ECHO_SEC:~-2%

SET ECHO_TIMESTAMP=%ECHO_YEAR%-%ECHO_MONTH%-%ECHO_DAY%_%ECHO_HR%-%ECHO_MIN%-%ECHO_SEC%

SET TEMPFILE_TIMESTAMP=%TMP%\bat_%ECHO_TIMESTAMP%-%NOW_RAND%.tmp

ECHO ------------------------------------------------------------
ECHO LAST_SYNC_DATE = %LAST_SYNC_DATE%
ECHO LAST_SYNC_TIME = %LAST_SYNC_TIME%
ECHO TIME_SINCE_LAST_SYNC = %TIME_SINCE_LAST_SYNC%
ECHO FULL_SECONDS_SINCE_LAST_SYNC = %FULL_SECONDS_SINCE_LAST_SYNC%
ECHO DECIMAL_SEC_SINCE_LAST_SYNC = %DECIMAL_SEC_SINCE_LAST_SYNC%
ECHO ------------------------------------------------------------
ECHO LAST_SYNC_YEAR = %LAST_SYNC_YEAR%
ECHO YEARS_TO_ADD = %YEARS_TO_ADD%
ECHO NOW_YEAR = %NOW_YEAR%
ECHO ECHO_YEAR = %ECHO_YEAR%
ECHO ------------------------------------------------------------
ECHO LAST_SYNC_MONTH = %LAST_SYNC_MONTH%
ECHO MONTHS_TO_ADD = %MONTHS_TO_ADD%
ECHO NOW_MONTH = %NOW_MONTH%
ECHO ECHO_MONTH = %ECHO_MONTH%
ECHO ------------------------------------------------------------
ECHO LAST_SYNC_DAY = %LAST_SYNC_DAY%
ECHO DAYS_TO_ADD = %DAYS_TO_ADD%
ECHO NOW_DAY = %NOW_DAY%
ECHO ECHO_DAY = %ECHO_DAY%
ECHO ------------------------------------------------------------
ECHO LAST_SYNC_HR = %LAST_SYNC_HR%
ECHO LAST_SYNC_AM_PM = %LAST_SYNC_AM_PM%
ECHO LAST_SYNC_PM_HRS = %LAST_SYNC_PM_HRS%
ECHO HRS_TO_ADD = %HRS_TO_ADD%
ECHO NOW_HR = %NOW_HR%
ECHO ECHO_HR = %ECHO_HR%
ECHO ------------------------------------------------------------
ECHO LAST_SYNC_MIN = %LAST_SYNC_MIN%
ECHO MIN_SINCE_LAST_SYNC = %MIN_SINCE_LAST_SYNC%
ECHO MIN_TO_ADD = %MIN_TO_ADD%
ECHO NOW_MIN = %NOW_MIN%
ECHO ECHO_MIN = %ECHO_MIN%
ECHO ------------------------------------------------------------
ECHO LAST_SYNC_SEC = %LAST_SYNC_SEC%
ECHO SEC_TO_ADD = %SEC_TO_ADD%
ECHO NOW_SEC = %NOW_SEC%
ECHO ECHO_SEC = %ECHO_SEC%
ECHO ------------------------------------------------------------
ECHO NOW_RAND = %NOW_RAND%
ECHO ------------------------------------------------------------
ECHO ECHO_TIMESTAMP = %ECHO_TIMESTAMP%
ECHO TEMPFILE_TIMESTAMP = %TEMPFILE_TIMESTAMP%
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