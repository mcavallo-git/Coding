@ECHO OFF
REM ------------------------------------------------------------
REM 
REM Kill all VMWare Application(s)
REM 
TASKKILL /F /FI "IMAGENAME eq vmware-usbarbitrator64.exe"
TASKKILL /F /FI "IMAGENAME eq vmware-authd.exe"
TASKKILL /F /FI "IMAGENAME eq vmms.exe"
TASKKILL /F /FI "IMAGENAME eq vmnat.exe"
TASKKILL /F /FI "IMAGENAME eq vmnetdhcp.exe"
TASKKILL /F /FI "IMAGENAME eq vmware-hostd.exe"
TASKKILL /F /FI "IMAGENAME eq vmcompute.exe"
TASKKILL /F /FI "IMAGENAME eq vmware-tray.exe"
TASKKILL /F /FI "IMAGENAME eq vmware.exe"
TASKKILL /F /FI "IMAGENAME eq vmware-unity-helper.exe"
TASKKILL /F /FI "IMAGENAME eq vmware-vmx.exe"


REM ------------------------------------------------------------
REM Citation(s)
REM 
REM   docs.microsoft.com  |  "find - Searches for a string of text in a file or files, and displays lines of text that contain the specified string."  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/find
REM 
REM   docs.microsoft.com  |  "taskkill - Ends one or more tasks or processes. Processes can be ended by process ID or image name. taskkill replaces the kill tool."  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/taskkill
REM 
REM   docs.microsoft.com  |  "tasklist - Displays a list of currently running processes on the local computer or on a remote computer. Tasklist replaces the tlist tool."  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/tasklist
REM 
REM ------------------------------------------------------------