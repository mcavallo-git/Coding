'=============================================================
' Open 'Task Scheduler' > 'Create Task' (top right)
'=============================================================
'
'   General:
'
'     Task Name:  PRTG_IPinfoSensorReadings_AsAdmin
'
'     Run as user:  [ UserSignedIn ]
'
'     ✔️ Run whether user is logged on or not (CHECKED)
'
'     ❌️ Run with highest privileges (UN-CHECKED)
'
'=============================================================
'
'   Trigger:
'
'     At 00:00:45 every day - Repeat task every [ 1 minute ] for a duration of [ 1439 minutes ]
'
'=============================================================
'
'   Action:
'
'     Program/script:
'       C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
'
'     Add arguments:
'       -File "C:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\EXEXML\_PRTG_IPinfoSensorReadings.ps1"
'
'=============================================================