CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""Get-Process -Name 'HWiNFO64' -EA:0 | Stop-Process -Force; Get-Process -Name 'Remote Sensor Monitor' -EA:0 | Stop-Process -Force;"" ", 0, True

' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     HWiNFO64_AtLogon_RestartGui_AsAdmin
'
'   Trigger:
'     At logon (of current user)
'
'   Action:
'     Program/script:   C:\Windows\System32\wscript.exe
'     Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\HWiNFO64_AtLogon_RestartGui_AsAdmin.vbs"
'
'
'   Run only when user is logged on (CHECKED)
'   Run with highest privileges (CHECKED)
'
'
' Note(s):
'   - Set Remote Sensor Monitor port in file "C:\ISO\RemoteSensorMonitor\DefaultPort.txt"
'   - Set Remote Sensor Monitor config in file "C:\ISO\RemoteSensorMonitor\DefaultConfig.txt"
'     - Config is reverse engineered from POST request to [ http://localhost:PORT/config ] in-browser
'   - Remote Sensor Monitor requires a paid subscription to HWiNFO (for the "Shared Memory Support" feature)
'
' ------------------------------------------------------------