
Set WScript_Shell = WScript.CreateObject( "WScript.Shell" )

RunProcess = WScript_Shell.ExpandEnvironmentStrings("%LOCALAPPDATA%") & "\Programs\NiceHash Miner\NiceHashMiner.exe"

PowerShell_Command = "PowerShell -Command ""Start-Process -Filepath ('" & RunProcess & "') -Verb ('RunAs') -WindowStyle ('Hidden');"" "

WScript.Echo "RunProcess" & Chr(10) & RunProcess & Chr(10) & Chr(10) & "PowerShell_Command" & Chr(10) & PowerShell_Command

CreateObject( "WScript.Shell" ).Run PowerShell_Command, 0, True


' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     NiceHashMiner_NonAdmin
'
'   Trigger:
'     At startup
'     On workstation lock
'
'   Settings:
'     (UNCHECK)    Stop this task if it runs longer than:  ...
'
'   Action:
'     Program/script:   C:\Windows\System32\wscript.exe
'     Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\NiceHashMiner_NonAdmin.vbs"
'
'   Run whether user is logged on or not (CHECKED)
'   Run with highest privileges (CHECKED)
'
' ------------------------------------------------------------