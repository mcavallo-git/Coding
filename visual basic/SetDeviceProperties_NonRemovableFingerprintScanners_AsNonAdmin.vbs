'=============================================================
' Open 'Task Scheduler' > 'Create Task' (top right)
'=============================================================
'
'   General:
'
'     Task Name:  SetDeviceProperties_NonRemovableFingerprintScanners
'
'     Run as user:  [ UserSignedIn ]
'
'     ✔️ Run whether user is logged on or not (CHECKED)
'
'     ❌ Run with highest privileges (UN-CHECKED)
'
'=============================================================
'
'   Trigger:
'
'     At system startup  (no delay, no repeat)
'
'     At log on of any user  (no delay, no repeat)
'
'     At 00:00:30 every day - Repeat task every [ 1 minute ] for a duration of [ 1439 minutes ]
'
'=============================================================
'
'   Action:
'
'     Program/script:
'       C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
'
'     Add arguments:
'       -File "%ISO_DIR%\DeviceManagement\SetDeviceProperties_NonRemovableFingerprintScanners.ps1"
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