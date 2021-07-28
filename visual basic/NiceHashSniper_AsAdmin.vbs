CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""Get-Process | Where-Object { @('app_nhm','NiceHashMiner').Contains($_.Name) } | Stop-Process;"" -Verb ('RunAs') -WindowStyle ('Hidden')", 0, True


' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     NiceHashSniper_AsAdmin
'
'   Trigger:
'     On Workstation Unlock | On Sign-In
'
'   Settings:
'     (CHECK)    Stop this task if it runs longer than:  2 minutes
'
'   Action:
'     Program/script:   C:\Windows\System32\wscript.exe
'     Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\NiceHashSniper_AsAdmin.vbs"
'
'
' ------------------------------------------------------------