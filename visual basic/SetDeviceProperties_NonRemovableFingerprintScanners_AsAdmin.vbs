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
'     ✔️ Run whether user is logged on or not (CHECKED) (will be auto-selected after creation)
'
'     ❌ Run with highest privileges (UN-CHECKED)
'
'=============================================================
'
'   Trigger:
'
'     At system startup  (no delay, no repeat)
'
'     At 00:00:30 every day - After triggered, repeat every [ 1 minute ] for a duration of [ 1439 minutes ]
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