CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""Get-Process -Name 'Remote Sensor Monitor' -EA:0 | Stop-Process -Force; While ((Get-Process -Name 'HWiNFO64' -EA:0) -Eq ((GV Null).Value)) { Start-Sleep -Seconds 5; }; Set-Location 'C:\ISO\RemoteSensorMonitor'; SV DefaultPort (Get-Content 'C:\ISO\RemoteSensorMonitor\DefaultPort.txt' -EA:0); Start-Process -Filepath ('C:\ISO\RemoteSensorMonitor\Remote Sensor Monitor.exe') -ArgumentList ([String]::Format('-p {0} --hwinfo 1 --gpuz 0 --aida64 0 --ohm 0', ((GV DefaultPort).Value))) -NoNewWindow -PassThru -EA:0; If (Test-Path 'C:\ISO\RemoteSensorMonitor\DefaultConfig.txt' -EA:0) { SV DefaultConf (Get-Content 'C:\ISO\RemoteSensorMonitor\DefaultConfig.txt' -EA:0); Start-Sleep -Seconds 5; SV ProgressPreference 0; Invoke-WebRequest -UseBasicParsing -Uri ([String]::Format('http://localhost:{0}/apply_config', ((GV DefaultPort).Value))) -ContentType 'application/x-www-form-urlencoded; charset=UTF-8' -Method 'POST' -Body ((GV DefaultConf).Value); };"" ", 0, True

' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     RemoteSensorMonitor_AsAdmin
'
'   Trigger:
'     At system startup
'     Delay task for: 15 seconds
'
'   Action:
'     Program/script:   C:\Windows\System32\wscript.exe
'     Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\RemoteSensorMonitor_AsAdmin.vbs"
'
'   Run only when user is logged on (UNCHECKED)
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