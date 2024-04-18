# ------------------------------------------------------------
# hosts - Shortcut (admin, notepad, hosts file, hostfile, edit, windows)
# ------------------------------------------------------------

# Show hosts file's contents
Get-Content "${env:windir}\System32\drivers\etc\hosts";

# ------------------------------------------------------------

# Open hosts file in Notepad AS ADMIN (for editing)
PowerShell -NoProfile "Start-Process -FilePath 'C:\Windows\System32\notepad.exe' -ArgumentList 'C:\Windows\System32\drivers\etc\hosts' -Verb 'RunAs';"

# Open hosts file in NP++ AS ADMIN (for editing)
PowerShell -NoProfile "If (Test-Path 'C:\Program Files\Notepad++\notepad++.exe') { SV NP_PATH 'C:\Program Files\Notepad++\notepad++.exe'; } ElseIf (Test-Path 'C:\Program Files (x86)\Notepad++\notepad++.exe') { SV NP_PATH 'C:\Program Files (x86)\Notepad++\notepad++.exe'; } Else { SV NP_PATH 'C:\Windows\System32\notepad.exe'; }; Start-Process -FilePath ((GV NP_PATH).Value) -ArgumentList 'C:\Windows\System32\drivers\etc\hosts' -Verb 'RunAs';"

# ------------------------------------------------------------

# Update hosts file - Append a IP+name pair to the hosts file
Add-Content -Path "${env:windir}\System32\drivers\etc\hosts" -Value "`n127.0.0.1`tlocalhost`t${env:COMPUTERNAME}" -Force;


# ------------------------------------------------------------
#
# Note:  To block a FQDN via the hosts file, associated the FQDN with IP address "0.0.0.0" - avoid using "127.0.0.1", as this could bombard any services you have running & listening locally
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