CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""[System.Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy 'RemoteSigned' -Scope 'CurrentUser' -Force; Try { Invoke-Expression ((Invoke-WebRequest -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/EnsureProcessIsRunning/EnsureProcessIsRunning.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'EnsureProcessIsRunning' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\EnsureProcessIsRunning\EnsureProcessIsRunning.psm1', ((Get-Variable -Name 'HOME').Value))); }; EnsureProcessIsRunning -Name 'Greenshot' -Path 'C:\Program Files\Greenshot\Greenshot.exe' -AsAdmin -Quiet;"" ", 0, True

' Program/script:   C:\Windows\System32\wscript.exe
' Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\GreenshotAsAdmin.vbs"

' Trigger: At log on
