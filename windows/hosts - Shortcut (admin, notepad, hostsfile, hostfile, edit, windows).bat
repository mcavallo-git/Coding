
REM Open Windows' Hostsfile in Notepad++.exe (fall-back to Notepad.exe)
PowerShell -NoProfile "If (Test-Path C:\Program` Files\Notepad++\notepad++.exe) { Start-Process C:\Program` Files\Notepad++\notepad++.exe -ArgumentList C:\Windows\System32\drivers\etc\hosts -Verb RunAs; } ElseIf (Test-Path C:\Program` Files` `(x86`)\Notepad++\notepad++.exe) { Start-Process C:\Program` Files` `(x86`)\Notepad++\notepad++.exe -ArgumentList C:\Windows\System32\drivers\etc\hosts -Verb RunAs; } Else { Start-Process C:\Windows\System32\notepad.exe -ArgumentList C:\Windows\System32\drivers\etc\hosts -Verb RunAs; };"

REM Open Windows' Hostsfile in Notepad.exe
PowerShell -NoProfile "Start-Process 'C:\Windows\System32\notepad.exe' -ArgumentList 'C:\Windows\System32\drivers\etc\hosts' -Verb 'RunAs';"
