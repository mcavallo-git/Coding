CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy 'RemoteSigned' -Scope 'CurrentUser' -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/EnsureProcessIsRunning/EnsureProcessIsRunning.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'EnsureProcessIsRunning' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\EnsureProcessIsRunning\EnsureProcessIsRunning.psm1', ((Get-Variable -Name 'HOME').Value))); }; EnsureProcessIsRunning -Name 'kleopatra' -Path 'C:\Program Files (x86)\Gpg4win\bin\kleopatra.exe' -Quiet -WindowStyle 'Hidden';"" ", 0, True


' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     Kleopatra_NonAdmin
'
'   Trigger:
'     At log on
'
'   Action:
'     Program/script:   C:\Windows\System32\wscript.exe
'     Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\Kleopatra_NonAdmin.vbs"
'
'
' ------------------------------------------------------------
'
' Citation(s)
'
'   www.gpg4win.org  |  "Gpg4win - Secure email and file encryption with GnuPG for Windows"  |  https://www.gpg4win.org
'
' ------------------------------------------------------------