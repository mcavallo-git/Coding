CreateObject( "WScript.Shell" ).Run "%LOCALAPPDATA%\Programs\NiceHash Miner\NiceHashMiner.exe", 0, True


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
'     (CHECK)    Stop this task if it runs longer than:  1 minute
'
'   Action:
'     Program/script:   C:\Windows\System32\wscript.exe
'     Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\NiceHashMiner_NonAdmin.vbs"
'
'
' ------------------------------------------------------------