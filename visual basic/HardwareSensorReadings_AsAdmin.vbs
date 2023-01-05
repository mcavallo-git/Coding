' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     HardwareSensorReadings_AsAdmin
'
'   Trigger:
'     On a schedule
'       At 00:00:30 every day - After triggered, repeat every 1 minute for a duration of 1439 minutes
'
'   Action:
'     Program/script:   C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
'     Add arguments:    -File "C:\Program Files (x86)\PRTG Network Monitor\Custom Sensors\EXEXML\get-hardware-sensor-readings.ps1"
'
'   Run only when user is logged on (UNCHECKED)
'   Run with highest privileges (CHECKED)
'
' ------------------------------------------------------------