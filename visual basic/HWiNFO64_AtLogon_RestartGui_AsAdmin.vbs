CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""Get-Process -Name 'HWiNFO64' -EA:0 | Stop-Process -Force; Get-Process -Name 'Remote Sensor Monitor' -EA:0 | Stop-Process -Force; Start-ScheduledTask -TaskName 'HWiNFO64_AtLogon_AsAdmin';"" ", 0, True


'  !  Update to use the registry to detect if user is signed in or not
'  !    Use:  HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer!UserSignedIn


'=============================================================
' Open 'Task Scheduler' using 'Run as administrator' > 'Create Task' (top right)
'=============================================================
'
'   General:
'
'     Task Name:  HWiNFO64_AtLogon_RestartGui_AsAdmin
'
'     Run as user:  [ UserSignedIn ]
'
'     ✔️ Run only when user is logged on  (CHECKED)
'
'     ✔️ Run with highest privileges  (CHECKED)
'
'=============================================================
'
'   Trigger:
'
'     At log on of specific user: [ UserSignedIn ] (no delay, no repeat)
'
'=============================================================
'
'   Action:
'
'     Program/script:
'       C:\Windows\System32\wscript.exe
'
'     Add arguments:
'       "%USERPROFILE%\Documents\GitHub\Coding\visual basic\HWiNFO64_AtLogon_RestartGui_AsAdmin.vbs"
'
'=============================================================
'
'   Note(s):
'     - Set Remote Sensor Monitor port in file "C:\ISO\RemoteSensorMonitor\DefaultPort.txt"
'       - Create a firewall rule to filter/block inbound traffic on the Remote Sensor Monitor port
'     - Set Remote Sensor Monitor config in file "C:\ISO\RemoteSensorMonitor\DefaultConfig.txt"
'       - Config is reverse engineered from POST request to [ http://localhost:PORT/config ] in-browser
'     - Remote Sensor Monitor requires a paid subscription to HWiNFO (for the "Shared Memory Support" feature)
'
'=============================================================
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
'=============================================================