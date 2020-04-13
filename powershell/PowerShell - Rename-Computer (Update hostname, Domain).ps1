# ------------------------------------------------------------
#
# PowerShell - Update hostname & join device to target AD
#
# ------------------------------------------------------------

If ($True) {
	$ValidHostname = $False;
	While ($ValidHostname -Eq $False) {
		$New_Hostname = Read-Host -Prompt "Enter Hostname for this device:  ";
		$New_Domain = Read-Host -Prompt "Enter Domain (Active Directory to join):  ";
		$AD_Credential_Username = Read-Host -Prompt "Enter username (without domain) for user on the `"${New_Domain}`" domain:  ";

		$Regex_NetBiosHostname = "^(([A-Za-z0-9]|([A-Za-z0-9][A-Za-z0-9\-]))*[A-Za-z0-9])$";
		$Needle = [Regex]::Match($New_Hostname, $Regex_NetBiosHostname);
		If ($Needle.Success -Eq $False) {
			Write-Host " Hostname `"${New_Hostname}`" contains 1 or more invalid characters - please use only alphanumeric (A-Z, a-z, 0-9) and, if-desired, dashes `"-`" which must be preceeded and followed immediately by an alphanumeric characeter";
		} ElseIf ($Needle.Success -Eq $False) {
			Write-Host " Hostname `"${New_Hostname}`" contains 1 or more invalid characters - please use only alphanumeric (A-Z, a-z, 0-9) and, if-desired, dashes `"-`" which must be preceeded and followed immediately by an alphanumeric characeter";
		} Else {
			Try {
				Rename-Computer -NewName "${New_Hostname}" -DomainCredential "${New_Domain}\${AD_Credential_Username}" -Force;
				Write-Host "";
				Write-Host "Device renamed to hostname `"${New_Hostname}`" on domain `"${New_Domain}`"";
				$ValidHostname = $True;
			} Catch {
				Write-Host "";
				Write-Host -NoNewLine "An error occurred: ";
				Write-Host $_ -BackgroundColor "Black" -ForegroundColor "Yellow";
			}
		}
	}
	If ($ValidHostname -Eq $True) {
		# Reboot the machine (only after user presses 'y')
		Write-Host -NoNewLine "`n`n  Restart required - Press 'y' to confirm and reboot this machine, now...`n`n" -BackgroundColor "Black" -ForegroundColor "Yellow";
		$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
		While ($KeyPress.Character -NE "y") {
			$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
		}
		Start-Process -Filepath ("shutdown") -ArgumentList (@("/t 0","/r")) -NoNewWindow -Wait -PassThru;
	}
}


# ### Check Hostname (via regex) before attempting to rename device
# $Regex_NetBiosHostname = "^(([A-Za-z0-9]|([A-Za-z0-9][A-Za-z0-9\-]))*[A-Za-z0-9])$";
# $Needle = [Regex]::Match($New_Hostname, $Regex_NetBiosHostname);
# If ($Needle.Success -Eq $False) {
# 	Write-Host " Hostname `"${New_Hostname}`" contains 1 or more invalid characters - please use only alphanumeric (A-Z, a-z, 0-9) and, if-desired, dashes `"-`" which must be preceeded and followed immediately by an alphanumeric characeter";
# } ElseIf ($Needle.Success -Eq $False) {
# 	Write-Host " Hostname `"${New_Hostname}`" contains 1 or more invalid characters - please use only alphanumeric (A-Z, a-z, 0-9) and, if-desired, dashes `"-`" which must be preceeded and followed immediately by an alphanumeric characeter";
# } Else {
# 	Try {
# 		Rename-Computer -ComputerName "${Env:COMPUTERNAME}" -NewName "${New_Hostname}" -DomainCredential "${New_Domain}\${AD_Credential_Username}" -Force;
# 		Write-Host "Device renamed to hostname `"${New_Hostname}`" on domain `"${New_Domain}`"";
# 	} Catch {
# 		Write-Host -NoNewLine "An error occurred: ";
# 		Write-Host $_ -BackgroundColor "Black" -ForegroundColor "Yellow";
# 	}
# }



# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Rename-Computer - Renames a computer"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/rename-computer?view=powershell-5.1
#
#		regextester.com | "Match a valid hostname" | https://www.regextester.com/23
#
#		support.microsoft.com | "Naming conventions in Active Directory for computers, domains, sites, and OUs" | https://support.microsoft.com/en-us/help/909264/naming-conventions-in-active-directory-for-computers-domains-sites-and
#
# ------------------------------------------------------------