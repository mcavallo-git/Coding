# ------------------------------------------------------------



# ------------------------------------------------------------
#
# Ex) Determine the currently-installed version of .NET 4.0
#

<# Locate the .NET Framework v4 key to modify #> 
$GlobPath_DotNet4 = (Get-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0*');
$RelPath_HKLM_DotNet4 = ("SOFTWARE\Microsoft\.NETFramework\$($GlobPath_DotNet4.PSChildName)");

<# Update the 64-bit registry #>
$Registry_HKLM_64bit = ([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, [Microsoft.Win32.RegistryView]::Registry64));  <# Methods which update registry keys such as  [ New-ItemProperty ... ]  often only update the 64bit registry (by default) #>
$SubKey_DotNet4_64bit = $Registry_HKLM_64bit.OpenSubKey("${RelPath_HKLM_DotNet4}", $True);  <# Retrieve the specified subkey for read/write access (argument #2 == $True) #>
$SubKey_DotNet4_64bit.SetValue("SystemDefaultTlsVersions", 1, 4);  <# Update the key #> <# DWords' native RegistryValueKind is 4 #>
$SubKey_DotNet4_64bit.Close();  <# Close the key & flush it to disk (if its contents have been modified) #>

<# Update the 32-bit registry #>
$Registry_HKLM_32bit = ([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, [Microsoft.Win32.RegistryView]::Registry32));  <# Methods which update registry keys such as  [ New-ItemProperty ... ]  often only update the 64bit registry (by default) #>
$SubKey_DotNet4_32bit = $Registry_HKLM_32bit.OpenSubKey("${RelPath_HKLM_DotNet4}", $True);  <# Retrieve the specified subkey for read/write access (argument #2 == $True) #>
$SubKey_DotNet4_32bit.SetValue("SystemDefaultTlsVersions", 1, 4);  <# Update the key #> <# DWords' native RegistryValueKind is 4 #>
$SubKey_DotNet4_32bit.Close();  <# Close the key & flush it to disk (if its contents have been modified) #>



# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "RegistryHive Enum (Microsoft.Win32) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registryhive?view=net-5.0
# 
# ------------------------------------------------------------