
<# Generate a list of all ".msi" file installation attempts - Note that Event Log will only go back as far as the space allows for regarding logfile storage-space #> 
If ($True) {
	<# Replace with general event-viewer search string to match-on, then narrow it down as needed (e.g. you can search for ".msi" to show for installed MSI packages, etc.) #>
	$MatchText_1 = "*Windows Installer*";
	$MatchText_2 = "*.msi*";
	<# Replace with specific text to exclude if-found in the log #>
	$ExcludeText_1 = "EXCLUDE / IGNORE LINES THAT MATCH THIS TEXT";
	$ExcludeText_2 = "ALSO EXCLUDE / IGNORE LINES THAT MATCH THIS TEXT";
	<# Parse ALL the logs! #>
	$Logfile = "${Home}\Desktop\InstalledProgramHistory_$($(${Env:USERNAME}).Trim())@$($(${Env:COMPUTERNAME}).Trim())" + $(If(${Env:USERDNSDOMAIN}){Write-Output ((".") + ($(${Env:USERDNSDOMAIN}).Trim()))}) +"_$(Get-Date -UFormat '%Y%m%d-%H%M%S').log;"; `
	$EventLogs_MsiInstallAttempts = ( `
		Get-EventLog -LogName "Application" -Source "MsiInstaller" `
			| Select-Object UserName, TimeGenerated, Message `
			| Where-Object {$_.Message -NotLike "${ExcludeText_1}"} `
			| Where-Object {$_.Message -NotLike "${ExcludeText_2}"} `
			| Where-Object {$_.Message -Like "${MatchText_1}"} `
			| Where-Object {$_.Message -Like "${MatchText_2}"} `
	 );
	<# Output the logs to target logfile #>
	$EventLogs_MsiInstallAttempts `
		| Format-Table -AutoSize `
		| Out-File "${Logfile}";
	<# Open the log in Notepad for viewing #>
	Notepad "${Logfile}";
}


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