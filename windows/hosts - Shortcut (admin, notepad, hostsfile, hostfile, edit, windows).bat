REM ------------------------------------------------------------


REM notepad.exe - Edit hostsfile  (AS ADMIN)
PowerShell -NoProfile "Start-Process 'C:\Windows\System32\notepad.exe' -ArgumentList 'C:\Windows\System32\drivers\etc\hosts' -Verb 'RunAs';"


REM notepad++.exe - Edit hostsfile  (AS ADMIN)
PowerShell -NoProfile "If (Test-Path C:\Program` Files\Notepad++\notepad++.exe) { Start-Process C:\Program` Files\Notepad++\notepad++.exe -ArgumentList C:\Windows\System32\drivers\etc\hosts -Verb RunAs; } ElseIf (Test-Path C:\Program` Files` `(x86`)\Notepad++\notepad++.exe) { Start-Process C:\Program` Files` `(x86`)\Notepad++\notepad++.exe -ArgumentList C:\Windows\System32\drivers\etc\hosts -Verb RunAs; } Else { Start-Process C:\Windows\System32\notepad.exe -ArgumentList C:\Windows\System32\drivers\etc\hosts -Verb RunAs; };"


REM ------------------------------------------------------------
REM
REM Citation(s)
REM
REM   docs.microsoft.com  |  "Start-Process (Microsoft.PowerShell.Management) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process
REM
REM ------------------------------------------------------------