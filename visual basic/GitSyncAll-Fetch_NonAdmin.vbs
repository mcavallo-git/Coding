CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy 'RemoteSigned' -Scope 'CurrentUser' -Force; Try { Invoke-Expression ((Invoke-WebRequest -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/GitSyncAll/GitSyncAll.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'GitSyncAll' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\GitSyncAll\GitSyncAll.psm1', ((Get-Variable -Name 'HOME').Value))); }; GitSyncAll -Fetch;"" ", 0, True


' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     GitSyncAll-Fetch_NonAdmin
'
'   Trigger:
'     At log on
'     (UNCHECK) Enabled   *!* Make this task only be run manually - GitSyncAll-Pull will also fetch *!*
'
'   Action:
'     Program/script:   C:\Windows\System32\wscript.exe
'     Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\GitSyncAll-Fetch_NonAdmin.vbs"
'
'   Conditions:
'     (UNCHECK)  Start the task only if the computer is idle for: ...
'     (UNCHECK)  Start the task only if the computer is on AC power
'     (UNCHECK)  Wake the computer to run this task
'     (CHECK)    Start only if the following network connection is available: [ Any connection ]
'
'   Settings:
'     (CHECK)    Allow task to be run on demand
'     (UNCHECK)  Run as soon as possible after a scheduled start is missed
'     (UNCHECK)  If the task fails, restart every: ...
'     (CHECK)    Stop this task if it runs longer than:  2 minutes
'     (CHECK)    If the running task does not end when requested, force it to stop
'     (UNCHECK)  If the task is not scheduled to run again, delete it after: ...
'
' ------------------------------------------------------------
'
' Citation(s)
'
'   git-scm.com  |  "Git"  |  https://git-scm.com
'
' ------------------------------------------------------------