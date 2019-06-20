@ECHO OFF

SET STARTUP_SCRIPTS=%USERPROFILE%\.startup-scripts\startup-%COMPUTERNAME%
SET STARTUP_SCRIPTS_BAT=%STARTUP_SCRIPTS%.bat
SET STARTUP_SCRIPTS_LNK=%STARTUP_SCRIPTS%.lnk

SET "INVIS_SKIPWAIT_VBS=%TEMP%\invis_nowait.vbs"
IF NOT EXIST "%INVIS_SKIPWAIT_VBS%" (
ECHO CreateObject("Wscript.Shell").Run """" ^& WScript.Arguments(0) ^& """", 0, FALSE> "%INVIS_SKIPWAIT_VBS%"
)

IF EXIST "%STARTUP_SCRIPTS_BAT%" (
wscript.exe "%INVIS_SKIPWAIT_VBS%" "%STARTUP_SCRIPTS_BAT%"
)

IF EXIST "%STARTUP_SCRIPTS_LNK%" (
wscript.exe "%INVIS_SKIPWAIT_VBS%" "%STARTUP_SCRIPTS_LNK%"
)

EXIT

REM	------------------------------------------------------------
REM	Revisioning | 2018-11-28 | Created
REM	Revisioning | 2018-12-12 | Generalized parameters
REM	Revisioning | 2019-06-19 | Format "~\.startup-scripts\..."
REM	------------------------------------------------------------
REM	Author | Matt Cavallo | https://github.com/mcavallo-git
REM	------------------------------------------------------------
