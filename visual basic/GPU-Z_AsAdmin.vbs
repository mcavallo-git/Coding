CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""Start-Process -Filepath ('C:\Program Files (x86)\GPU-Z\GPU-Z.exe') -ArgumentList (@('-restarted -minimized')) -NoNewWindow -Wait -PassThru -EA:0;"" ", 0, True


' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     GPU-Z_AsAdmin
'
'   Security Options:
'     Run only when user is logged on (CHECKED)
'     Run with highest privileges (CHECKED)
'
'   Trigger:
'     At log on
'
'   Action:
'     Program/script:   C:\Windows\System32\wscript.exe
'     Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\GPU-Z_AsAdmin.vbs"
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