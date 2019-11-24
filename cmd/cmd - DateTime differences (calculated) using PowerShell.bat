@ECHO OFF

REM BAT
FOR /f "delims=" %%G IN ('PowerShell "(Get-Date -UFormat %%Y%%m%%d%%H%%M%%S%%Z);"') DO @ECHO %%G

REM CMD
REM    FOR /f "delims=" %G IN ('PowerShell "(Get-Date -UFormat %Y%m%d%H%M%S%Z);"') DO @ECHO %G

SET HoursElapsed=8.5

REM Note: Uses PowerShell's Get-Date (See citations, below for docs)

REM Get the Current Day-of-Week (Monday, Tuesday, etc.)
FOR /f "delims=" %%G IN ('PowerShell "(Get-Date %time% -UFormat %%A);"') DO SET DayOfWeek_Current=%%G
REM Get the Current Time
FOR /f "delims=" %%G IN ('PowerShell "(Get-Date %time% -UFormat %%I:%%M:%%S);"') DO SET DateTime_Current=%%G
FOR /f "delims=" %%G IN ('PowerShell "(Get-Date %time% -UFormat %%p);"') DO SET AM_PM_Current=%%G

REM Get the Day-of-Week after (%HoursElapsed%) Hours have elapsed
FOR /f "delims=" %%G IN ('PowerShell "((Get-Date %time%).AddHours(%HoursElapsed%) | Get-Date -UFormat %%A);"') DO SET DayOfWeek_Elapsed=%%G
REM Get the Time after (%HoursElapsed%) Hours have elapsed
FOR /f "delims=" %%G IN ('PowerShell "((Get-Date %time%).AddHours(%HoursElapsed%) | Get-Date -UFormat %%I:%%M:%%S);"') DO SET DateTime_Elapsed=%%G
FOR /f "delims=" %%G IN ('PowerShell "((Get-Date %time%).AddHours(%HoursElapsed%) | Get-Date -UFormat %%p);"') DO SET AM_PM_Elapsed=%%G

ECHO.
ECHO   Datetime currently is:   %DayOfWeek_Current% @ %DateTime_Current% %AM_PM_Current%
ECHO   Datetime after [ %HoursElapsed% ] hours have elapsed:   %DayOfWeek_Elapsed% @ %DateTime_Elapsed% %AM_PM_Elapsed%
ECHO.

REM Debugging Timeout (to view output while testing)
TIMEOUT /T 30

EXIT

REM Citation(s)
REM		Get-Date  :::  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date?view=powershell-6
