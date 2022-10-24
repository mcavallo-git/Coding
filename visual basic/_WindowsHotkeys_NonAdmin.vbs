CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy 'RemoteSigned' -Scope 'CurrentUser' -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/EnsureProcessIsRunning/EnsureProcessIsRunning.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'EnsureProcessIsRunning' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\EnsureProcessIsRunning\EnsureProcessIsRunning.psm1', ((Get-Variable -Name 'HOME').Value))); }; EnsureProcessIsRunning -Name 'Autohotkey' -Path 'C:\Program Files\AutoHotkey-v2\AutoHotkeyU64.exe' -Args ((${HOME})+('\Documents\GitHub\Coding\ahk\_WindowsHotkeys.ahkv2')) -Quiet;"" ", 0, True


' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     _WindowsHotkeys_NonAdmin
'
'   Trigger:
'     At log on
'
'   Action:
'     Program/script:   C:\Windows\System32\wscript.exe
'     Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\_WindowsHotkeys_NonAdmin.vbs"
'
'   Run only when user is logged on (CHECKED)
'   Run with highest privileges (UN-CHECKED)
'
'
' ------------------------------------------------------------
'
' Citation(s)
'
'   www.autohotkey.com  |  "Autohotkey Version 2 Downloads"  |  https://www.autohotkey.com/download/2.0/
'
' ------------------------------------------------------------