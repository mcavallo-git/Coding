# ------------------------------------------------------------
#
# Instantiate methods to to 32- & 64-bit registries (which exist simultaneously on 64-bit Windows systems)
#

If ($True) {

$RegistryHives = @{};

<# 32-bit Registry Access #>
$RegistryHives.Arch_32bit = @{};
$RegistryHives.Arch_32bit.HKCC=([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::CurrentConfig, [Microsoft.Win32.RegistryView]::Registry32));  <# HKEY_CURRENT_CONFIG #>
$RegistryHives.Arch_32bit.HKCR=([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::ClassesRoot, [Microsoft.Win32.RegistryView]::Registry32));  <# HKEY_CLASSES_ROOT #>
$RegistryHives.Arch_32bit.HKCU=([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::CurrentUser, [Microsoft.Win32.RegistryView]::Registry32));  <# HKEY_CURRENT_USER  #>
$RegistryHives.Arch_32bit.HKLM=([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, [Microsoft.Win32.RegistryView]::Registry32));  <# HKEY_LOCAL_MACHINE #>
$RegistryHives.Arch_32bit.HKPD=([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::PerformanceData, [Microsoft.Win32.RegistryView]::Registry32));  <# HKEY_PERFORMANCE_DATA  #>
$RegistryHives.Arch_32bit.HKU=([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::Users, [Microsoft.Win32.RegistryView]::Registry32));  <# HKEY_USERS #>

<# 64-bit Registry Access #>
$RegistryHives.Arch_64bit = @{};
$RegistryHives.Arch_64bit.HKCC=([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::CurrentConfig, [Microsoft.Win32.RegistryView]::Registry64));  <# HKEY_CURRENT_CONFIG #>
$RegistryHives.Arch_64bit.HKCR=([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::ClassesRoot, [Microsoft.Win32.RegistryView]::Registry64));  <# HKEY_CLASSES_ROOT #>
$RegistryHives.Arch_64bit.HKCU=([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::CurrentUser, [Microsoft.Win32.RegistryView]::Registry64));  <# HKEY_CURRENT_USER  #>
$RegistryHives.Arch_64bit.HKLM=([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, [Microsoft.Win32.RegistryView]::Registry64));  <# HKEY_LOCAL_MACHINE #>
$RegistryHives.Arch_64bit.HKPD=([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::PerformanceData, [Microsoft.Win32.RegistryView]::Registry64));  <# HKEY_PERFORMANCE_DATA  #>
$RegistryHives.Arch_64bit.HKU=([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::Users, [Microsoft.Win32.RegistryView]::Registry64));  <# HKEY_USERS #>


<# Grab a value from the 32- & 64-bit registries, separately #>
Get-ItemPropertyValue -LiteralPath ("Registry::HKEY_CLASSES_ROOT\Folder\shell\pintohome") -Name ("(Default)") -ErrorAction ("Stop");
$RelPath_HKCR_ExampleKey="Folder\shell\pintohome";
$SubKey_64bit=($RegistryHives.Arch_64bit.HKCR).OpenSubKey("${RelPath_HKCR_ExampleKey}", $True);
$PropVal_64bit = $SubKey_64bit.GetValue("(Default)");
$SubKey_64bit.Close();
$SubKey_32bit=($RegistryHives.Arch_32bit.HKCR).OpenSubKey("${RelPath_HKCR_ExampleKey}", $True);
$PropVal_32bit = $SubKey_32bit.GetValue("(Default)");
$SubKey_32bit.Close();
Write-Output "";
Write-Output "`${PropVal_64bit} = ${PropVal_64bit}";
Write-Output "`${PropVal_32bit} = ${PropVal_32bit}";
Write-Output "";
Write-Output "";

}


# ------------------------------------------------------------
#
# .NET Framework v4 - Simplify protocol-management (by handing off control to OS) & Enforce strong cryptography
#   |
#   |--> Creating these keys forces any version of .NET 4.x below 4.6.2 to use strong crypto instead of allowing SSL 3.0 by default
#

If ($True) {

<# Note: Methods which update registry keys such as  [ New-ItemProperty ... ]  often only update the 64bit registry (by default) #>
<# Note: The third argument passed to the '.SetValue()' method, here, defines the value for 'RegistryValueKind', which defines the 'type' of the registry property - A value of '4' creates/sets a 'DWORD' typed property #>

$VersionInstalled_DotNet4 = ((Get-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v4.0*').PSChildName);  <# Determine the installed version of .NET v4.x #> 
$RelPath_HKLM_DotNet4 = ("SOFTWARE\Microsoft\.NETFramework\${VersionInstalled_DotNet4}");

<# Update the 64-bit registry #>
$Registry_HKLM_64bit = ([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, [Microsoft.Win32.RegistryView]::Registry64));
$SubKey_DotNet4_64bit = $Registry_HKLM_64bit.OpenSubKey("${RelPath_HKLM_DotNet4}", $True);  <# Retrieve the specified subkey for read/write access (argument #2 == $True) #>
If (($SubKey_DotNet4_64bit.GetValue("SystemDefaultTlsVersions")) -NE (1)) {
	$SubKey_DotNet4_64bit.SetValue("SystemDefaultTlsVersions", 1, 4);  <# Allow the operating system to control the networking protocol used by apps (which run on this version of the .NET Framework) #>
}
If (($SubKey_DotNet4_64bit.GetValue("SchUseStrongCrypto")) -NE (1)) {
	$SubKey_DotNet4_64bit.SetValue("SchUseStrongCrypto", 1, 4);  <# Enforce strong cryptography, using more secure network protocols (TLS 1.2, TLS 1.1, and TLS 1.0) and blocking protocols that are not secure #>
}
$SubKey_DotNet4_64bit.Close();  <# Close the key & flush it to disk (if its contents have been modified) #>

<# Update the 32-bit registry #>
$Registry_HKLM_32bit = ([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, [Microsoft.Win32.RegistryView]::Registry32));
$SubKey_DotNet4_32bit = $Registry_HKLM_32bit.OpenSubKey("${RelPath_HKLM_DotNet4}", $True);  <# Retrieve the specified subkey for read/write access (argument #2 == $True) #>
If (($SubKey_DotNet4_32bit.GetValue("SystemDefaultTlsVersions")) -NE (1)) {
	$SubKey_DotNet4_32bit.SetValue("SystemDefaultTlsVersions", 1, 4);  <# Allow the operating system to control the networking protocol used by apps (which run on this version of the .NET Framework) #>
}
If (($SubKey_DotNet4_32bit.GetValue("SchUseStrongCrypto")) -NE (1)) {
	$SubKey_DotNet4_32bit.SetValue("SchUseStrongCrypto", 1, 4);  <# Enforce strong cryptography, using more secure network protocols (TLS 1.2, TLS 1.1, and TLS 1.0) and blocking protocols that are not secure #>
}
$SubKey_DotNet4_32bit.Close();  <# Close the key & flush it to disk (if its contents have been modified) #>

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "RegistryHive Enum (Microsoft.Win32) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registryhive?view=net-5.0
# 
# ------------------------------------------------------------