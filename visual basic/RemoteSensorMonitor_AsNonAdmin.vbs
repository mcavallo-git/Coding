CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""If ((GV True).Value) { SV ErrorActionPreference 0; SV ProgressPreference 0; SV DefaultPort (Get-Content 'C:\ISO\RemoteSensorMonitor\DefaultPort.txt' -EA:0); Try { (Invoke-WebRequest -UseBasicParsing -Uri ([String]::Format('http://localhost:{0}/',((GV DefaultPort).Value))) -TimeoutSec (2)) | Out-Null; SV RequestSuccess 1; } Catch { SV RequestSuccess 0; }; If ((([int]((Get-Process -Name 'Remote Sensor Monitor' -EA:0).Count)) -Eq 0) -Or (((GV RequestSuccess).Value) -Eq 0)) { For ($i = 0; $i -LT 15; $i++) { If (Get-Process -Name 'HWiNFO64' -EA:0) { Break; } Else { Start-Sleep -Seconds 2; }; }; Set-Location 'C:\ISO\RemoteSensorMonitor'; Get-Process -Name 'Remote Sensor Monitor' -EA:0 | Stop-Process -Force; Start-Sleep -Seconds 1; Start-Process -Filepath ('C:\ISO\RemoteSensorMonitor\Remote Sensor Monitor.exe') -ArgumentList ([String]::Format('-p {0} --hwinfo 1 --gpuz 0 --aida64 0 --ohm 0', ((GV DefaultPort).Value))) -NoNewWindow -EA:0; If (Test-Path 'C:\ISO\RemoteSensorMonitor\DefaultConfig.txt' -EA:0) { SV DefaultConf (Get-Content 'C:\ISO\RemoteSensorMonitor\DefaultConfig.txt' -EA:0); Start-Sleep -Seconds 3; Invoke-WebRequest -UseBasicParsing -Uri ([String]::Format('http://localhost:{0}/apply_config',((GV DefaultPort).Value))) -ContentType 'application/ -www-form-urlencoded;charset=UTF-8' -Method 'POST' -Body ((GV DefaultConf).Value); }; }; };"" ", 0, True

' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     RemoteSensorMonitor_AsNonAdmin
'
'   Security Options:
'     Run only when user is logged on (CHECKED)
'     Run whether user is logged on or not (UN-CHECKED)
'     Run with highest privileges (CHECKED)
'
'   Trigger:
'     At log on
'
'   Action:
'     Program/script:   C:\Windows\System32\wscript.exe
'     Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\RemoteSensorMonitor_AsNonAdmin.vbs"
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
' ------------------------------------------------------------