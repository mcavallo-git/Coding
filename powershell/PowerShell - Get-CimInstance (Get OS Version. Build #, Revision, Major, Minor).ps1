
# ------------------------------------------------------------
#
# PowerShell - Get verbose info regarding current Windows OS
#
# ------------------------------------------------------------


Refer to "Get-OS-Info.psm1"

@ https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/Get-OS-Info/Get-OS-Info.psm1



# ------------------------------------------------------------
#
# PowerShell - Get build info regarding current Windows OS
#
# ------------------------------------------------------------
If ($True) {


# PowerShell-native method
$OS_Build = ([Environment]::OSVersion.Version).Build;
Write-Host "Build = ${$OS_Build}";

# Alternate method
$OS_Build = (Get-CimInstance Win32_OperatingSystem).Version;
Write-Host "Build = ${$OS_Build}";


}



# ------------------------------------------------------------
#
# Citation(s)
#
#   devblogs.microsoft.com  |  "Introduction to CIM Cmdlets | PowerShell"  |  https://devblogs.microsoft.com/powershell/introduction-to-cim-cmdlets/
#
#   docs.microsoft.com  |  "Win32_OperatingSystem class - Win32 apps | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/win32-operatingsystem
#
#   docs.microsoft.com  |  "Get-CimInstance - Gets the CIM instances of a class from a CIM server"  |  https://docs.microsoft.com/en-us/powershell/module/cimcmdlets/get-ciminstance
#
#   stackoverflow.com  |  "How to find the Windows version from the PowerShell command line - Stack Overflow"  |  https://stackoverflow.com/a/59664454/7600236
#
#   docs.microsoft.com  |  "Windows 10 - release information | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/release-health/release-information
#
# ------------------------------------------------------------