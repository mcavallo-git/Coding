# ------------------------------------------------------------
#
# .NET Framework v4 - Simplify protocol-management (by handing off control to OS) & Enforce strong cryptography
#   |
#   |--> Creating these keys forces any version of .NET 4.x below 4.6.2 to use strong crypto instead of allowing SSL 3.0 by default
#

If ($True) {

$VersionInstalled_DotNet4 = ((Get-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0*').PSChildName);  <# Determine the installed version of .NET v4.x #> 
$RelPath_HKLM_DotNet4 = ("SOFTWARE\Microsoft\.NETFramework\${VersionInstalled_DotNet4}");

<# Update the 64-bit registry #>
$Registry_HKLM_64bit = ([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, [Microsoft.Win32.RegistryView]::Registry64));  <# Methods which update registry keys such as  [ New-ItemProperty ... ]  often only update the 64bit registry (by default) #>
$SubKey_DotNet4_64bit = $Registry_HKLM_64bit.OpenSubKey("${RelPath_HKLM_DotNet4}", $True);  <# Retrieve the specified subkey for read/write access (argument #2 == $True) #>
<# Note: The third argument passed to '.SetValue()' is the 'RegistryValueKind' --> A value of '4' creates/sets a 'DWORD' typed property #>
$SubKey_DotNet4_64bit.GetValue("SystemDefaultTlsVersions", 1, 4);  <# Allow the operating system to control the networking protocol used by apps (which run on this version of the .NET Framework) #>
$SubKey_DotNet4_64bit.GetValue("SchUseStrongCrypto", 1, 4);  <# Enforce strong cryptography, using more secure network protocols (TLS 1.2, TLS 1.1, and TLS 1.0) and blocking protocols that are not secure #>
$SubKey_DotNet4_64bit.Close();  <# Close the key & flush it to disk (if its contents have been modified) #>

<# Update the 32-bit registry #>
$Registry_HKLM_32bit = ([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, [Microsoft.Win32.RegistryView]::Registry32));  <# Methods which update registry keys such as  [ New-ItemProperty ... ]  often only update the 64bit registry (by default) #>
$SubKey_DotNet4_32bit = $Registry_HKLM_32bit.OpenSubKey("${RelPath_HKLM_DotNet4}", $True);  <# Retrieve the specified subkey for read/write access (argument #2 == $True) #>
$SubKey_DotNet4_32bit.GetValue("SystemDefaultTlsVersions", 1, 4);  <# Allow the operating system to control the networking protocol used by apps (which run on this version of the .NET Framework) #>
$SubKey_DotNet4_32bit.GetValue("SchUseStrongCrypto", 1, 4);  <# Enforce strong cryptography, using more secure network protocols (TLS 1.2, TLS 1.1, and TLS 1.0) and blocking protocols that are not secure #>
$SubKey_DotNet4_32bit.Close();  <# Close the key & flush it to disk (if its contents have been modified) #>

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "RegistryHive Enum (Microsoft.Win32) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registryhive?view=net-5.0
# 
# ------------------------------------------------------------