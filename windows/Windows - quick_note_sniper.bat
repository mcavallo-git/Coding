@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

REM Step 1/3 - Kill Notification Area QuickNote(s)
SET QUICKNOTE_NOTIFICATION_AREA_EXE="ONENOTEM.EXE"
TASKLIST /FI "IMAGENAME eq %QUICKNOTE_NOTIFICATION_AREA_EXE%"
IF "!ERRORLEVEL!"=="0" ( REM Program found to be currently running
	TASKKILL /IM %QUICKNOTE_NOTIFICATION_AREA_EXE% /F
)

REM Step 2/3 - Kill App-Data QuickNote(s)
DEL "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Send to OneNote*"

REM Step 3/3 - Kill Startup-Directory QuickNote(s)
DEL "%USERPROFILE%\Documents\OneNote Notebooks\Quick Notes*.one"
