'=============================================================
' Open 'Task Scheduler' > 'Create Task' (top right)
'=============================================================
'
'   General:
'
'     Task Name:  _WindowsHotkeys_AsAdmin
'
'     Run as user:  [ UserSignedIn ]
'
'     ✔️ Run only when user is logged on (CHECKED)
'
'     ❌️ Run with highest privileges (UN-CHECKED)
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
'       %ProgramFiles%\AutoHotkey\v2\AutoHotkey.exe
'
'     Add arguments:
'       "%USERPROFILE%\Documents\GitHub\Coding\ahk\_EntertainmentHotkeys.ahkv2"
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
'     ❌️ Stop the task if it runs longer than: (UN-CHECKED)
'
'     ✔️ If the running task does not end when requested, force it to stop (CHECKED)
'
'=============================================================