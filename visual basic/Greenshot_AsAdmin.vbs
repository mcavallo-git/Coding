CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy 'RemoteSigned' -Scope 'CurrentUser' -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/EnsureProcessIsRunning/EnsureProcessIsRunning.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'EnsureProcessIsRunning' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Coding\powershell\_WindowsPowerShell\Modules\EnsureProcessIsRunning\EnsureProcessIsRunning.psm1', (gc env:\\REPOS_DIR))); }; EnsureProcessIsRunning -Name 'Greenshot' -Path 'C:\Program Files\Greenshot\Greenshot.exe' -AsAdmin -Quiet;"" ", 0, True

'=============================================================
' Open 'Task Scheduler' > 'Create Task' (top right)
'=============================================================
'
'   General:
'
'     Task Name:  Greenshot_AsAdmin
'
'     Run as user:  [ UserSignedIn ]
'
'     ✔️ Run only when user is logged on (CHECKED)
'
'     ✔️ Run with highest privileges (CHECKED)
'
'=============================================================
'
'   Trigger:
'
'     At log on of specific user: [ UserSignedIn ]  (no delay, no repeat)
'
'=============================================================
'
'   Action:
'
'     Program/script:
'       C:\Windows\System32\wscript.exe
'
'     Add arguments:
'       "%REPOS_DIR%\Coding\visual basic\Greenshot_AsAdmin.vbs"
'
'=============================================================
'
'   Conditions:
'
'     ❌️ Start the task only if the computer is on AC power (UN-CHECKED)
'
'       ❌️ Stop if the computer switches to battery power (UN-CHECKED)
'
'=============================================================
'
'   Settings:
'
'     ❌️ Run the task as soon as possible after a scheduled start is missed (UN-CHECKED)
'
'     ✔️ Stop the task if it runs longer than:  [ 30 seconds ]
'
'     ✔️ If the running task does not end when requested, force it to stop (CHECKED)
'
'=============================================================
'
' Citation(s)
'
'   getgreenshot.org  |  "Greenshot"  |  https://getgreenshot.org/downloads/
'
'=============================================================