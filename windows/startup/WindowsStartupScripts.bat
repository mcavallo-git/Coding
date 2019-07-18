@ECHO OFF

SET STARTUP_SCRIPTS=%USERPROFILE%\.startup-scripts

SET RUNFILE_EXTENSIONLESS=%STARTUP_SCRIPTS%\startup-%COMPUTERNAME%

SET RUNFILE_AS_BATCHFILE=%RUNFILE_EXTENSIONLESS%.bat

SET RUNFILE_AS_SHORTCUT=%RUNFILE_EXTENSIONLESS%.lnk

SET INVIS_NO_WAIT_VBS=%USERPROFILE%\.startup-scripts\invis_nowait.vbs
ECHO CreateObject("Wscript.Shell").Run """" ^& WScript.Arguments(0) ^& """", 0, FALSE> "%INVIS_NO_WAIT_VBS%"

IF EXIST "%RUNFILE_AS_BATCHFILE%" (
wscript.exe "%INVIS_NO_WAIT_VBS%" "%RUNFILE_AS_BATCHFILE%"
)

IF EXIST "%RUNFILE_AS_SHORTCUT%" (
wscript.exe "%INVIS_NO_WAIT_VBS%" "%RUNFILE_AS_SHORTCUT%"
)

EXIT

REM	------------------------------------------------------------
REM	Updated | 2019-06-19 | Use format "~\.startup-scripts\..."
REM	Updated | 2018-12-12 | Generalized parameters
REM	Created | 2018-11-28 | Created
REM	------------------------------------------------------------
REM	Author | Matt Cavallo | https://github.com/mcavallo-git
REM	------------------------------------------------------------
