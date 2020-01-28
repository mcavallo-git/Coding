

$Logfile = "${Home}\Desktop\InstalledProgramHistory_$($(${Env:USERNAME}).Trim())@$($(${Env:COMPUTERNAME}).Trim())" + $(If(${Env:USERDNSDOMAIN}){Write-Output ((".") + ($(${Env:USERDNSDOMAIN}).Trim()))}) +"_$(Get-Date -UFormat '%Y%m%d-%H%M%S').log;"; `
Get-EventLog -LogName "Application" -Source "MsiInstaller" `
| Select-Object UserName, TimeGenerated, Message `
| Where-Object {$_.Message -NotLike "*Product: Config Manager -- Installation completed successfully.*"} `
| Where-Object {$_.Message -NotLike "*IGNORE_A*"} `
| Where-Object {$_.Message -NotLike "*IGNORE_A*"} `
| Where-Object {$_.Message -Like "*MATCH_A*"} `
| Where-Object {$_.Message -Like "*MATCH_B*"} `
| Format-Table -AutoSize `
| Out-File -Width 16384 "${Logfile}"; `
Notepad "${Logfile}";



# NOTE: Event Log will only go back as far as the space alloted for which its log-files.


# ------------------------------------------------------------
#
# Citation(s)
#
#   answers.microsoft.com  |  "Why is my event log so small? - Microsoft Community"  |  https://answers.microsoft.com/en-us/windows/forum/all/why-is-my-event-log-so-small/d6654890-0450-4dfc-ba49-95a7f9b63009
#
#   docs.microsoft.com  |  "Get-EventLog - Gets the events in an event log, or a list of the event logs, on the local computer or remote computers"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-eventlog
#
#   stackoverflow.com  |  "eventviewer - How to filter windows event log with wildcard? - Server Fault"  |  https://serverfault.com/a/840387
#
#   stackoverflow.com  |  "Windows Event Log, can you xpath filter for string NOT equal? - Stack Overflow"  |  https://stackoverflow.com/a/51140552
#
# ------------------------------------------------------------