CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""Get-Process | Where-Object { @('app_nhm','excavator','NiceHashMiner').Contains($_.Name) } | Stop-Process -Force; "" ", 0, True


' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     NiceHashSniper_AsAdmin
'
'   Trigger:
'     At log on
'     On workstation unlock
'
'   Settings:
'     (CHECK)    Stop this task if it runs longer than:  1 minute
'
'   Action:
'     Program/script:   C:\Windows\System32\wscript.exe
'     Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\NiceHashSniper_AsAdmin.vbs"
'
'   Run only when user is logged on (CHECKED)
'   Run with highest privileges (CHECKED)
'
'
' ------------------------------------------------------------