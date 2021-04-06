# ------------------------------------------------------------
#
# PowerShell - Update hostname & join machine to target Active Directory (AD) Domain
#
If ($True) {
	$ValidHostname = $False;
	While ($ValidHostname -Eq $False) {
		$New_Hostname = Read-Host -Prompt "Enter Hostname for this device (characters allowed: alphanumeric & dashes, max length: 15)";
		$New_Domain = Read-Host -Prompt "Enter Domain (Active Directory to join)";
		$AD_Credential_Username = Read-Host -Prompt "Enter username (without domain) for user on the `"${New_Domain}`" domain";

		$Regex_NetBiosHostname = "^(([A-Za-z0-9]|([A-Za-z0-9][A-Za-z0-9\-]))*[A-Za-z0-9])$";
		$Needle = [Regex]::Match($New_Hostname, $Regex_NetBiosHostname);
		If ($New_Hostname.Length -GE 16) {
			Write-Host "Error:  Hostname must be 15 characters or less - `"${New_Hostname}`" found to be $(${New_Hostname}.Length) characters";
		} ElseIf ($Needle.Success -Eq $False) {
			Write-Host "Error:  Hostname `"${New_Hostname}`" contains 1 or more invalid characters - please use only alphanumeric (A-Z, a-z, 0-9) and, if-desired, dashes `"-`" which must be preceeded and followed immediately by an alphanumeric characeter";
		} Else {
			Try {
				Rename-Computer -NewName "${New_Hostname}" -DomainCredential "${New_Domain}\${AD_Credential_Username}" -Force;
				Add-Computer -DomainMame "${New_Domain}" -DomainCredential "${New_Domain}\${AD_Credential_Username}" -Restart –Force
				Write-Host "";
				Write-Host "Device renamed to hostname `"${New_Hostname}`"";
				Write-Host "Device joined on domain `"${New_Domain}`"";
				$ValidHostname = $True;
			} Catch {
				Write-Host "";
				Write-Host -NoNewLine "Error:  ";
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


# ------------------------------------------------------------
#
#	PowerShell - Join VM to Active Directory
#

Add-Computer -DomainName ("${Domain_Name}") -OUPath ("${OU_Path}") -Credential (New-Object System.Management.Automation.PSCredential(("${Domain_Name}\${Username_Plaintext}"),(ConvertTo-SecureString -String ("${Userpass_Plaintext}") -AsPlainText -Force))); Restart-Computer -Force;



# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Add-Computer - Add the local computer to a domain or workgroup."  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/add-computer?view=powershell-5.1
#
#   docs.microsoft.com  |  "Rename-Computer - Renames a computer"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/rename-computer?view=powershell-5.1
#
#		support.microsoft.com | "Naming conventions in Active Directory for computers, domains, sites, and OUs" | https://support.microsoft.com/en-us/help/909264/naming-conventions-in-active-directory-for-computers-domains-sites-and
#
#		www.petri.com | "Add Computers to a Domain with PowerShell" | https://www.petri.com/add-computer-to-domain-powershell
#
#		www.regextester.com | "Match a valid hostname" | https://www.regextester.com/23
#
# ------------------------------------------------------------