# ------------------------------------------------------------
#	@PrivilegeEscalation
# 	|--> Checks if running w/ administrator privileges - If not, relaunch the script with escalated (administrator) privileges
#		|--> Uses sub-module "RunningAsAdministrator"
#		|--> Uses sub-module "UserCanEscalatePrivileges"
#
Function PrivilegeEscalation {
	Param (

		[Parameter(Mandatory=$true)]
		[String]$Command,

		[Switch]$ExitAfter,

		[Switch]$Quiet

	)
	If ((RunningAsAdministrator) -ne ($True)) {
		If ((UserCanEscalatePrivileges) -eq ($True)) {
			If (!($PSBoundParameters.ContainsKey('Quiet'))) {
				Write-Host "`nPrivilegeEscalation  :::  Escalating privileges for command:`n |-->   $($Command)" -BackgroundColor Black -ForegroundColor Green;
			}
			Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -Command `"$($Command)`"" -Verb RunAs;
			# Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$CommandPath`" $CommandArgs" -Verb RunAs;
			If ($PSBoundParameters.ContainsKey('ExitAfter') -Eq $True) {
				Exit;
			}
		} Else {
			If (!($PSBoundParameters.ContainsKey('Quiet'))) {
				Write-Host "`nPrivilegeEscalation  :::  Error (User lacks sufficient privilege to perform escalation)" -BackgroundColor Black -ForegroundColor Red;
			}
		}
	} Else {
		If (!($PSBoundParameters.ContainsKey('Quiet'))) {
			Write-Host "`nPrivilegeEscalation  ::: Skipped (session is already running as Administrator)" -BackgroundColor Black -ForegroundColor Yellow;
		}
	}
}
Export-ModuleMember -Function "PrivilegeEscalation";


# ------------------------------------------------------------
#
#	Citation(s)
#
#		github.com  |  "Windows 10 Initial Setup Script"  |  https://github.com/Disassembler0/Win10-Initial-Setup-Script
#
#		p0w3rsh3ll.wordpress.com  |  "Any (documented) ADSI changes in PowerShell 5.0?"  |  https://p0w3rsh3ll.wordpress.com/2016/06/14/any-documented-adsi-changes-in-powershell-5-0/
#
# ------------------------------------------------------------