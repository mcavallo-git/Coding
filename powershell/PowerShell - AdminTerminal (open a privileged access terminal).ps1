

# Determine if runtime user is a privilged user (or not)
Function RuntimeUserIsPrivileged {
	$ReturnedVal = $Null;
	If (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
		$ReturnedVal = $True;
	} Else {
		$ReturnedVal = $False;
	}
	Return $ReturnedVal;
}

Write-Host (("RuntimeUserIsPrivileged ? [")+(RuntimeUserIsPrivileged)+("]"));
Start-Sleep 3;

# Relaunch the script with administrator privileges
Function AdminTerminal {
	If ((RuntimeUserIsPrivileged) -eq $False) {
		Write-Host "Opening Privileged-Access Terminal...";
		Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -Verb RunAs;
		Start-Sleep 10;
		Exit;
	} Else {
		Write-Host "Admin required by non-existent";
	}
}


# Run the function
AdminTerminal;

Start-Sleep 10;

#
#	Citation(s)
#
#		github.com, "Windows 10 Initial Setup Script"
#			https://github.com/Disassembler0/Win10-Initial-Setup-Script
#
