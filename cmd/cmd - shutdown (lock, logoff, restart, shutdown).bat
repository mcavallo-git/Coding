@ECHO OFF

EXIT

REM
REM ---------------------------------------------------------------------------------------------------------------------------------
REM
REM LOGOFF
REM    shutdown /l  :::  Logs off the current user immediately, with no time-out period. You cannot use /l with /m or /t.
REM    shutdown /f  :::  Forces running applications to close without warning users. Caution: Using the /f option might result in loss of unsaved data.

REM !!! NOTE: USE 'logoff.exe' INSTEAD:

%SystemRoot%\System32\logoff.exe /V > %APPDATA%\logoff.log

REM
REM ---------------------------------------------------------------------------------------------------------------------------------
REM
REM RESTART
REM    shutdown /r  :::  Restarts the computer after shutdown.

shutdown.exe /r

REM
REM ---------------------------------------------------------------------------------------------------------------------------------
REM
REM SHUTDOWN
REM    shutdown /s  :::  Shuts down the computer.

shutdown.exe /s

REM
REM ---------------------------------------------------------------------------------------------------------------------------------
REM
REM HIBERNATE
REM    shutdown /h  :::  Puts the local computer into hibernation, if hibernation is enabled. You can use /h only with /f.

shutdown.exe /h

REM
REM ---------------------------------------------------------------------------------------------------------------------------------
REM
REM ADD DELAY TO SHUTDOWN
REM    shutdown /t <XXX> :::  Sets the time-out period or delay to XXX seconds before a restart or shutdown. This causes a warning to display on the local console. You can specify 0-600 seconds. If you do not use /t, the time-out period is 30 seconds by default.

shutdown.exe /s

REM
REM ---------------------------------------------------------------------------------------------------------------------------------
REM
REM ABORT A SCHEDULED SHUTDOWN
REM    shutdown /a  :::  Aborts a system shutdown. Effective only during the timeout period. To use /a, you must also use the /m option.

shutdown.exe /a

REM
REM ---------------------------------------------------------------------------------------------------------------------------------
REM
REM RESTART LAN PC 
REM    shutdown /m \\<ComputerName>	 :::  Specifies the target computer. Cannot be used with the /l option.

shutdown.exe /m \\10.0.0.20 /r /f

REM
REM ---------------------------------------------------------------------------------------------------------------------------------
REM
REM Citation(s)
REM
REM		docs.microsoft.com
REM		"shutdown" - Enables you to shut down or restart local or remote computers one at a time
REM		 https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/shutdown
REM
REM ---------------------------------------------------------------------------------------------------------------------------------
REM