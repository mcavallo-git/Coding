CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""If (Get-Process -Name 'ONENOTEM' -ErrorAction 'SilentlyContinue') { Stop-Process -Name 'ONENOTEM' -Force -ErrorAction 'SilentlyContinue'; Start-Sleep 1; Remove-Item -Path ('~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Send to OneNote*') -Force; Start-Sleep 1; Remove-Item -Path ('~\Documents\OneNote Notebooks\Quick Notes*.one') -Force; Exit 200; } Else { Exit 404; }"" ", 0, True

'=============================================================
' Open 'Task Scheduler' > 'Create Task' (top right)
'=============================================================
'
'   General:
'
'     Task Name:  QuickNoteSniper_NonAdmin
'
'     Run as user:  [ UserSignedIn ]
'
'     ✔️ Run only when user is logged on (CHECKED)
'
'     ❌ Run with highest privileges (UN-CHECKED)
'
'=============================================================
'
'   Trigger:
'
'     At log on of specific user: [ UserSignedIn ]  (no delay, no repeat)
'
'     At 00:00:35 every day - Repeat task every [ 5 minutes ] for a duration of [ 1439 minutes ]
'
'=============================================================
'
'   Action:
'
'     Program/script:
'       C:\Windows\System32\wscript.exe
'
'     Add arguments:
'       "%USERPROFILE%\Documents\GitHub\Coding\visual basic\QuickNoteSniper_NonAdmin.vbs"
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
'     ✔️ Run the task as soon as possible after a scheduled start is missed (CHECKED)
'
'     ✔️ Stop the task if it runs longer than:  [ 10 seconds ]
'
'     ✔️ If the running task does not end when requested, force it to stop (CHECKED)
'
'=============================================================