CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy 'RemoteSigned' -Scope 'CurrentUser' -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/EnsureProcessIsRunning/EnsureProcessIsRunning.psm1')); EnsureProcessIsRunning -Name 'Greenshot' -Path 'C:\Program Files\Greenshot\Greenshot.exe' -AsAdmin -Quiet;"" ", 0, True


' Program/script:   C:\Windows\System32\wscript.exe
' Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\GreenshotAsAdmin.vbs"

' Trigger: At log on
