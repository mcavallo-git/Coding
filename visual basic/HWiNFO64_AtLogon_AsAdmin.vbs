CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""SV IS_LOGGED_ON ([bool]((C:\Windows\System32\query.exe user (Get-Content env:\USERNAME) | Select-String ' Active ').Count)); If (((GV IS_LOGGED_ON).Value) -Eq ((GV True ).Value)) { Set-Location 'C:\ISO\HWiNFO64\Reports\'; SV Logfile ((write HWiNFO64-)+(Get-Date -Format (write yyyy-MM-dd))+(write .csv)); If (((Get-Process -Name 'HWiNFO64' -EA:0).Count -Eq 0) -Or ((Get-Process -Name 'Remote Sensor Monitor' -EA:0).Count -Eq 0) -Or ((Test-Path ((GV Logfile).Value)) -Eq ((GV False).Value))) { Get-Process -Name 'HWiNFO64' -EA:0 | Stop-Process -Force; Get-Process -Name 'Remote Sensor Monitor' -EA:0 | Stop-Process -Force; Start-Process -Filepath ((Get-Content env:\\ProgramFiles)+(write \AutoHotkey-v2\AutoHotkey64.exe)) -ArgumentList ((Get-Content env:\\USERPROFILE)+(write \Documents\GitHub\Coding\ahk\Archive\Windows_RefreshTrayIcons.ahkv2)) -NoNewWindow; Start-Process -Filepath ((write C:\Program)+([string][char]32)+(write Files\HWiNFO64\HWiNFO64.EXE)) -ArgumentList ((write -l)+((GV Logfile).Value)) -NoNewWindow; While ((Get-Process -Name 'HWiNFO64' -EA:0) -Eq ((GV Null).Value)) { Start-Sleep -Seconds 2; }; Set-Location 'C:\ISO\RemoteSensorMonitor'; SV DefaultPort (Get-Content 'C:\ISO\RemoteSensorMonitor\DefaultPort.txt' -EA:0); Start-Sleep -Seconds 5; Start-Process -Filepath ('C:\ISO\RemoteSensorMonitor\Remote Sensor Monitor.exe') -ArgumentList ([String]::Format('-p {0} --hwinfo 1 --gpuz 0 --aida64 0 --ohm 0', ((GV DefaultPort).Value))) -NoNewWindow -PassThru -EA:0; If (Test-Path 'C:\ISO\RemoteSensorMonitor\DefaultConfig.txt' -EA:0) { SV DefaultConf (Get-Content 'C:\ISO\RemoteSensorMonitor\DefaultConfig.txt' -EA:0); SV ProgressPreference 0; Invoke-WebRequest -UseBasicParsing -Uri ([String]::Format('http://localhost:{0}/apply_config', ((GV DefaultPort).Value))) -ContentType 'application/x-www-form-urlencoded; charset=UTF-8' -Method 'POST' -Body ((GV DefaultConf).Value); }; }; };"" ", 0, True

' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     HWiNFO64_AtLogon_AsAdmin
'
'   Trigger:
'     On a schedule
'       At 00:00 every day - After triggered, repeat every 1 minute for a duration of 1439 minutes
'
'   Action:
'     Program/script:   C:\Windows\System32\wscript.exe
'     Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\HWiNFO64_AtLogon_AsAdmin.vbs"
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