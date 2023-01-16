CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""If ((GV True).Value) { SV IS_LOGON_SCRIPT ((GV False).Value); SV ACTIVE_SESSION_EXISTS ([bool]((C:\Windows\System32\query.exe user (Get-Content env:\USERNAME) | Select-String ' Active ').Count)); If ((((GV True).Value) -Eq ((GV IS_LOGON_SCRIPT).Value)) -Or (((GV False).Value) -Eq ((GV ACTIVE_SESSION_EXISTS).Value))) { Set-Location 'C:\ISO\HWiNFO64\Reports\'; SV Logfile ((write HWiNFO64-)+(Get-Date -Format (write yyyy-MM-dd))+(write .csv)); If (((Get-Process -Name 'HWiNFO64' -EA:0).Count -Eq 0) -Or ((Test-Path ((GV Logfile).Value)) -Eq ((GV False).Value))) { Get-Process -Name 'HWiNFO64' -EA:0 | Stop-Process -Force; Start-Sleep -Seconds 2; If (((GV True).Value) -Eq ((GV IS_LOGON_SCRIPT).Value)) { Start-Process -Filepath ((Get-Content env:\\ProgramFiles)+(write \AutoHotkey-v2\AutoHotkey64.exe)) -ArgumentList ((Get-Content env:\\USERPROFILE)+(write \Documents\GitHub\Coding\ahk\Archive\Windows_RefreshTrayIcons.ahkv2)) -NoNewWindow; }; Start-Process -Filepath ((write C:\Program)+([string][char]32)+(write Files\HWiNFO64\HWiNFO64.EXE)) -ArgumentList ((write -l)+((GV Logfile).Value)) -NoNewWindow; }; }; };"" ", 0, True

' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     HWiNFO64_AtStartup_AsAdmin
'
'   Security Options:
'     Run only when user is logged on (UN-CHECKED)
'     Run whether user is logged on or not (CHECKED)
'     Run with highest privileges (CHECKED)
'
'   Trigger:
'     At system startup (delay task for 45 seconds) - After triggered, repeat every 1 minute for a duration of 1439 minutes
'
'   Action:
'     Program/script:   C:\Windows\System32\wscript.exe
'     Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\HWiNFO64_AtStartup_AsAdmin.vbs"
'
' ------------------------------
'
'   Note(s):
'     - Set Remote Sensor Monitor port in file "C:\ISO\RemoteSensorMonitor\DefaultPort.txt"
'       - Create a firewall rule to filter/block inbound traffic on the Remote Sensor Monitor port
'     - Set Remote Sensor Monitor config in file "C:\ISO\RemoteSensorMonitor\DefaultConfig.txt"
'       - Config is reverse engineered from POST request to [ http://localhost:PORT/config ] in-browser
'     - Remote Sensor Monitor requires a paid subscription to HWiNFO (for the "Shared Memory Support" feature)
'
' ------------------------------------------------------------
'
' Citation(s)
'
'   openhardwaremonitor.org  |  "Downloads - Open Hardware Monitor"  |  https://openhardwaremonitor.org/downloads/
'
'   www.hwinfo.com  |  "Add-ons | HWiNFO"  |  https://www.hwinfo.com/add-ons/
'
'   www.hwinfo.com  |  "Introducing : Remote Sensor Monitor - A RESTful Web Server | HWiNFO Forum"  |  https://www.hwinfo.com/forum/threads/introducing-remote-sensor-monitor-a-restful-web-server.1025/
'
'   www.techpowerup.com  |  "TechPowerUp GPU-Z (v2.50.0) Download | TechPowerUp"  |  https://www.techpowerup.com/download/techpowerup-gpu-z/
'
' ------------------------------------------------------------