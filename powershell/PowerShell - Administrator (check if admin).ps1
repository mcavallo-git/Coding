<# Check whether-or-not the current PowerShell session is running with elevated privileges (as Administrator) #>
If (!([Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	<# Script is >> NOT << running as admin  -->  Check whether-or-not the current user is able to escalate their own PowerShell terminal to run with elevated privileges (as Administrator) #>
	$LocalAdmins = (([ADSI]"WinNT://./Administrators").psbase.Invoke('Members') | % {([ADSI]$_).InvokeGet('AdsPath')});
	$CurrentUser = (([Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())).Identities.Name);
	$CurrentUserWinNT = ("WinNT://$($CurrentUser.Replace("\","/"))");
	If (($LocalAdmins.Contains($CurrentUser)) -Or ($LocalAdmins.Contains($CurrentUserWinNT))) {
		$CommandString = $MyInvocation.MyCommand.Name;
		$PSBoundParameters.Keys | ForEach-Object { $CommandString += " -$_"; If (@('String','Integer','Double').Contains($($PSBoundParameters[$_]).GetType().Name)) { $CommandString += " `"$($PSBoundParameters[$_])`""; } };
		Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -Command `"$($CommandString)`"" -Verb RunAs;
	} Else {
		Write-Host "Error:  User lacks sufficient privilege to perform privilege escalation (e.g. cannot run as admin)" -BackgroundColor Black -ForegroundColor Red;
	}
} Else {
	<# Script >> IS << running as Admin - Continue #>
	Write-Host "Info:  Script running with Admin rights - Continuing...";
}
