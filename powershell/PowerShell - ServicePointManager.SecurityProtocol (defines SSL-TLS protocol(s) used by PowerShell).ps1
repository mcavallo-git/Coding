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
###  ($(New-Object Net.WebClient).DownloadString("https://sync-ps.mcavallo.com/ps?t=$((Date).Ticks)"))
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
<# Target the 64bit and 32bit registries separately #>
$Registry_64bit = ([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, [Microsoft.Win32.RegistryView]::Registry64));  <# Methods which update registry keys such as  [ New-ItemProperty ... ]  often only update the 64bit registry (by default) #>
$Registry_32bit = ([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, [Microsoft.Win32.RegistryView]::Registry32));
<# ============================== #>
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
<# ============================== #>
<# Prep the key #>
$SubKey_64bit = ($Registry_64bit.OpenSubKey("${HKLM_DotNet4}"), $True);
$SubKey_32bit = ($Registry_32bit.OpenSubKey("${HKLM_DotNet4}"), $True);
<# Update the key #>
$SubKey_64bit.SetValue("SystemDefaultTlsVersions", "1");
$SubKey_32bit.SetValue("SystemDefaultTlsVersions", "1");
<# Close the key & flush it to disk (if its contents have been modified) #>
$SubKey_64bit.Close();
$SubKey_32bit.Close();
<# Get the registry key's value #>
$SubKey_64bit.GetValue("SystemDefaultTlsVersions");
$SubKey_32bit.GetValue("SystemDefaultTlsVersions");
<# ============================== #>


<# [Protocols] Disable SSL 2.0 #>
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server';
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client';
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server' -Name 'Enabled' -Value 0 –PropertyType 'DWORD';            <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server' -Name 'DisabledByDefault' -Value 1 –PropertyType 'DWORD';  <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client' -Name 'Enabled' -Value 0 –PropertyType 'DWORD';            <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client' -Name 'DisabledByDefault' -Value 1 –PropertyType 'DWORD';  <# Disabled #>
<# [Protocols] Disable SSL 3.0 #>
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server';
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client';
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server' -Name 'Enabled' -Value 0 –PropertyType 'DWORD';            <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server' -Name 'DisabledByDefault' -Value 1 –PropertyType 'DWORD';  <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client' -Name 'Enabled' -Value 0 –PropertyType 'DWORD';            <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client' -Name 'DisabledByDefault' -Value 1 –PropertyType 'DWORD';  <# Disabled #>
<# [Protocols] Disable TLS 1.0 #>
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server';
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client';
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server' -Name 'Enabled' -Value 0 –PropertyType 'DWORD';            <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server' -Name 'DisabledByDefault' -Value 1 –PropertyType 'DWORD';  <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client' -Name 'Enabled' -Value 0 –PropertyType 'DWORD';            <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client' -Name 'DisabledByDefault' -Value 1 –PropertyType 'DWORD';  <# Disabled #>
<# [Protocols] Enable TLS 1.1 #>
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server';
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client';
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server' -Name 'Enabled' -Value 1 –PropertyType 'DWORD';            <# Enabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server' -Name 'DisabledByDefault' -Value 0 –PropertyType 'DWORD';  <# Enabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client' -Name 'Enabled' -Value 1 –PropertyType 'DWORD';            <# Enabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client' -Name 'DisabledByDefault' -Value 0 –PropertyType 'DWORD';  <# Enabled #>
<# [Protocols] Enable TLS 1.2 #>
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server';
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client';
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -Name 'Enabled' -Value 1 –PropertyType 'DWORD';            <# Enabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -Name 'DisabledByDefault' -Value 0 –PropertyType 'DWORD';  <# Enabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -Name 'Enabled' -Value 1 –PropertyType 'DWORD';            <# Enabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -Name 'DisabledByDefault' -Value 0 –PropertyType 'DWORD';  <# Enabled #>
<# [Ciphers] Disable RC4 #>
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers'; `
$RegistryKey = ((Get-Item -Path 'Registry::HKEY_LOCAL_MACHINE\').OpenSubKey('SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers', $True));
$RegistryKey.CreateSubKey('RC4 128/128');  <# Workaround for creating registry keys with forward-slashes in their name #>
$RegistryKey.CreateSubKey('RC4 40/128');   <# Workaround for creating registry keys with forward-slashes in their name #>
$RegistryKey.CreateSubKey('RC4 56/128');   <# Workaround for creating registry keys with forward-slashes in their name #>
$RegistryKey.Close();
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';                 <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';                  <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';                  <# Disabled #>


# ------------------------------------------------------------
### Set default Security Protocol(s) used by PowerShell

# Get the current Security Protocol(s) used by PowerShell
[System.Net.ServicePointManager]::SecurityProtocol;


# Set one, single Security Protocol to be used by PowerShell (!! TEMPORARY --> REVERTS ON-REBOOT !!)
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;

# Set multiple Security Protocols to be used by PowerShell (!! TEMPORARY --> REVERTS ON-REBOOT !!)
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls11 -bor [System.Net.SecurityProtocolType]::Tls12;
### Alternate method (Set multiple Security Protocols)
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]'Tls11,Tls12';  <# 'Ssl3,Tls,Tls11,Tls12' #>



# ------------------------------------------------------------
### Test with original command to a TLS v1.2 site (or to a site which tests the protocol(s) you just added/removed) as-to verify that the protocol(s) have been applied and are now working as-intended

($(New-Object Net.WebClient).DownloadString("https://sync-ps.mcavallo.com/ps?t=$((Date).Ticks)"))


# ------------------------------------------------------------
#
# Citation(s)
#
#   community.spiceworks.com  |  "[SOLVED] Set Registry Key To 'Full Control' For .\USERS - PowerShell - Spiceworks"  |  https://community.spiceworks.com/topic/1517671-set-registry-key-to-full-control-for-users
#
#   docs.microsoft.com  |  "Managing SSL/TLS Protocols and Cipher Suites for AD FS | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/operations/manage-ssl-protocols-in-ad-fs
#
#   docs.microsoft.com  |  "Protocols in TLS/SSL (Schannel SSP) - Implements versions of the TLS, DTLS and SSL protocols"  |  https://docs.microsoft.com/en-us/windows/win32/secauthn/protocols-in-tls-ssl--schannel-ssp-
#
#   docs.microsoft.com  |  "RegistryKey.Close Method (Microsoft.Win32) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registrykey.close
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
#   stackoverflow.com  |  "How to access the 64-bit registry from a 32-bit Powershell instance? - Stack Overflow"  |  https://stackoverflow.com/a/19381092
#
#   stackoverflow.com  |  "webclient - Powershell Setting Security Protocol to Tls 1.2 - Stack Overflow"  |  https://stackoverflow.com/a/41674736
#
#   stackoverflow.com  |  "windows - How to create a registry entry with a forward slash in the name - Stack Overflow"  |  https://stackoverflow.com/a/18259930
#
# ------------------------------------------------------------