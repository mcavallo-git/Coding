CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy 'RemoteSigned' -Scope 'CurrentUser' -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/EnsureProcessIsRunning/EnsureProcessIsRunning.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'EnsureProcessIsRunning' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\EnsureProcessIsRunning\EnsureProcessIsRunning.psm1', ((Get-Variable -Name 'HOME').Value))); }; EnsureProcessIsRunning -Name 'GPU-Z' -Path 'C:\Program Files (x86)\GPU-Z\GPU-Z.exe' -Args ('-restarted -minimized') -AsAdmin -Quiet;"" ", 0, True


' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     GPU-Z_AsAdmin
'
'   Trigger:
'     At log on
'
'   Action:
'     Program/script:   C:\Windows\System32\wscript.exe
'     Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\GPU-Z_AsAdmin.vbs"
'
'   Run only when user is logged on (CHECKED)
'   Run with highest privileges (CHECKED)
'
'
' ------------------------------------------------------------