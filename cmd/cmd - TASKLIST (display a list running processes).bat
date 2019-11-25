@ECHO OFF
EXIT
REM https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/tasklist
REM ------------------------------------------------------------
REM 
REM TASKLIST  |Displays a list of currently running processes on the local computer or on a remote computer. Tasklist replaces the tlist tool.
REM   /V     |Displays verbose task information in the output. For complete verbose output without truncation, use /v and /svc together.
REM   /FI    |Specifies the types of processes to include in or exclude from the query. See the following table for valid filter names, operators, and values.
REM   /NH    |Specifies that the "Column Header" should not be displayed in the output.
REM 


REM Get PIDs, only
FOR /F "tokens=2-2" %a IN ('TASKLIST /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%"') DO @ECHO %a


REM Get PIDs & Image (Process) Names
FOR /F "tokens=1-2" %a IN ('TASKLIST /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%"') DO @ECHO %b  %a


REM Exact-Match based on Image (Process) Name
TASKLIST /V /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%" /FI "IMAGENAME eq explorer.exe"


REM Near-Match based on Image (Process) Name
TASKLIST /V /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%" | FIND /I "explorer"


REM ------------------------------------------------------------

REM SETLOCAL ENABLEEXTENSIONS
REM :UNIQUELOOP
REM FOR /f "tokens=2-4 delims=/ " %a IN ('DATE /T') DO (SET NOW_DATE=%c-%a-%b)
REM FOR /f "tokens=1-2 delims=/:" %a IN ('TIME /T') DO (SET NOW_TIME=%a%b)
REM SET NOW_RAND=%RANDOM%
REM SET "TEMP_FILENAME=%TMP%\bat~%NOW_DATE%_%NOW_TIME%_%RANDOM%.tmp"
REM REM IF EXIST "%TEMP_FILENAME%" GOTO :UNIQUELOOP
REM ECHO NOW_DATE = %NOW_DATE%
REM ECHO NOW_TIME = %NOW_TIME%
REM ECHO NOW_RAND = %NOW_RAND%
REM ECHO TEMP_FILENAME = %TEMP_FILENAME%

REM ------------------------------------------------------------
REM Get a Timestamp (Date & Time, based on w32tm)

SET /A SEC_PER_MIN=60
SET /A SEC_PER_HR=(SEC_PER_MIN*60)
SET /A SEC_PER_DAY=(SEC_PER_HR*24)
SET /A SEC_PER_MONTH=(SEC_PER_DAY*365/12)
SET /A SEC_PER_YEAR=(SEC_PER_DAY*365)

FOR /F "tokens=5 delims= " %a IN ('w32tm /query /status /verbose ^| find "Last Successful Sync Time:" ') DO SET LAST_SYNC_DATE=%a
REM SET LAST_SYNC_DATE=01/01/1970
FOR /f "tokens=3 delims=//" %a IN ('ECHO %LAST_SYNC_DATE%') DO SET /A LAST_SYNC_YEAR=%a
FOR /f "tokens=1 delims=//" %a IN ('ECHO %LAST_SYNC_DATE%') DO SET /A LAST_SYNC_MONTH=%a
FOR /f "tokens=2 delims=//" %a IN ('ECHO %LAST_SYNC_DATE%') DO SET /A LAST_SYNC_DAY=%a
FOR /F "tokens=6 delims= " %a IN ('w32tm /query /status /verbose ^| find "Last Successful Sync Time:" ') DO SET LAST_SYNC_TIME=%a
REM SET LAST_SYNC_TIME=00:00:00
FOR /f "tokens=1 delims=/:" %a IN ('ECHO %LAST_SYNC_TIME%') DO SET /A LAST_SYNC_HR=%a
FOR /f "tokens=2 delims=/:" %a IN ('ECHO %LAST_SYNC_TIME%') DO SET /A LAST_SYNC_MIN=%a
FOR /f "tokens=3 delims=/:" %a IN ('ECHO %LAST_SYNC_TIME%') DO SET /A LAST_SYNC_SEC=%a
FOR /F "tokens=7 delims= " %a IN ('w32tm /query /status /verbose ^| find "Last Successful Sync Time:" ') DO SET LAST_SYNC_AM_PM=%a
SET LAST_SYNC_PM_HRS=%LAST_SYNC_AM_PM:AM=0%
SET LAST_SYNC_PM_HRS=%LAST_SYNC_PM_HRS:PM=12%
SET /A LAST_SYNC_HR=(LAST_SYNC_HR+LAST_SYNC_PM_HRS)

