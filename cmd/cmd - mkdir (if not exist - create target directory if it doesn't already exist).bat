

REM Create directory (if it doesn't already exist)
SET "tempdrive=C:\temp\"
IF NOT EXIST "%tempdrive%" (
	MKDIR "%tempdrive%"
)


REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   stackoverflow.com  |  "windows - Create folder with batch but only if it doesn't already exist - Stack Overflow"  |  https://stackoverflow.com/a/20688004
REM
REM ------------------------------------------------------------