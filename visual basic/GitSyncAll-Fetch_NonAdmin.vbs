CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy 'RemoteSigned' -Scope 'CurrentUser' -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/GitSyncAll/GitSyncAll.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'GitSyncAll' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\GitSyncAll\GitSyncAll.psm1', ((Get-Variable -Name 'HOME').Value))); }; GitSyncAll -Fetch;"" ", 0, True

' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     GitSyncAll-Fetch_NonAdmin
'
'   Security Options:
'     Run only when user is logged on (CHECKED)
'     Run with highest privileges (UN-CHECKED)
'
'   Trigger:
'     (1) Begin the task:  At log on
'          |--> Specific User:  (Same as Author (above))
'          |--> Delay task for:  0 seconds
'
'   Action:
'     Program/script:   C:\Windows\System32\wscript.exe
'     Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\GitSyncAll-Fetch_NonAdmin.vbs"
'
'   Conditions:
'     (UNCHECK)  Start the task only if the computer is on AC power
'     (CHECK)    Start only if the following network connection is available: [ Any connection ]
'
'   Settings:
'     (CHECK)    Stop this task if it runs longer than:  2 minutes
'
' ------------------------------------------------------------
'
' Citation(s)
'
'   git-scm.com  |  "Git"  |  https://git-scm.com
'
' ------------------------------------------------------------