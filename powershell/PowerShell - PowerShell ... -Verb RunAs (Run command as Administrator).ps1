Start-Process "${ENV:ProgramFiles}\AutoHotkey-v2\AutoHotkeyU64.exe" "${ENV:USERPROFILE}\Documents\GitHub\Coding\ahk\_WindowsHotkeys.ahkv2" -Verb RunAs;

PowerShell -Command "Start-Process -Filepath ('C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe') -ArgumentList ('-Command SV ProgressPreference SilentlyContinue; If ((GCM choco -ErrorAction SilentlyContinue) -Eq ((GV null).Value)) { Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString((Write-Output https://chocolatey.org/install.ps1))); }') -Verb RunAs -Wait -PassThru | Out-Null;";


PowerShell -Command "If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; Start-Process -Filepath ((GV PS).Value) -ArgumentList ('-Command SV ProgressPreference SilentlyContinue; If ((GCM choco -ErrorAction SilentlyContinue) -Eq ((GV null).Value)) { Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString((Write-Output https://chocolatey.org/install.ps1))); }') -Verb RunAs -Wait -PassThru | Out-Null;";
