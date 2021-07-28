' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     NiceHashMiner_NonAdmin
'
'   Trigger:
'     At startup
'     On workstation lock (of any user)
'
'   Settings:
'     (UNCHECK)    Stop this task if it runs longer than:  ...
'
'   Action:
'     Program/script:   "%LOCALAPPDATA%\Programs\NiceHash Miner\NiceHashMiner.exe"
'
'   Run whether user is logged on or not (CHECKED)
'
'
' ------------------------------------------------------------