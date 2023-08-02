CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy 'RemoteSigned' -Scope 'CurrentUser' -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/EnsureProcessIsRunning/EnsureProcessIsRunning.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'EnsureProcessIsRunning' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Coding\powershell\_WindowsPowerShell\Modules\EnsureProcessIsRunning\EnsureProcessIsRunning.psm1', (gc env:\\REPOS_DIR))); }; EnsureProcessIsRunning -Name 'Autohotkey' -Path 'C:\Program Files\AutoHotkey\v2\AutoHotkey.exe' -Args ((${env:REPOS_DIR})+('\Coding\ahk\_WindowsHotkeys.ahkv2')) -Quiet;"" ", 0, True

' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     _WindowsHotkeys_NonAdmin
'
'   Security Options:
'     Run only when user is logged on (CHECKED)
'     Run whether user is logged on or not (UN-CHECKED)
'     Run with highest privileges (UN-CHECKED)
'
'   Trigger:
'     At log on of [current user]
'
'   Action:
'     Program/script:   C:\Windows\System32\wscript.exe
'     Add arguments:    "%REPOS_DIR%\Coding\visual basic\_WindowsHotkeys_NonAdmin.vbs"
'
'   Conditions:
'     (UN-CHECK) Start the task only if the computer is on AC power
'
'   Settings:
'     (UN-CHECK) Stop this task if it runs longer than:  (UN-CHECK)
'     (CHECK)    If the task is already running, then the following rule applies: [ Do not start a new instance ]
'
' ------------------------------------------------------------
'
' Citation(s)
'
'   www.autohotkey.com  |  "Autohotkey Version 2 Downloads"  |  https://www.autohotkey.com/download/2.0/
'
' ------------------------------------------------------------