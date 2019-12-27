# ------------------------------------------------------------

$Logfile = (("${HOME}\Desktop\Logon-Logoffs")+(${Env:COMPUTERNAME})+("_")+(Get-Date -UFormat "%Y-%m-%d_%H-%M-%S")+(".log"));

$AllLogTimestamps = @();

$EID_Logon = 4624; #(Security event)
$EID_Logoff = 4647; #(Security event)
$EID_Startup = 6005; #(System event)
$EID_Winlogon_AuthStopped = 2; #(Winlogon authentication started event)
$EID_Winlogon_AuthStarted = 1; #(Winlogon authentication started event)
$EID_Winlogon_WSearchLogoff = 6000; #(Winlogon logoff event)
$EID_RDP_Reconnect = 4778; #(Security event)
$EID_RDP_Disconnect = 4779; #(Security event)
$EID_Locked = 4800; #(Security event)
$EID_Unlocked = 4801; #(Security event)

# ------------------------------------------------------------

$GetDate_ThreeWeeksAgoMonday = (Get-Date 0:0).AddDays(-21 + ([Int](Get-Date).DayOfWeek * -1) + 1);
$StartTime = ${GetDate_ThreeWeeksAgoMonday};
$EndTime = ((${StartTime}).AddDays(21));

# $EndTime = ((Get-Date).AddDays(-3));
# $StartTime = ((${EndTime}).AddDays(-16));

# ------------------------------------------------------------

$Regex_User = "\s+Account Name:\s+${Env:USERNAME}";
$Regex_Domain = "\s+Account Domain:\s+${Env:USERDOMAIN}";
$Regex_UnlockPC = "\s*Logon Type:\s+7";
$Regex_LogoffInteractive = "\s*Logon Type:\s+2";

# ------------------------------------------------------------
# LOGON CATCH 1

Get-WinEvent -FilterHashtable @{
	LogName='Security';
	ProviderName='Microsoft-Windows-Security-Auditing';
	ID=${EID_Logon};
	StartTime=${StartTime};
	EndTime=${EndTime};
} | Foreach-Object {
	If (($_.Message -match $Regex_User) -And ($_.Message -match $Regex_Domain) -And ($_.Message -match $Regex_UnlockPC)) {
		$AllLogTimestamps += ((Get-Date -Date ($_.TimeCreated.DateTime) -UFormat "%Y-%m-%d (%a)  %H:%M:%S")+("      !!!!!!! Login !!!!!!!"));
	}
}

# ------------------------------------------------------------
# LOGON CATCH 2

$PreviousEvent_ID = $Null;
$PreviousEvent_DateTime = $Null;
Get-WinEvent -FilterHashtable @{
	LogName='Microsoft-Windows-Winlogon/Operational';
	ProviderName='Microsoft-Windows-Winlogon';
	StartTime=${StartTime};
	EndTime=${EndTime};
} | Foreach-Object {
	If ( `
		(($_.ID -eq ${EID_Winlogon_AuthStarted}) -Or ($_.ID -eq ${EID_Winlogon_AuthStopped})) `
			-And `
		(($PreviousEvent_ID -ne ${EID_Winlogon_AuthStarted}) -And ($PreviousEvent_ID -ne ${EID_Winlogon_AuthStopped})) `
			-And `
		($_.TimeCreated.DateTime -eq ${PreviousEvent_DateTime}) `
	) {
		$AllLogTimestamps += ((Get-Date -Date ($_.TimeCreated.DateTime) -UFormat "%Y-%m-%d (%a)  %H:%M:%S")+("      !!!!!!! Login !!!!!!!"));
	}
	$PreviousEvent_ID = $_.ID;
	$PreviousEvent_DateTime = $_.TimeCreated.DateTime;
}

# ------------------------------------------------------------
# LOGOFF CATCH 1
Get-WinEvent -FilterHashtable @{
	LogName='Security';
	ProviderName='Microsoft-Windows-Security-Auditing';
	ID=${EID_Logoff};
	StartTime=${StartTime};
	EndTime=${EndTime};
} | Foreach-Object {
	If (($_.Message -match $Regex_User) -And ($_.Message -match $Regex_Domain)) {
		$AllLogTimestamps += ((Get-Date -Date ($_.TimeCreated.DateTime) -UFormat "%Y-%m-%d (%a)  %H:%M:%S")+("      xxxxxxx Logout xxxxxxxx"));
	}
}

# ------------------------------------------------------------
# LOGOFF CATCH 2
Get-WinEvent -FilterHashtable @{
	LogName='Application';
	ID=${EID_Winlogon_WSearchLogoff};
	StartTime=${StartTime};
	EndTime=${EndTime};
} | Foreach-Object {
	$AllLogTimestamps += ((Get-Date -Date ($_.TimeCreated.DateTime) -UFormat "%Y-%m-%d (%a)  %H:%M:%S")+("      xxxxxxx Logout xxxxxxxx"));
}


# ------------------------------------------------------------

"------------------------------------------------------------";

$FinalOutput = ($AllLogTimestamps | Select-Object -Unique | Sort-Object);

$FinalOutput >> ("${Logfile}");

Start ("${Logfile}");


# ------------------------------------------------------------
#
# Citation(s)
#
#	docs.microsoft.com  |  Get-WinEvent  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.diagnostics/Get-WinEvent
#
# ------------------------------------------------------------