

$Logfile = "${Home}\Desktop\InstalledProgramHistory_$($(${Env:USERNAME}).Trim())@$($(${Env:COMPUTERNAME}).Trim())" + $(If(${Env:USERDNSDOMAIN}){Write-Output ((".") + ($(${Env:USERDNSDOMAIN}).Trim()))}) +"_$(Get-Date -UFormat '%Y%m%d-%H%M%S').log;"; `
Get-EventLog -LogName "Application" -Source "MsiInstaller" `
| Where-Object {$_.Message -NotLike "*EXCLUDE_THIS*"} `
| Where-Object {$_.Message -like "*INCLUDE_THIS*"} `
| Format-Table -AutoSize `
| Out-File -Width 16384 "${Logfile}"; `
Notepad "${Logfile}";



# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-EventLog - Gets the events in an event log, or a list of the event logs, on the local computer or remote computers"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-eventlog
#
#   stackoverflow.com  |  "eventviewer - How to filter windows event log with wildcard? - Server Fault"  |  https://serverfault.com/a/840387
#
#   stackoverflow.com  |  "Windows Event Log, can you xpath filter for string NOT equal? - Stack Overflow"  |  https://stackoverflow.com/a/51140552
#
# ------------------------------------------------------------