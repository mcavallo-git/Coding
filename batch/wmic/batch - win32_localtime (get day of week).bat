@ECHO OFF

REM Get the Name of the Day of the Week (Monday, Tuesday, etc.)
FOR /f "tokens=*" %%f IN ('wmic path win32_localtime get dayofweek /value ^| find "="') DO SET "%%f"
IF %dayofweek% EQU 0 (SET day_of_week=Sunday)
IF %dayofweek% EQU 1 (SET day_of_week=Monday)
IF %dayofweek% EQU 2 (SET day_of_week=Tuesday)
IF %dayofweek% EQU 3 (SET day_of_week=Wednesday)
IF %dayofweek% EQU 4 (SET day_of_week=Thursday)
IF %dayofweek% EQU 5 (SET day_of_week=Friday)
IF %dayofweek% EQU 6 (SET day_of_week=Saturday)
IF %dayofweek% EQU 7 (SET day_of_week=Sunday)

ECHO.
ECHO    Today is %day_of_week%
ECHO.

TIMEOUT -T 30
EXIT
