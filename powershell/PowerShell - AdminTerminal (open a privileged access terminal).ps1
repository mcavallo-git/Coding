

# Determine if Session is running as an Administrator
Function  {
	$ReturnedVal = $Null;
	$RuntimeIdentity = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent());
	$AdminRole = ([Security.Principal.WindowsBuiltInRole]"Administrator");
	If ($RuntimeIdentity.IsInRole($AdminRole)) {
		$ReturnedVal = $True;
	} Else {
		$ReturnedVal = $False;
	}
	Return $ReturnedVal;
}

Write-Host (("RuntimeIsPrivileged ? [")+(RuntimeIsPrivileged)+("]"));
Start-Sleep 3;

# Determine if the runtime user is part of the "Administrators" security identifier, "S-1-5-32-544"
#		--> Note: This is what happens a user right-clicks & selects "Run as Administrator" on a given executable in Windows
$Owners = @{};
# [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")
([System.Security.Principal.WindowsIdentity]::GetCurrent()).Groups.Value.Contains("S-1-5-32-544")
(([System.Security.Principal.WindowsIdentity]::GetCurrent()).Owner -eq "S-1-5-32-544")

([System.Security.Principal.WindowsIdentity]::GetCurrent()).Groups

([System.Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(([Security.Principal.WindowsBuiltInRole]"Administrator"))
[Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()

Function RunningAsAdministratorUserGroup {
	$ReturnedVal = $Null;
	$RuntimeIdentity = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent());
	$AdminRole = ([Security.Principal.WindowsBuiltInRole]"Administrator");
	If ($RuntimeIdentity.IsInRole($AdminRole)) {
		$ReturnedVal = $True;
	} Else {
		$ReturnedVal = $False;
	}
	Return $ReturnedVal;
}

# Relaunch the script with administrator privileges
Function AdminTerminal {
	If ((RuntimeIsPrivileged) -eq $False) {
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
#		docs.microsoft.com
#			"WindowsPrincipal.IsInRole Method"
#			 https://docs.microsoft.com/en-us/dotnet/api/system.security.principal.windowsprincipal.isinrole?view=netframework-4.8
#
#		github.com
#			"Windows 10 Initial Setup Script"
#			 https://github.com/Disassembler0/Win10-Initial-Setup-Script
#
