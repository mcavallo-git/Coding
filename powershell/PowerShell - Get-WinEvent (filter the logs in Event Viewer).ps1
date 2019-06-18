# ------------------------------------------------------------

$Logfile = (("${HOME}\Desktop\Logon-Logoffs")+(${Env:COMPUTERNAME})+("_")+(Get-Date -UFormat "%Y-%m-%d_%H-%M-%S")+(".log"));

$AllLogTimestamps = @();

$EID_Logon = 4624; #(Security event)
$EID_Logoff = 4647; #(Security event)
$EID_Startup = 6005; #(System event)
$EID_Winlogon_AuthStarted = 1; #(Winlogon authentication started event)
$EID_Winlogoff = 6000; #(Winlogon logoff event)
$EID_RDP_Reconnect = 4778; #(Security event)
$EID_RDP_Disconnect = 4779; #(Security event)
$EID_Locked = 4800; #(Security event)
$EID_Unlocked = 4801; #(Security event)

$EndTime = ((Get-Date).AddDays(-3));
# $EndTime = (Get-Date -Year 2019 -Month 06 -Day 14 -Hour 23 -Minute 59 -Second 59);
# $EndTime;

$StartTime = ((${EndTime}).AddDays(-16));
# $StartTime = (Get-Date -Year 2019 -Month 06 -Day 04 -Hour 23 -Minute 59 -Second 59);
# $StartTime;

$Regex_User = "\s+Account Name:\s+${Env:USERNAME}";
$Regex_Domain = "\s+Account Domain:\s+${Env:USERDOMAIN}";
$Regex_UnlockPC = "\s*Logon Type:\s+7";
$Regex_LogoffInteractive = "\s*Logon Type:\s+2";

# ------------------------------------------------------------

# Get-WinEvent -FilterHashtable @{
# 	LogName='Security'; ProviderName='Microsoft-Windows-Security-Auditing'; ID=${EID_Logon}; StartTime=${StartTime}; EndTime=${EndTime};
# } | Foreach-Object {
# 	If (($_.Message -match $Regex_User) -And ($_.Message -match $Regex_Domain) -And ($_.Message -match $Regex_UnlockPC)) {
# 		$AllLogTimestamps += ((Get-Date -Date ($_.TimeCreated.DateTime) -UFormat "%Y-%m-%d (%a)  %H:%M:%S")+("      !!!!!!! Login !!!!!!!"));
# 	}
# }

# ------------------------------------------------------------

Get-WinEvent -FilterHashtable @{
	LogName='Microsoft-Windows-Winlogon/Operational'; ProviderName='Microsoft-Windows-Winlogon'; ID=${EID_Winlogon_AuthStarted}; StartTime=${StartTime}; EndTime=${EndTime};
} | Foreach-Object {
	If (($_.Message -match $Regex_User) -And ($_.Message -match $Regex_Domain) -And ($_.Message -match $Regex_UnlockPC)) {
		$AllLogTimestamps += ((Get-Date -Date ($_.TimeCreated.DateTime) -UFormat "%Y-%m-%d (%a)  %H:%M:%S")+("      !!!!!!! Login !!!!!!!"));
		((Get-Date -Date ($_.TimeCreated.DateTime) -UFormat "%Y-%m-%d (%a)  %H:%M:%S")+("      !!!!!!! Login !!!!!!!"));
	}
}

# ------------------------------------------------------------

# Get-WinEvent -FilterHashtable @{
# 	LogName='Security'; ProviderName='Microsoft-Windows-Security-Auditing'; ID=${EID_Logoff}; StartTime=${StartTime}; EndTime=${EndTime};
# } | Foreach-Object {
# 	$_.Message
# 	If (($_.Message -match $Regex_User) -And ($_.Message -match $Regex_Domain)) {
# 		$AllLogTimestamps += ((Get-Date -Date ($_.TimeCreated.DateTime) -UFormat "%Y-%m-%d (%a)  %H:%M:%S")+("      xxxxxxx Logout xxxxxxxx"));
# 	}
# }

# ------------------------------------------------------------

Write-Host "------------------------------------------------------------";

$FinalOutput = ($AllLogTimestamps | Select-Object -Unique | Sort-Object);

$FinalOutput >> ("${Logfile}");

$FinalOutput | Format-List;

Write-Host "------------------------------------------------------------";
Write-Host "------------------------------------------------------------";
Write-Host "------------------------------------------------------------";

($AllLogTimestamps | Select-Object -Unique | Sort-Object);
Write-Host "------------------------------------------------------------";

Start ("${Logfile}");



#
# Citation(s)
#
#	docs.microsoft.com  |  Get-WinEvent  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.diagnostics/Get-WinEvent
#
#