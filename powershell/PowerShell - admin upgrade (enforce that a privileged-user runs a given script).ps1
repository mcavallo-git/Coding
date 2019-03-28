

# Determine if runtime user is a privilged user (or not)
Function RuntimeUserIsPrivileged {
	Param (

	)
	$ReturnedVal;
	If (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
		$ReturnedVal = $true;
	} Else {
		$ReturnedVal = $false;
	}
	Return $ReturnedVal;
}



# Relaunch the script with administrator privileges
Function RelaunchScriptAsAdmin {
	If (RuntimeUserIsPrivileged -eq $true) {
		Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -Verb RunAs;
		Exit;
	} Else {
		Write-Host "Admin required by non-existent";
	}
}


# Run the function
RelaunchScriptAsAdmin;


#
#	Citation(s)
#
#		github.com, "Windows 10 Initial Setup Script"
#			https://github.com/Disassembler0/Win10-Initial-Setup-Script
#
