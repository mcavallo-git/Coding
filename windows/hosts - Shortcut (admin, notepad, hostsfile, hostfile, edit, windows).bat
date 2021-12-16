REM ------------------------------------------------------------


REM
REM   Edit hostsfile in:  [  Notepad ]  (AS ADMIN)
REM
PowerShell -NoProfile "Start-Process -FilePath 'C:\Windows\System32\notepad.exe' -ArgumentList 'C:\Windows\System32\drivers\etc\hosts' -Verb 'RunAs';"


REM
REM   Edit hostsfile in:  [  Notepad++ ]  (AS ADMIN)
REM
PowerShell -NoProfile "If (Test-Path 'C:\Program Files\Notepad++\notepad++.exe') { SV NP_PATH 'C:\Program Files\Notepad++\notepad++.exe'; } ElseIf (Test-Path 'C:\Program Files (x86)\Notepad++\notepad++.exe') { SV NP_PATH 'C:\Program Files (x86)\Notepad++\notepad++.exe'; } Else { SV NP_PATH 'C:\Windows\System32\notepad.exe'; }; Start-Process -FilePath ((GV NP_PATH).Value) -ArgumentList 'C:\Windows\System32\drivers\etc\hosts' -Verb 'RunAs';"


REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   docs.microsoft.com  |  "Start-Process (Microsoft.PowerShell.Management) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process
REM
REM ------------------------------------------------------------