
# Check whether-or-not the current PowerShell session is running with elevated privileges (as Administrator)
If (!([Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {

	# Check whether-or-not the current user is able to escalate their own PowerShell terminal to run with elevated privileges (as Administrator)
	$LocalAdmins = (([ADSI]"WinNT://./Administrators").psbase.Invoke('Members') | % {([ADSI]$_).InvokeGet('AdsPath')});
	$UserHasAdminRights = If (($LocalAdmins.Contains(([Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())).Identities.Name)) -Or ($LocalAdmins.Contains("WinNT://$($CurrentUser.Replace("\","/"))"))) { $True } Else { $False };
	If (${UserHasAdminRights} -Eq $True) {
		# Script is >> NOT << running as admin  --> Attempt to open an admin terminal with the same command-line arguments as the current
		$CommandString = $MyInvocation.MyCommand.Name;
		$PSBoundParameters.Keys | ForEach-Object { $CommandString += " -$_"; If (@('String','Integer','Double').Contains($($PSBoundParameters[$_]).GetType().Name)) { $CommandString += " `"$($PSBoundParameters[$_])`""; } };
		Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -Command `"$($CommandString)`"" -Verb RunAs;
	} Else {
		Write-Host "Error:  User lacks sufficient privilege to perform privilege escalation (cannot run as admin)" -BackgroundColor Black -ForegroundColor Red;

	}

} Else {
	# Script >> IS << running as Admin - Continue
	Write-Host "Info:  Script running with Admin rights - Continuing...";


}