FOR /F "tokens=7 delims= " %a IN ('w32tm /query /status /verbose ^| find "Time since Last Good Sync Time:" ') DO SET TIME_SINCE_LAST_SYNC=%a
REM SET TIME_SINCE_LAST_SYNC=2147483647.123456700s
REM SET TIME_SINCE_LAST_SYNC=157680000.440s
FOR /f "tokens=1 delims=/." %a IN ('ECHO %TIME_SINCE_LAST_SYNC:s=%') DO SET /A FULL_SECONDS_SINCE_LAST_SYNC=%a
FOR /f "tokens=2 delims=/." %a IN ('ECHO %TIME_SINCE_LAST_SYNC:s=%') DO SET /A DECIMAL_SEC_SINCE_LAST_SYNC=%a
SET /A SEC_SINCE_LAST_SYNC=FULL_SECONDS_SINCE_LAST_SYNC
SET /A YEARS_SINCE_LAST_SYNC=(((SEC_SINCE_LAST_SYNC/SEC_PER_YEAR)%SEC_PER_YEAR+SEC_PER_YEAR)%SEC_PER_YEAR)
SET /A SEC_SINCE_LAST_SYNC=SEC_SINCE_LAST_SYNC-(YEARS_SINCE_LAST_SYNC*SEC_PER_YEAR)
SET /A MONTHS_SINCE_LAST_SYNC=(((SEC_SINCE_LAST_SYNC/SEC_PER_MONTH)%SEC_PER_MONTH+SEC_PER_MONTH)%SEC_PER_MONTH)
SET /A SEC_SINCE_LAST_SYNC=SEC_SINCE_LAST_SYNC-(MONTHS_SINCE_LAST_SYNC*SEC_PER_MONTH)
SET /A DAYS_SINCE_LAST_SYNC=(((SEC_SINCE_LAST_SYNC/SEC_PER_DAY)%SEC_PER_DAY+SEC_PER_DAY)%SEC_PER_DAY)
SET /A SEC_SINCE_LAST_SYNC=SEC_SINCE_LAST_SYNC-(DAYS_SINCE_LAST_SYNC*SEC_PER_DAY)
SET /A HRS_SINCE_LAST_SYNC=(((SEC_SINCE_LAST_SYNC/SEC_PER_HR)%SEC_PER_HR+SEC_PER_HR)%SEC_PER_HR)
SET /A SEC_SINCE_LAST_SYNC=SEC_SINCE_LAST_SYNC-(HRS_SINCE_LAST_SYNC*SEC_PER_HR)
SET /A MIN_SINCE_LAST_SYNC=(((SEC_SINCE_LAST_SYNC/SEC_PER_MIN)%SEC_PER_MIN+SEC_PER_MIN)%SEC_PER_MIN)
SET /A SEC_SINCE_LAST_SYNC=SEC_SINCE_LAST_SYNC-(MIN_SINCE_LAST_SYNC*SEC_PER_MIN)

SET /A NOW_NANOSEC=DECIMAL_SEC_SINCE_LAST_SYNC
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
SET ECHO_MONTH=00%NOW_MONTH%
SET ECHO_MONTH=%ECHO_MONTH:~-2%
SET ECHO_DAY=00%NOW_DAY%
SET ECHO_DAY=%ECHO_DAY:~-2%
SET ECHO_HR=00%NOW_HR%
SET ECHO_HR=%ECHO_HR:~-2%
SET ECHO_MIN=00%NOW_MIN%
SET ECHO_MIN=%ECHO_MIN:~-2%
SET ECHO_SEC=00%NOW_SEC%
SET ECHO_SEC=%ECHO_SEC:~-2%
SET ECHO_NANOSEC=%NOW_NANOSEC%000000000
SET ECHO_NANOSEC=%ECHO_NANOSEC:~0,9%
SET ECHO_MICROSEC=%ECHO_NANOSEC:~0,6%
SET ECHO_MILLISEC=%ECHO_NANOSEC:~0,3%

ECHO EXAMPLE = [ %EXAMPLE% ],  DAT_RIGHT_CHARSET = [ %DAT_RIGHT_CHARSET% ]

SET ECHO_TIMESTAMP=%ECHO_YEAR%-%ECHO_MONTH%-%ECHO_DAY%_%ECHO_HR%-%ECHO_MIN%-%ECHO_SEC%.%ECHO_MICROSEC%

SET TEMPFILE_TIMESTAMP=%TMP%\bat_%ECHO_TIMESTAMP%.tmp

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
ECHO SEC_SINCE_LAST_SYNC = %SEC_SINCE_LAST_SYNC%
ECHO SEC_TO_ADD = %SEC_TO_ADD%
ECHO NOW_SEC = %NOW_SEC%
ECHO ECHO_SEC = %ECHO_SEC%
ECHO ------------------------------------------------------------
ECHO ECHO_NANOSEC  = %ECHO_NANOSEC%
ECHO ECHO_MICROSEC = %ECHO_MICROSEC%
ECHO ECHO_MILLISEC = %ECHO_MILLISEC%
ECHO ------------------------------------------------------------
ECHO NOW_RAND = %NOW_RAND%
ECHO ------------------------------------------------------------
ECHO ECHO_TIMESTAMP = %ECHO_TIMESTAMP%
ECHO TEMPFILE_TIMESTAMP = %TEMPFILE_TIMESTAMP%
ECHO ------------------------------------------------------------



FOR /F "tokens=1-2" %a IN ('TASKLIST /NH') DO @ECHO %a | FIND /I "vm" && ECHO %b >> %TEMPFILE_TIMESTAMP%
FOR /F %a IN (%TEMPFILE_TIMESTAMP%) DO TASKKILL /F /PID %a
TIMEOUT /T 10
Notepad %TEMPFILE_TIMESTAMP%


REM ------------------------------------------------------------
REM
REM Tasklist, Verbose (9-column)
REM  |  Image Name  |  PID  |  Session Name  |  Session#  |  Mem Usage  |  Status  |  User Name  |  CPU Time  |  Window Title  |
REM  |  %a          |  %b   |  %c            |  %d        |  %e         |  %f      |  %g         |  %h        |  %i            |
REM
FOR /F "tokens=1-9" %a IN ('TASKLIST /V /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%"') DO @ECHO Image Name=[%a], PID=[%b], Session Name=[%c], Session#=[%d], Mem Usage=[%e], User Name=[%f], Status=[%g], CPU Time=[%h], Window Title=[%i]


REM ------------------------------------------------------------
REM
REM Tasklist, Non-Verbose (5-column)
REM  |  Image Name  |  PID  |  Session Name  |  Session#  |  Mem Usage  |
REM  |  %a          |  %b   |  %c            |  %d        |  %e         |
REM
FOR /F "tokens=1-5" %a IN ('TASKLIST /NH /FI "USERNAME eq %USERDOMAIN%\%USERNAME%"') DO @ECHO %a  -  %b  -  %c  -  %d  -  %e


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