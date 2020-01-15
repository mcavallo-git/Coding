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
# Update using PowerShell to modify the Registry
#   |--> Set the security protocol(s) used by the ServicePoint objects managed by the ServicePointManager object
#

<# ------------------------------------------------------------ #>
<# Disable RC4 (Ciphers) #>
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers'; `
$RegistryKey = ((Get-Item -Path 'Registry::HKEY_LOCAL_MACHINE\').OpenSubKey('SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers', $True));
$RegistryKey.CreateSubKey('RC4 128/128');  <# Workaround for creating registry keys with forward-slashes in their name #>
$RegistryKey.CreateSubKey('RC4 40/128');   <# Workaround for creating registry keys with forward-slashes in their name #>
$RegistryKey.CreateSubKey('RC4 56/128');   <# Workaround for creating registry keys with forward-slashes in their name #>
$RegistryKey.Close();
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';                 <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';                  <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';                  <# Disabled #>
<# ------------------------------------------------------------ #>
<# Disable SSL 2.0 (Protocol) #>
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server';
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client';
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server' -Name 'Enabled' -Value 0 –PropertyType 'DWORD';            <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server' -Name 'DisabledByDefault' -Value 1 –PropertyType 'DWORD';  <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client' -Name 'Enabled' -Value 0 –PropertyType 'DWORD';            <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client' -Name 'DisabledByDefault' -Value 1 –PropertyType 'DWORD';  <# Disabled #>
<# ------------------------------------------------------------ #>
<# Disable SSL 3.0 (Protocol) #>
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server';
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client';
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server' -Name 'Enabled' -Value 0 –PropertyType 'DWORD';            <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server' -Name 'DisabledByDefault' -Value 1 –PropertyType 'DWORD';  <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client' -Name 'Enabled' -Value 0 –PropertyType 'DWORD';            <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client' -Name 'DisabledByDefault' -Value 1 –PropertyType 'DWORD';  <# Disabled #>
<# ------------------------------------------------------------ #>
<# Disable TLS 1.0 (Protocol) #>
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server';
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client';
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server' -Name 'Enabled' -Value 0 –PropertyType 'DWORD';            <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server' -Name 'DisabledByDefault' -Value 1 –PropertyType 'DWORD';  <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client' -Name 'Enabled' -Value 0 –PropertyType 'DWORD';            <# Disabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client' -Name 'DisabledByDefault' -Value 1 –PropertyType 'DWORD';  <# Disabled #>
<# ------------------------------------------------------------ #>
<# Enable TLS 1.1 #>
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server';
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client';
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server' -Name 'Enabled' -Value 1 –PropertyType 'DWORD';            <# Enabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server' -Name 'DisabledByDefault' -Value 0 –PropertyType 'DWORD';  <# Enabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client' -Name 'Enabled' -Value 1 –PropertyType 'DWORD';            <# Enabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client' -Name 'DisabledByDefault' -Value 0 –PropertyType 'DWORD';  <# Enabled #>
<# ------------------------------------------------------------ #>
<# Enable TLS 1.2 #>
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server';
New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client';
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -Name 'Enabled' -Value 1 –PropertyType 'DWORD';            <# Enabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -Name 'DisabledByDefault' -Value 0 –PropertyType 'DWORD';  <# Enabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -Name 'Enabled' -Value 1 –PropertyType 'DWORD';            <# Enabled #>
New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -Name 'DisabledByDefault' -Value 0 –PropertyType 'DWORD';  <# Enabled #>


# ------------------------------------------------------------
### Set default Security Protocol(s) used by PowerShell

# Get the current Security Protocol(s) used by PowerShell
[System.Net.ServicePointManager]::SecurityProtocol;


# Set the Security Protocol(s) used by PowerShell (!! TEMPORARY --> REVERTS ON-REBOOT !!)
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;


# ------------------------------------------------------------
### Test with original command to a TLS v1.2 site (or to a site which tests the protocol(s) you just added/removed) as-to verify that the protocol(s) have been applied and are now working as-intended

($(New-Object Net.WebClient).DownloadString("https://sync-ps.mcavallo.com/ps?t=$((Date).Ticks)"))


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Managing SSL/TLS Protocols and Cipher Suites for AD FS | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/operations/manage-ssl-protocols-in-ad-fs
#
#   docs.microsoft.com  |  "Protocols in TLS/SSL (Schannel SSP) - Implements versions of the TLS, DTLS and SSL protocols"  |  https://docs.microsoft.com/en-us/windows/win32/secauthn/protocols-in-tls-ssl--schannel-ssp-
#
#   docs.microsoft.com  |  "ServicePointManager.SecurityProtocol Property (System.Net) - Gets/Sets the security protocol used by the ServicePoint objects managed by the ServicePointManager object"  |  https://docs.microsoft.com/en-us/dotnet/api/system.net.servicepointmanager.securityprotocol
#
#   stackoverflow.com  |  "windows - How to create a registry entry with a forward slash in the name - Stack Overflow"  |  https://stackoverflow.com/a/18259930
#
# ------------------------------------------------------------