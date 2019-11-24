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



REM Get Last Sync-Time from WMMIC
FOR /F "tokens=5 delims= " %a IN ('w32tm /query /status /verbose ^| find "Last Successful Sync Time:" ') DO SET LAST_SYNC_DATE=%a
FOR /f "tokens=3 delims=//" %a IN ('ECHO %LAST_SYNC_DATE%') DO SET /A LAST_SYNC_YEAR=%a
FOR /f "tokens=2 delims=//" %a IN ('ECHO %LAST_SYNC_DATE%') DO SET /A LAST_SYNC_MONTH=%a
FOR /f "tokens=1 delims=//" %a IN ('ECHO %LAST_SYNC_DATE%') DO SET /A LAST_SYNC_DAY=%a
FOR /F "tokens=6 delims= " %a IN ('w32tm /query /status /verbose ^| find "Last Successful Sync Time:" ') DO SET LAST_SYNC_TIME=%a
FOR /f "tokens=1 delims=/:" %a IN ('ECHO %LAST_SYNC_TIME%') DO SET /A LAST_SYNC_HOUR=%a
FOR /f "tokens=2 delims=/:" %a IN ('ECHO %LAST_SYNC_TIME%') DO SET /A LAST_SYNC_MIN=%a
FOR /f "tokens=3 delims=/:" %a IN ('ECHO %LAST_SYNC_TIME%') DO SET /A LAST_SYNC_SEC=%a
FOR /F "tokens=7 delims= " %a IN ('w32tm /query /status /verbose ^| find "Last Successful Sync Time:" ') DO SET LAST_SYNC_AM_PM=%a
IF %LAST_SYNC_AM_PM%==PM SET /A LAST_SYNC_HOUR=%LAST_SYNC_HOUR%+12
ECHO LAST_SYNC_YEAR = %LAST_SYNC_YEAR%
ECHO LAST_SYNC_MONTH = %LAST_SYNC_MONTH%
ECHO LAST_SYNC_DAY = %LAST_SYNC_DAY%
ECHO LAST_SYNC_HOUR = %LAST_SYNC_HOUR%
ECHO LAST_SYNC_MIN = %LAST_SYNC_MIN%
ECHO LAST_SYNC_SEC = %LAST_SYNC_SEC%


FOR /F "tokens=7 delims= " %a IN ('w32tm /query /status /verbose ^| find "Time since Last Good Sync Time:" ') DO SET ELAPSED_TIME_SINCE_LAST_SYNC=%a
FOR /f "tokens=1 delims=/." %a IN ('ECHO %ELAPSED_TIME_SINCE_LAST_SYNC:s=%') DO SET /A SECONDS_SINCE_LAST_SYNC=%a
FOR /f "tokens=2 delims=/." %a IN ('ECHO %ELAPSED_TIME_SINCE_LAST_SYNC:s=%') DO SET /A DECIMAL_SEC_SINCE_LAST_SYNC=%a
SET /A HRS_TO_ADD=(((SECONDS_SINCE_LAST_SYNC/3600)%3600+3600)%3600)
SET /A MIN_TO_ADD=((((SECONDS_SINCE_LAST_SYNC/60)%60+60)%60)-(HRS_TO_ADD*60))
SET /A SEC_TO_ADD=(SECONDS_SINCE_LAST_SYNC-(MIN_TO_ADD*60)-(HRS_TO_ADD*3600))

SET /A NOW_SEC=(LAST_SYNC_SEC+SEC_TO_ADD)%60
SET /A MIN_TO_ADD=(MIN_TO_ADD+((((LAST_SYNC_SEC+SEC_TO_ADD)/60)%60+60)%60))
SET /A NOW_MIN=(LAST_SYNC_MIN+MIN_TO_ADD)%60
SET /A HRS_TO_ADD=(HRS_TO_ADD+((((LAST_SYNC_MIN+MIN_TO_ADD)/60)%60+60)%60))
SET /A NOW_HR=(LAST_SYNC_HOUR+HRS_TO_ADD)


SET NOW_TIMESTAMP=%NOW_HR%_%NOW_HR%_%NOW_HR%


ECHO ------------------------------------------------------------
ECHO LAST_SYNC_TIME = %LAST_SYNC_TIME%
ECHO LAST_SYNC_HOUR = %LAST_SYNC_HOUR%
ECHO LAST_SYNC_MIN = %LAST_SYNC_MIN%
ECHO LAST_SYNC_SEC = %LAST_SYNC_SEC%
ECHO ------------------------------------------------------------
ECHO ELAPSED_TIME_SINCE_LAST_SYNC = %ELAPSED_TIME_SINCE_LAST_SYNC%
ECHO SECONDS_SINCE_LAST_SYNC = %SECONDS_SINCE_LAST_SYNC%
ECHO DECIMAL_SEC_SINCE_LAST_SYNC = %DECIMAL_SEC_SINCE_LAST_SYNC%
ECHO HRS_TO_ADD = %HRS_TO_ADD%
ECHO MIN_TO_ADD = %NOW_MIN%
ECHO SEC_TO_ADD = %SEC_TO_ADD%
ECHO ------------------------------------------------------------
ECHO NOW_HR = %NOW_HR%
ECHO NOW_MIN = %NOW_MIN%
ECHO NOW_SEC = %NOW_SEC%
ECHO ------------------------------------------------------------

ECHO NOW = %LAST_SYNC_HOUR%:%LAST_SYNC_MIN%:%LAST_SYNC_SEC%

SET /A TESTER=(70/60)
ECHO TESTER = %TESTER%



REM ------------------------------------------------------------
REM 
REM cmd - substring replacement, string vars, variables
REM 
REM @SET EXAMPLE=~~~ Hello World ~~~
REM @ECHO EXAMPLE (Before) = [ %EXAMPLE% ]
REM @SET EXAMPLE=%EXAMPLE:Hello =%
REM @ECHO EXAMPLE (After) = [ %EXAMPLE% ]
REM 
REM ------------------------------------------------------------



FOR /f "tokens=2-4 delims=/ " %a IN ('DATE /T') DO (SET NOW_DATE=%c-%a-%b)
FOR /f "tokens=1-2 delims=/:" %a IN ('TIME /T') DO (SET NOW_TIME=%a-%b)
FOR /f "tokens=1-1 " %a IN ('ECHO %NOW_TIME%') DO (SET NOW_TIME=%a)
SET NOW_RAND=%RANDOM%
SET "TEMP_FILENAME=%TMP%\bat_%NOW_DATE%_%NOW_TIME%.rand-%NOW_RAND%.tmp"
ECHO NOW_DATE = %NOW_DATE%
ECHO NOW_TIME = %NOW_TIME%
ECHO NOW_RAND = %NOW_RAND%
ECHO TEMP_FILENAME = %TEMP_FILENAME%


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
REM ------------------------------------------------------------