CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy 'RemoteSigned' -Scope 'CurrentUser' -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/EnsureProcessIsRunning/EnsureProcessIsRunning.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'EnsureProcessIsRunning' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\EnsureProcessIsRunning\EnsureProcessIsRunning.psm1', ((Get-Variable -Name 'HOME').Value))); }; EnsureProcessIsRunning -Name 'kleopatra' -Path 'C:\Program Files (x86)\Gpg4win\bin\kleopatra.exe' -WindowStyle 'Hidden' -Quiet;"" ", 0, True


' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     Kleopatra_NonAdmin
'
'   Security Options:
'     Run only when user is logged on (CHECKED)
'     Run whether user is logged on or not (UN-CHECKED)
'     Run with highest privileges (UN-CHECKED)
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