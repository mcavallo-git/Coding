function EnsureSessionIsPrivileged {
	Param(

	)

	# Determine if runtime user is a privilged user (or not)
	$SessionIsPrivileged;
	If (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
		$SessionIsPrivileged = $true;
	} Else {
		$SessionIsPrivileged = $false;
	}

	# Relaunch the script with administrator privileges (if not already running an admin/privileged session)
	If ($SessionIsPrivileged -eq $false) {
		Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -Verb RunAs;
		Exit;

	} Else {
		Write-Host "Admin required for `"$PSCommandPath`"";
		
	}

}

Export-ModuleMember -Function "EnsureSessionIsPrivileged";



# Install-Module -Name "CredentialManager"

#
#	Citation(s)
#
#		github.com, "Windows 10 Initial Setup Script"
#			https://github.com/Disassembler0/Win10-Initial-Setup-Script
#
