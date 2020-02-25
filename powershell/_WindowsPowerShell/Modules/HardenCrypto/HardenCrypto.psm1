# ------------------------------------------------------------
If ($False) { # RUN THIS SCRIPT ON-THE-FLY:

[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]'Tls11,Tls12'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/HardenCrypto/HardenCrypto.psm1'));

}
# ------------------------------------------------------------
function HardenCrypto {
	Param(
		[Switch]$SkipConfirmation,
		[Switch]$Yes
	)

	<# Check whether-or-not the current PowerShell session is running with elevated privileges (as Administrator) #>
	$RunningAsAdmin = (([Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"));
	If ($RunningAsAdmin -Eq $False) {
		<# Script is >> NOT << running as admin  -->  Check whether-or-not the current user is able to escalate their own PowerShell terminal to run with elevated privileges (as Administrator) #>
		$LocalAdmins = (([ADSI]"WinNT://./Administrators").psbase.Invoke('Members') | % {([ADSI]$_).InvokeGet('AdsPath')});
		$CurrentUser = (([Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())).Identities.Name);
		$CurrentUserWinNT = ("WinNT://$($CurrentUser.Replace("\","/"))");
		If (($LocalAdmins.Contains($CurrentUser)) -Or ($LocalAdmins.Contains($CurrentUserWinNT))) {
			$CommandString = $MyInvocation.MyCommand.Name;
			$PSBoundParameters.Keys | ForEach-Object { $CommandString += " -$_"; If (@('String','Integer','Double').Contains($($PSBoundParameters[$_]).GetType().Name)) { $CommandString += " `"$($PSBoundParameters[$_])`""; } };
			Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -Command `"$($CommandString)`"" -Verb RunAs;
		} Else {
			Write-Host "`n`nError:  Insufficient privileges, unable to escalate (e.g. unable to run as admin)`n`n" -BackgroundColor Black -ForegroundColor Yellow;
		}
	} Else {
		<# Script >> IS << running as Admin - Continue #>



		$SkipConfirm = $False;
		If ($PSBoundParameters.ContainsKey('Yes') -Eq $True) {
			$SkipConfirm = $True;
		} ElseIf ($PSBoundParameters.ContainsKey('SkipConfirmation') -Eq $True) {
			$SkipConfirm = $True;
		}

		If ($SkipConfirm -Eq $False) {
			#
			# First Confirmation - Confirm via "Are you sure ... ?" (Default)
			#
			$ConfirmKeyList = "abcdefghijklmopqrstuvwxyz"; # removed 'n'
			$FirstConfKey = (Get-Random -InputObject ([char[]]$ConfirmKeyList));
			Write-Host -NoNewLine ("`n");
			Write-Host -NoNewLine ("$($MyInvocation.MyCommand.Name) - Confirm: Do you want to harden the crypto of this box (will set to allow only TLS v1.1 and TLS v1.2 requests outgoing/incoming)?") -BackgroundColor "Black" -ForegroundColor "Yellow";
			Write-Host -NoNewLine ("`n`n");
			Write-Host -NoNewLine ("$($MyInvocation.MyCommand.Name) - Confirm: Press the `"") -ForegroundColor "Yellow";
			Write-Host -NoNewLine ($FirstConfKey) -ForegroundColor "Green";
			Write-Host -NoNewLine ("`" key to if you are sure:  ") -ForegroundColor "Yellow";
			$UserKeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'); Write-Host (($UserKeyPress.Character)+("`n"));
			$FirstConfirm = (($UserKeyPress.Character) -eq ($FirstConfKey));
		}
		If (($FirstConfirm -Eq $True) -Or ($SkipConfirm -Eq $True)) {

			# ------------------------------------------------------------
			#
			# PowerShell - ServicePointManager.SecurityProtocol (defines SSL-TLS protocol(s) used by PowerShell)
			#
			# ------------------------------------------------------------
			#
			# Original Error(s):
			###   Exception calling "DownloadString" with "1" argument(s): "The request was aborted: Could not create SSL/TLS secure channel."
			###   Exception calling "DownloadString" with "1" argument(s): "The underlying connection was closed: An unexpected error occurred on a receive."
			#
			# Original Command (which caused error):
			###  ($(New-Object Net.WebClient).DownloadString("https://ps.mcavallo.com/ps?t=$((Date).Ticks)"))
			#
			# Original Environment:
			###  Fresh format of Windows Server 2016 Standard v1607
			#
			#
			# ------------------------------------------------------------
			#
			# Add a system-wide registry key (e.g. via group policy) which causes .NET to use the “System Default” TLS version(s)
			#   |--> Adds TLS 1.2 as an available protocol
			#   |--> Allows scripts to use future TLS Versions when the OS supports them (e.g. TLS 1.3)
			#
			# 
			#   |--> Both basic security logic, as well as general best practice (see citations, below) recommend to set both the 64-bit registry (default target via New-ItemProperty) as well as the 32-bit registry so that processes running web requests use the user-defined request protocols, as-intended
			#

			<# ============================== #>
			<# Locate the .NET Framework v4 key to modify #> 
			$Key_DotNet4 = (Get-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0*');
			$HKLM_DotNet4 = ("SOFTWARE\Microsoft\.NETFramework\$($Key_DotNet4.PSChildName)");

			<# Update the 64-bit registry #>
			$Registry_64bit = ([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, [Microsoft.Win32.RegistryView]::Registry64));  <# Methods which update registry keys such as  [ New-ItemProperty ... ]  often only update the 64bit registry (by default) #>
			$SubKey_64bit = $Registry_64bit.OpenSubKey("${HKLM_DotNet4}", $True);  <# Retrieve the specified subkey for read/write access (argument #2 == $True) #>
			$SubKey_64bit.SetValue("SystemDefaultTlsVersions", 1, 4);  <# Update the key #> <# DWords' native RegistryValueKind is 4 #>
			$SubKey_64bit.Close();  <# Close the key & flush it to disk (if its contents have been modified) #>

			<# Update the 32-bit registry #>
			$Registry_32bit = ([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, [Microsoft.Win32.RegistryView]::Registry32));  <# Methods which update registry keys such as  [ New-ItemProperty ... ]  often only update the 64bit registry (by default) #>
			$SubKey_32bit = $Registry_32bit.OpenSubKey("${HKLM_DotNet4}", $True);  <# Retrieve the specified subkey for read/write access (argument #2 == $True) #>
			$SubKey_32bit.SetValue("SystemDefaultTlsVersions", 1, 4);  <# Update the key #> <# DWords' native RegistryValueKind is 4 #>
			$SubKey_32bit.Close();  <# Close the key & flush it to disk (if its contents have been modified) #>


			<# Grant additional user(s) access rights onto this, specific, key #>
			If ($False) {
				<# Get the registry key's access controls #>
				$KeyAccess_64bit = ($Registry_64bit.OpenSubKey("${HKLM_DotNet4}", [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, [System.Security.AccessControl.RegistryRights]::ChangePermissions));
				$KeyAccess_32bit = ($Registry_32bit.OpenSubKey("${HKLM_DotNet4}", [Microsoft.Win32.RegistryKeyPermissionCheck]::ReadWriteSubTree, [System.Security.AccessControl.RegistryRights]::ChangePermissions));
					<# Prep the updated access rules/controls #>
					$AccessControl_64bit = $KeyAccess_64bit.GetAccessControl();
					$AccessControl_32bit = $KeyAccess_32bit.GetAccessControl();
						<# Grant current-user (self) full control over targeted registry key(s) (required to modify many system registry keys) #>
						$RegistryAccessRule = New-Object System.Security.AccessControl.RegistryAccessRule("${Env:USERDOMAIN}\${Env:USERNAME}","FullControl","Allow");
					$AccessControl_64bit.SetAccessRule($RegistryAccessRule);
					$AccessControl_32bit.SetAccessRule($RegistryAccessRule);
				<# Apply the updated access rules/controls #>
				$KeyAccess_64bit.SetAccessControl($AccessControl_64bit);
				$KeyAccess_32bit.SetAccessControl($AccessControl_32bit);
				<# Close the key & flush it to disk (if its contents have been modified) #>
				$KeyAccess_64bit.Close();
				$KeyAccess_32bit.Close();
			}

			<# [Protocols] Disable SSL 2.0 #>
			New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server';  <# Incoming Connections - IIS/FTP Server(s) #>
			New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client';  <# Outgoing Connections, such as PowerShell calls #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server' -Name 'Enabled' -Value 0 –PropertyType 'DWORD';            <# Disabled #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server' -Name 'DisabledByDefault' -Value 1 –PropertyType 'DWORD';  <# Disabled #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client' -Name 'Enabled' -Value 0 –PropertyType 'DWORD';            <# Disabled #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client' -Name 'DisabledByDefault' -Value 1 –PropertyType 'DWORD';  <# Disabled #>
			<# [Protocols] Disable SSL 3.0 #>
			New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server';  <# Incoming Connections - IIS/FTP Server(s) #>
			New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client';  <# Outgoing Connections, such as PowerShell calls #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server' -Name 'Enabled' -Value 0 –PropertyType 'DWORD';            <# Disabled #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server' -Name 'DisabledByDefault' -Value 1 –PropertyType 'DWORD';  <# Disabled #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client' -Name 'Enabled' -Value 0 –PropertyType 'DWORD';            <# Disabled #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client' -Name 'DisabledByDefault' -Value 1 –PropertyType 'DWORD';  <# Disabled #>
			<# [Protocols] Disable TLS 1.0 #>
			New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server';  <# Incoming Connections - IIS/FTP Server(s) #>
			New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client';  <# Outgoing Connections, such as PowerShell calls #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server' -Name 'Enabled' -Value 0 –PropertyType 'DWORD';            <# Disabled #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server' -Name 'DisabledByDefault' -Value 1 –PropertyType 'DWORD';  <# Disabled #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client' -Name 'Enabled' -Value 0 –PropertyType 'DWORD';            <# Disabled #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client' -Name 'DisabledByDefault' -Value 1 –PropertyType 'DWORD';  <# Disabled #>
			<# [Protocols] Enable TLS 1.1 #>
			New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server';  <# Incoming Connections - IIS/FTP Server(s) #>
			New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client';  <# Outgoing Connections, such as PowerShell calls #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server' -Name 'Enabled' -Value 1 –PropertyType 'DWORD';            <# ! ENABLED #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server' -Name 'DisabledByDefault' -Value 0 –PropertyType 'DWORD';  <# ! ENABLED #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client' -Name 'Enabled' -Value 1 –PropertyType 'DWORD';            <# ! ENABLED #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client' -Name 'DisabledByDefault' -Value 0 –PropertyType 'DWORD';  <# ! ENABLED #>
			<# [Protocols] Enable TLS 1.2 #>
			New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server';  <# Incoming Connections - IIS/FTP Server(s) #>
			New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client';  <# Outgoing Connections, such as PowerShell calls #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -Name 'Enabled' -Value 1 –PropertyType 'DWORD';            <# ! ENABLED #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -Name 'DisabledByDefault' -Value 0 –PropertyType 'DWORD';  <# ! ENABLED #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -Name 'Enabled' -Value 1 –PropertyType 'DWORD';            <# ! ENABLED #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -Name 'DisabledByDefault' -Value 0 –PropertyType 'DWORD';  <# ! ENABLED #>

			<# [Ciphers] Disable weak ciphers #>
			New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers'; `
			$RegistryKey = ((Get-Item -Path 'Registry::HKEY_LOCAL_MACHINE\').OpenSubKey('SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers', $True));
			$RegistryKey.CreateSubKey('AES 128/128');  <# Workaround for creating registry keys with forward-slashes in their name #>
			$RegistryKey.CreateSubKey('AES 256/256');  <# Workaround for creating registry keys with forward-slashes in their name #>
			$RegistryKey.CreateSubKey('DES 56/56');  <# Workaround for creating registry keys with forward-slashes in their name #>
			$RegistryKey.CreateSubKey('NULL');  <# Workaround for creating registry keys with forward-slashes in their name #>
			$RegistryKey.CreateSubKey('NULL');  <# Workaround for creating registry keys with forward-slashes in their name #>
			$RegistryKey.CreateSubKey('RC2 128/128');  <# Workaround for creating registry keys with forward-slashes in their name #>
			$RegistryKey.CreateSubKey('RC2 40/128');  <# Workaround for creating registry keys with forward-slashes in their name #>
			$RegistryKey.CreateSubKey('RC2 56/128');  <# Workaround for creating registry keys with forward-slashes in their name #>
			$RegistryKey.CreateSubKey('RC4 128/128');  <# Workaround for creating registry keys with forward-slashes in their name #>
			$RegistryKey.CreateSubKey('RC4 40/128');   <# Workaround for creating registry keys with forward-slashes in their name #>
			$RegistryKey.CreateSubKey('RC4 56/128');   <# Workaround for creating registry keys with forward-slashes in their name #>
			$RegistryKey.CreateSubKey('RC4 64/128');   <# Workaround for creating registry keys with forward-slashes in their name #>
			$RegistryKey.CreateSubKey('Triple DES 168/128');   <# Workaround for creating registry keys with forward-slashes in their name #>
			$RegistryKey.Close();
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\AES 128/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';           <# Disabled #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\AES 256/256' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';           <# Disabled #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\DES 56/56' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';             <# Disabled #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\NULL' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';                  <# Disabled #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\NULL' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';                  <# Disabled #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 128/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';           <# Disabled #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 40/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';            <# Disabled #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 56/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';            <# Disabled #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';           <# Disabled #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';            <# Disabled #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';            <# Disabled #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 64/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';            <# Disabled #>
			New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\Triple DES 168/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';    <# Disabled #>


			# ------------------------------------------------------------
			### Set default Security Protocol(s) used by PowerShell

			# Get the current Security Protocol(s) used by PowerShell
			[System.Net.ServicePointManager]::SecurityProtocol;

			# Set one, single Security Protocol to be used by PowerShell (!! TEMPORARY --> REVERTS ON-REBOOT !!)
			# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;

			# Set multiple Security Protocols to be used by PowerShell (!! TEMPORARY --> REVERTS ON-REBOOT !!)
			[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls11 -bor [System.Net.SecurityProtocolType]::Tls12;

			### Alternate method (Set multiple Security Protocols)
			[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]'Tls11,Tls12';

			# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'; # Alternate option 2

			# ------------------------------------------------------------
			If ($False) {

				### Re-test with any previously-working requests which now must forced to use hardened crypto
			
				($(New-Object Net.WebClient).DownloadString("https://ps.mcavallo.com/ps?t=$((Date).Ticks)"))

			}
		}

		Write-Host -NoNewLine "`n`n  Finished - Press any key to exit..." -BackgroundColor Black -ForegroundColor Magenta;
		$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

	}
	
}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "HardenCrypto" -ErrorAction "SilentlyContinue";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   community.spiceworks.com  |  "Set Registry Key To 'Full Control' For .\USERS - PowerShell - Spiceworks"  |  https://community.spiceworks.com/topic/1517671-set-registry-key-to-full-control-for-users
#
#   docs.microsoft.com  |  "Managing SSL/TLS Protocols and Cipher Suites for AD FS | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/operations/manage-ssl-protocols-in-ad-fs
#
#   docs.microsoft.com  |  "Protocols in TLS/SSL (Schannel SSP) - Implements versions of the TLS, DTLS and SSL protocols"  |  https://docs.microsoft.com/en-us/windows/win32/secauthn/protocols-in-tls-ssl--schannel-ssp-
#
#   docs.microsoft.com  |  "RegistryKey.Close Method (Microsoft.Win32) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registrykey.close
#
#   docs.microsoft.com  |  "RegistryKey.OpenBaseKey(RegistryHive, RegistryView) Method (Microsoft.Win32) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registrykey.openbasekey
#
#   docs.microsoft.com  |  "RegistryKey.OpenSubKey Method (Microsoft.Win32) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registrykey.opensubkey
#
#   docs.microsoft.com  |  "RegistryKey.SetAccessControl(RegistrySecurity) Method (Microsoft.Win32) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registrykey.setaccesscontrol
#
#   docs.microsoft.com  |  "RegistryKey.SetValue Method (Microsoft.Win32) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registrykey.setvalue
#
#   docs.microsoft.com  |  "RegistryValueKind Enum (Microsoft.Win32) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registryvaluekind
#
#   docs.microsoft.com  |  "ServicePointManager.SecurityProtocol Property (System.Net) - Gets/Sets the security protocol used by the ServicePoint objects managed by the ServicePointManager object"  |  https://docs.microsoft.com/en-us/dotnet/api/system.net.servicepointmanager.securityprotocol
#
#   docs.microsoft.com  |  "Solving the TLS 1.0 Problem - Security documentation | Microsoft Docs"  |  https://docs.microsoft.com/en-us/security/solving-tls1-problem
#
#   powershellpainrelief.blogspot.com  |  "Powershell - Pain Relief by R.T.Edwards: Powershell: Working With The Registry Part 2"  |  http://powershellpainrelief.blogspot.com/2014/07/powershell-working-with-registry-part-2.html
#
#   stackoverflow.com  |  "How to access the 64-bit registry from a 32-bit Powershell instance? - Stack Overflow"  |  https://stackoverflow.com/a/19381092
#
#   stackoverflow.com  |  "webclient - Powershell Setting Security Protocol to Tls 1.2 - Stack Overflow"  |  https://stackoverflow.com/a/41674736
#
#   stackoverflow.com  |  "windows - How to create a registry entry with a forward slash in the name - Stack Overflow"  |  https://stackoverflow.com/a/18259930
#
# ------------------------------------------------------------