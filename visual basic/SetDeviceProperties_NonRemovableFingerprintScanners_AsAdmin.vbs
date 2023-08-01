' ===================================================
' Open 'Task Scheduler' using 'Run as administrator' > 'Create Task' (top right)
' ============================================================
'   General:
'
'     Task Name:    SetDeviceProperties_NonRemovableFingerprintScanners
'
'     Run as user:  SYSTEM
'
'     ✔️ Run whether user is logged on or not (will be auto-selected after creation)
'
'     ❌ Run with highest privileges (unckecked)
'
' ============================================================
'   Trigger:
'
'     At system startup (delay task for 30 seconds) - After triggered, repeat every 5 minutes for a duration of 1439 minutes
'
' ============================================================
'   Action:
'
'     Program/script:
'       C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
'
'     Add arguments:
'       -File "C:\ISO\DeviceManagement\SetDeviceProperties_NonRemovableFingerprintScanners.ps1"
'
' ============================================================