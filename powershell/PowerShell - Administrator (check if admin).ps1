

# Check whether-or-not the current PowerShell session is running with elevated privileges (admin rights)
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	# Script is NOT running as admin
	#  > Attempt to open an admin terminal with the same command-line arguments as the current
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -Verb RunAs;

} Else {
	# Script IS running as admin - continue
	Write-Host "Info:  Already running with Admin rights - continuing...";

}
