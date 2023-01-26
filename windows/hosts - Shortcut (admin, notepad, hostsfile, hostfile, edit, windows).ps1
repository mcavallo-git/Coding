# ------------------------------------------------------------
# hosts - Shortcut (admin, notepad, hostsfile, hostfile, edit, windows)
# ------------------------------------------------------------

#
#   Edit hostsfile in:  [  Notepad ]  (AS ADMIN)
#
PowerShell -NoProfile "Start-Process -FilePath 'C:\Windows\System32\notepad.exe' -ArgumentList 'C:\Windows\System32\drivers\etc\hosts' -Verb 'RunAs';"


#
#   Edit hostsfile in:  [  Notepad++ ]  (AS ADMIN)
#
PowerShell -NoProfile "If (Test-Path 'C:\Program Files\Notepad++\notepad++.exe') { SV NP_PATH 'C:\Program Files\Notepad++\notepad++.exe'; } ElseIf (Test-Path 'C:\Program Files (x86)\Notepad++\notepad++.exe') { SV NP_PATH 'C:\Program Files (x86)\Notepad++\notepad++.exe'; } Else { SV NP_PATH 'C:\Windows\System32\notepad.exe'; }; Start-Process -FilePath ((GV NP_PATH).Value) -ArgumentList 'C:\Windows\System32\drivers\etc\hosts' -Verb 'RunAs';"


# ------------------------------------------------------------
#
# Note:  To block an FQDN via the hostsfile, use up address "0.0.0.0" and not "127.0.0.1" (which could bombard any local server(s) you have running)
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   learn.microsoft.com  |  "Start-Process (Microsoft.PowerShell.Management) - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process
#
#   superuser.com  |  "networking - Better to block a host to 0.0.0.0 than to 127.0.0.1? - Super User"  |  https://superuser.com/a/1345088
#
#   support.microsoft.com  |  "How to reset the Hosts file back to the default - Microsoft Support"  |  https://support.microsoft.com/en-us/topic/c2a43f9d-e176-c6f3-e4ef-3500277a6dae
#
# ------------------------------------------------------------