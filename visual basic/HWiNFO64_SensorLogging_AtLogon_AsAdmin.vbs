CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""If ((GV True).Value) { SV IS_LOGON_SCRIPT ((GV True).Value); SV ACTIVE_SESSION_EXISTS ([bool]((C:\Windows\System32\query.exe user (gc env:\\USERNAME) | Select-String ' Active ').Count)); If ((((GV True).Value) -Eq ((GV IS_LOGON_SCRIPT).Value)) -Or (((GV False).Value) -Eq ((GV ACTIVE_SESSION_EXISTS).Value))) { Set-Location 'C:\ISO\HWiNFO64\Reports\'; SV Logfile ((write HWiNFO64-)+(Get-Date -Format (write yyyy-MM-dd))+(write .csv)); If (((Get-Process -Name 'HWiNFO64' -EA:0).Count -Eq 0) -Or ((Test-Path ((GV Logfile).Value)) -Eq ((GV False).Value))) { Get-Process -Name 'HWiNFO64' -EA:0 | Stop-Process -Force; Start-Sleep -Seconds 2; If (((GV True).Value) -Eq ((GV IS_LOGON_SCRIPT).Value)) { Start-Process -Filepath ((gc env:\\ProgramFiles)+(write \AutoHotkey\v2\AutoHotkey.exe)) -ArgumentList ((gc env:\\REPOS_DIR)+(write \Coding\ahk\Archive\Windows_RefreshTrayIcons.ahkv2)) -NoNewWindow; }; Start-Process -Filepath ((write C:\Program)+([string][char]32)+(write Files\HWiNFO64\HWiNFO64.EXE)) -ArgumentList ((write -l)+((GV Logfile).Value)); }; }; };"" ", 0, True

'=============================================================
' Open 'Task Scheduler' > 'Create Task' (top right)
'=============================================================
'
'   General:
'
'     Task Name:  HWiNFO64_SensorLogging_AtLogon_AsAdmin
'
'     Run as user:  [ UserSignedIn ]
'
'     ✔️ Run only when user is logged on (CHECKED)
'
'     ✔️ Run with highest privileges (CHECKED)
'
'=============================================================
'
'   Trigger:
'
'     At log on of specific user: [ UserSignedIn ]  (no delay, no repeat)
'
'     At 00:00:30 every day - Repeat task every [ 1 minute ] for a duration of [ 1439 minutes ]
'
'=============================================================
'
'   Action:
'
'     Program/script:
'       C:\Windows\System32\wscript.exe
'
'     Add arguments:
'       "%USERPROFILE%\Documents\GitHub\Coding\visual basic\HWiNFO64_SensorLogging_AtLogon_AsAdmin.vbs"
'
'=============================================================
'
'   Conditions:
'
'     ❌️ Start the task only if the computer is on AC power (UN-CHECKED)
'
'       ❌️ Stop if the computer switches to battery power (UN-CHECKED)
'
'=============================================================
'
'   Settings:
'
'     ❌️ Run the task as soon as possible after a scheduled start is missed (UN-CHECKED)
'
'     ✔️ Stop the task if it runs longer than:  [ 50 seconds ]
'
'     ✔️ If the running task does not end when requested, force it to stop (CHECKED)
'
'     ⚠️  If the task is already running, then the following rule applies:  [ Do not start a new instance ]
'
'=============================================================