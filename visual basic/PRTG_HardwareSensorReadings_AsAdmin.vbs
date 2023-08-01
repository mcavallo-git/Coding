' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     PRTG_HardwareSensorReadings_AsAdmin
'
'   Security Options:
'     Run only when user is logged on (UN-CHECKED)
'     Run whether user is logged on or not (CHECKED)
'     Run with highest privileges (CHECKED)
'
'   Trigger:
'     On a schedule - At 00:00:30 every day - After triggered, repeat every 1 minute for a duration of 1439 minutes
'
'   Action:
'     Program/script:   C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
'     Add arguments:    -File "C:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\EXEXML\_PRTG_HardwareSensorReadings.ps1"
'
' ------------------------------------------------------------