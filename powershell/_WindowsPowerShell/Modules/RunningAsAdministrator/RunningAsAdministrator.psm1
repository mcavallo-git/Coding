# ------------------------------------------------------------
# @RunningAsAdministrator
#   |--> Determine if Runtime-User is an Administrator
#     |--> The SID (Security Identifier) value "S-1-5-32-544" refers to the "Administrator" user, and is static across Windows installs
#     |--> This is what happens a user right-clicks & selects "Run as Administrator" on a given executable in Windows
#
Function RunningAsAdministrator {
	Param(
	)
	$ReturnedVal = $Null;
	$AdminSID = "S-1-5-32-544";
	$AdminRole = ([Security.Principal.WindowsBuiltInRole]"Administrator");
	$RuntimeUser = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent());
	$RuntimeSessionOwner = (([System.Security.Principal.WindowsIdentity]::GetCurrent()).Owner);
	If (($RuntimeUser.IsInRole($AdminRole)) -Or ($RuntimeSessionOwner -eq $AdminSID)) {
		$ReturnedVal = $True;
	} Else {
		$ReturnedVal = $False;
	}
	Return $ReturnedVal;
}
Export-ModuleMember -Function "RunningAsAdministrator";


# ------------------------------------------------------------
#
#	Citation(s)
#
#		github.com  |  "Windows 10 Initial Setup Script"  |  https://github.com/Disassembler0/Win10-Initial-Setup-Script
#
#		p0w3rsh3ll.wordpress.com  |  "Any (documented) ADSI changes in PowerShell 5.0?"  |  https://p0w3rsh3ll.wordpress.com/2016/06/14/any-documented-adsi-changes-in-powershell-5-0/
#
# ------------------------------------------------------------