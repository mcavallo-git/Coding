
# Check whether-or-not the current PowerShell session is running with elevated privileges (admin rights)
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	# Script is >> NOT << running as admin  --> Attempt to open an admin terminal with the same command-line arguments as the current
	$CommandString = $MyInvocation.MyCommand.Name;
	$PSBoundParameters.Keys | ForEach-Object { $CommandString += " -$_"; If (@('String','Integer','Double').Contains($($PSBoundParameters[$_]).GetType().Name)) { $CommandString += " `"$($PSBoundParameters[$_])`""; } };
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -Command `"$($CommandString)`"" -Verb RunAs;

} Else {
	# Script >> IS << running as Admin - Continue
	Write-Host "Info:  Script running with Admin rights - Continuing...";


}
