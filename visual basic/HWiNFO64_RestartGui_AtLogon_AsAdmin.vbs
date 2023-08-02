CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""Get-Process -Name 'HWiNFO64' -EA:0 | Stop-Process -Force; Get-Process -Name 'Remote Sensor Monitor' -EA:0 | Stop-Process -Force; Start-ScheduledTask -TaskName 'HWiNFO64_AtLogon_AsAdmin';"" ", 0, True

'=============================================================
' Open 'Task Scheduler' > 'Create Task' (top right)
'=============================================================
'
'   General:
'
'     Task Name:  HWiNFO64_RestartGui_AtLogon_AsAdmin
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
'=============================================================
'
'   Action:
'
'     Program/script:
'       C:\Windows\System32\wscript.exe
'
'     Add arguments:
'       "%USERPROFILE%\Documents\GitHub\Coding\visual basic\HWiNFO64_RestartGui_AtLogon_AsAdmin.vbs"
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
'     ✔️ Stop the task if it runs longer than:  [ 30 seconds ]
'
'     ✔️ If the running task does not end when requested, force it to stop (CHECKED)
'
'=============================================================