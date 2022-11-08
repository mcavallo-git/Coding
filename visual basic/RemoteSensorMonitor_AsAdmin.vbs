CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""Start-Process -Filepath ('C:\Program Files (x86)\GPU-Z\GPU-Z.exe') -ArgumentList (@('-restarted -minimized')) -NoNewWindow -PassThru -EA:0; Start-Sleep -Seconds (15); Set-Location 'C:\ISO\RemoteSensorMonitor'; Start-Process -Filepath ('C:\ISO\RemoteSensorMonitor\Remote Sensor Monitor.exe') -ArgumentList (@('-p 30030 --hwinfo 0 --gpuz 1 --aida64 0 --ohm 1')) -NoNewWindow -PassThru -EA:0; SV DefaultConf 'C:\ISO\RemoteSensorMonitor\DefaultConfig.txt'; If (Test-Path ((GV DefaultConf).Value)) { Start-Sleep -Seconds 5; SV ProgressPreference SilentlyContinue; Invoke-WebRequest -UseBasicParsing -Uri 'http://localhost:30030/apply_config' -ContentType 'application/x-www-form-urlencoded; charset=UTF-8' -Method 'POST' -Body (Get-Content ((GV DefaultConf).Value)); };"" ", 0, True


' Remote Sensor Monitor - Configuration:  http://localhost:30030/config

' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     RemoteSensorMonitor_AsAdmin
'
'   Trigger:
'     At log on
'
'   Action:
'     Program/script:   C:\Windows\System32\wscript.exe
'     Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\RemoteSensorMonitor_AsAdmin.vbs"
'
'   Run only when user is logged on (CHECKED)
'   Run with highest privileges (CHECKED)
'
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