CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""If (((Get-Process -Name 'HWiNFO64' -EA:0).Count -Eq 0) -Or ((Get-Process -Name 'Remote Sensor Monitor' -EA:0).Count -Eq 0)) { Get-Process -Name 'HWiNFO64' -EA:0 | Stop-Process -Force; Get-Process -Name 'Remote Sensor Monitor' -EA:0 | Stop-Process -Force; Start-Sleep -Seconds 3; Start-Process -Filepath ((write C:\Program)+([string][char]32)+(write Files\HWiNFO64\HWiNFO64.EXE)) -ArgumentList (write -l) -NoNewWindow; While ((Get-Process -Name 'HWiNFO64' -EA:0) -Eq ((GV Null).Value)) { Start-Sleep -Seconds 5; }; Start-Sleep -Seconds 10; Set-Location 'C:\ISO\RemoteSensorMonitor'; SV DefaultPort (Get-Content 'C:\ISO\RemoteSensorMonitor\DefaultPort.txt' -EA:0); Start-Process -Filepath ('C:\ISO\RemoteSensorMonitor\Remote Sensor Monitor.exe') -ArgumentList ([String]::Format('-p {0} --hwinfo 1 --gpuz 0 --aida64 0 --ohm 0', ((GV DefaultPort).Value))) -NoNewWindow -PassThru -EA:0; If (Test-Path 'C:\ISO\RemoteSensorMonitor\DefaultConfig.txt' -EA:0) { SV DefaultConf (Get-Content 'C:\ISO\RemoteSensorMonitor\DefaultConfig.txt' -EA:0); Start-Sleep -Seconds 5; SV ProgressPreference 0; Invoke-WebRequest -UseBasicParsing -Uri ([String]::Format('http://localhost:{0}/apply_config', ((GV DefaultPort).Value))) -ContentType 'application/x-www-form-urlencoded; charset=UTF-8' -Method 'POST' -Body ((GV DefaultConf).Value); }; };"" ", 0, True

' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     HWiNFO64_AsAdmin
'
'   Trigger:
'     At system startup
'       Repeat task every 5 minutes for a duration of 1436 minutes
'
'   Action:
'     Program/script:   C:\Windows\System32\wscript.exe
'     Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\HWiNFO64_AsAdmin.vbs"
'
'   Run only when user is logged on (UNCHECKED)
'   Run with highest privileges (CHECKED)
'
'
' Note(s):
'   - This requires a paid version of HWiNFO with Shared Memory support
'   - Set Remote Sensor Monitor port in file "C:\ISO\RemoteSensorMonitor\DefaultPort.txt"
'   - Set Remote Sensor Monitor config in file "C:\ISO\RemoteSensorMonitor\DefaultConfig.txt"
'     - Config is reverse engineered from POST request to [ http://localhost:PORT/config ] in-browser
'
' ------------------------------------------------------------