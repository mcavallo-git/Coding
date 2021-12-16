REM ------------------------------------------------------------
REM
REM	cmd - IF, ELSE (conditionals in batch files)
REM
REM ------------------------------------------------------------


REM
REM General syntax
REM

If condition (do_something) ELSE (do_something_else)

If NOT condition (do_something) ELSE (do_something_else)


REM ------------------------------------------------------------
REM
REM	Example(s)
REM


REM Example - IF EQUAL
If 1==1 (ECHO 1) ELSE (ECHO 0)
1   REM Value output by command


REM Example - IF EQUAL
If 0==1 (ECHO 1) ELSE (ECHO 0)
0   REM Value output by command


REM Example - IF NOT EQUAL
IF NOT 1==1 ( ECHO 1 ) ELSE ( ECHO 0 )
0   REM Value output by command


REM Example - IF NOT EQUAL
IF NOT 0==1 ( ECHO 1 ) ELSE ( ECHO 0 )
1   REM Value output by command


REM Example - IF EQUAL + BLOCKS OF CODE WITHIN CONDITIONAL ACTIONS
IF 0==1 (

ECHO 1
ECHO 2
ECHO 3

) ELSE (

ECHO -1
ECHO -2
ECHO -3

)


REM ------------------------------------------------------------
REM
REM Use Case (Conditionals)  -  Create directory (if it doesn't already exist)
REM

SET "DIRNAME=C:\temp\"
IF NOT EXIST "%DIRNAME%" MKDIR "%DIRNAME%"


REM ------------------------------------------------------------
REM
REM Use Case (Conditionals)  -  Get the current timestamp in a format with a static character length
REM

SET hour=%time:~0,2%
REM  \*/*\   Datetime with underscores (no spaces, for filenames etc.)
SET dt_underscores_1d_hour=%date:~0,4%-%date:~5,2%-%date:~8,2%_0%time:~1,1%-%time:~3,2%-%time:~6,2% 
SET dt_underscores_2d_hour=%date:~0,4%-%date:~5,2%-%date:~8,2%_%time:~0,2%-%time:~3,2%-%time:~6,2%
if "%hour:~0,1%" == " " (SET dt_spaces=%dt_underscores_1d_hour%) else (SET dt_spaces=%dt_underscores_2d_hour%)
REM  \*/*\   Datetime with spaces, for cleaner viewing
SET dt_spaces_1d_hour=%date:~0,4%-%date:~5,2%-%date:~8,2%T0%time:~1,1%:%time:~3,2%:%time:~6,2% 
SET dt_spaces_2d_hour=%date:~0,4%-%date:~5,2%-%date:~8,2%T%time:~0,2%:%time:~3,2%:%time:~6,2%
if "%hour:~0,1%" == " " (SET dt_spaces=%dt_spaces_1d_hour%) else (SET dt_spaces=%dt_spaces_2d_hour%)
ECHO [%dt_spaces%] CURRENT COMMAND RUNNING ON PC [%hostname%] AS USER [%username%]

ECHO hour = [ %hour% ]
ECHO dt_underscores_1d_hour = [ %dt_underscores_1d_hour% ]
ECHO dt_underscores_2d_hour = [ %dt_underscores_2d_hour% ]
ECHO dt_spaces_1d_hour = [ %dt_spaces_1d_hour% ]
ECHO dt_spaces_2d_hour = [ %dt_spaces_2d_hour% ]


REM ------------------------------------------------------------
REM
REM Check if file contents are equal to a specific value
REM

FOR /F "tokens=* USEBACKQ" %a IN (
  `TYPE prtg-sensors.txt`
) DO (
  SET Current_Value=%a
)


REM ------------------------------------------------------------
REM
REM Use Case (Conditionals)  -  Set a registry key property (if not already set as-intended)
REM

@ECHO OFF
ECHO.
ECHO.
REM HKCU\Control Panel\Desktop > AutoEndTasks > Setting to "1" disables the 'This App is Preventing Shutdown or Restart' screen on reboot-shutdown)
SET KeyName=HKCU\Control Panel\Desktop
SET ValueName=AutoEndTasks
SET DataType=REG_SZ
SET Set_Value=1
SET Current_Value=VALUE_IS_UNDEFINED
REM ------------------
REM Note: Use  [ %%a ] if running from within a batch script
REM Note: Use  [  %a ] if running directly in a CMD terminal
FOR /F "tokens=3 USEBACKQ" %a IN (
  `REG QUERY "%KeyName%" /v "%ValueName%" /t "%DataType%" ^| findstr "%ValueName%" ^| findstr "%DataType%"`
) DO (
  SET Current_Value=%a
)
ECHO Set_Value = [ %Set_Value% ]
ECHO Current_Value = [ %Current_Value% ]
IF NOT %Current_Value%==%Set_Value% ( REG ADD "%KeyName%" /v "%ValueName%" /t "%DataType%" /d "%Set_Value%" /f )
REG QUERY "%KeyName%" /v "%ValueName%"
ECHO.
@ECHO ON


REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   ss64.com  |  "For - Loop through command output - Windows CMD - SS64.com"  |  https://ss64.com/nt/for_cmd.html
REM
REM   ss64.com  |  "Setlocal - Local variables - Windows CMD - SS64.com"  |  https://ss64.com/nt/setlocal.html
REM
REM   www.tutorialspoint.com  |  "Batch Script - If/else Statement"  |  https://www.tutorialspoint.com/batch_script/batch_script_if_else_statement.htm
REM
REM ------------------------------------------------------------