# ------------------------------------------------------------

$Logfile = (("${HOME}\Desktop\Logon-Logoffs")+(${Env:COMPUTERNAME})+("_")+(Get-Date -UFormat "%Y-%m-%d_%H-%M-%S")+(".log"));

$AllLogTimestamps = @();

$EndTime = ((Get-Date).AddDays(-3));
# $EndTime = (Get-Date -Year 2019 -Month 06 -Day 14 -Hour 23 -Minute 59 -Second 59);
# $EndTime;

$StartTime = ((${EndTime}).AddDays(-16));
# $StartTime = (Get-Date -Year 2019 -Month 06 -Day 04 -Hour 23 -Minute 59 -Second 59);
# $StartTime;


$Regex_User = "\s+Account Name:\s+${Env:USERNAME}";
$Regex_Domain = "\s+Account Domain:\s+${Env:USERDOMAIN}";
$Regex_LockUnlock = "\s*Logon Type:\s+7";

Get-WinEvent -FilterHashtable @{
	LogName='Security';
	ProviderName='Microsoft-Windows-Security-Auditing';
	ID=4624;
	StartTime=${StartTime};
	# EndTime=${EndTime};
} | Foreach-Object {
	If ( `
		($_.Message -match $Regex_User) `
			-And `
		($_.Message -match $Regex_Domain) `
			-And `
		($_.Message -match $Regex_LockUnlock) `
	) {
			$AllLogTimestamps += ((Get-Date -Date ($_.TimeCreated.DateTime) -UFormat "%Y-%m-%d %H:%M:%S")+(" !!!!!!! Login !!!!!!!"));
			((Get-Date -Date ($_.TimeCreated.DateTime) -UFormat "%Y-%m-%d %H:%M:%S")+(" !!!!!!! Login !!!!!!!"));
	}
}

$Regex_WorkstationLock = "\s*Logon Type:\s+2";
Get-WinEvent -FilterHashtable @{
	LogName='Security';
	ProviderName='Microsoft-Windows-Security-Auditing';
	ID=4634;
	StartTime=${StartTime};
	# EndTime=${EndTime};
} | Foreach-Object {
	If ( `
		($_.Message -match $Regex_User) `
			-And `
		($_.Message -match $Regex_Domain) `
			-And `
		($_.Message -match $Regex_LockUnlock) `
	) {
			$AllLogTimestamps += ((Get-Date -Date ($_.TimeCreated.DateTime) -UFormat "%Y-%m-%d %H:%M:%S")+(" xxxxxxx Logout xxxxxxxx"));
			((Get-Date -Date ($_.TimeCreated.DateTime) -UFormat "%Y-%m-%d %H:%M:%S")+(" xxxxxxx Logout xxxxxxxx"));
	}
}

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
