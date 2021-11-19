# ------------------------------------------------------------
# PowerShell - Get-CimInstance


# Non-Admin Username (with domain)  -  Get info about the non-admin user who kicked off the current 'Run as administrator' terminal/command
$NonAdmin_SAM_Username=((Get-CimInstance -ClassName "Win32_ComputerSystem").UserName); $NonAdmin_SAM_Username;


# Non-Admin Username (w/o domain)  -  Get info about the non-admin user who kicked off the current 'Run as administrator' terminal/command
$NonAdmin_Username=((((Get-CimInstance -ClassName "Win32_ComputerSystem").UserName).Split("\"))[1]); $NonAdmin_Username;


# Verbose Info  -  Get info about the non-admin user who kicked off the current 'Run as administrator' terminal/command
(Get-CimInstance -ClassName "Win32_ComputerSystem") | Format-List *;



# ------------------------------------------------------------
#
#
# Get verbose Windows OS info
#  |--> Refer to [ "Get-OS-Info.psm1" ]  @  https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/Get-OS-Info/Get-OS-Info.psm1
#
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   community.spiceworks.com  |  "How to get the current logged on user on PowerShell"  |  https://community.spiceworks.com/topic/414076-powershell-getting-current-logged-on-user
#
#   devblogs.microsoft.com  |  "Introduction to CIM Cmdlets | PowerShell"  |  https://devblogs.microsoft.com/powershell/introduction-to-cim-cmdlets/
#
#   docs.microsoft.com  |  "CIM WMI Provider - Win32 apps | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/cim-wmi-provider
#
#   docs.microsoft.com  |  "Get-CimInstance - Gets the CIM instances of a class from a CIM server"  |  https://docs.microsoft.com/en-us/powershell/module/cimcmdlets/get-ciminstance
#
#   docs.microsoft.com  |  "Win32_OperatingSystem class - Win32 apps | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/win32-operatingsystem
#
#   docs.microsoft.com  |  "Windows 10 - release information | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/release-health/release-information
#
#   stackoverflow.com  |  "How to find the Windows version from the PowerShell command line - Stack Overflow"  |  https://stackoverflow.com/a/59664454/7600236
#
# ------------------------------------------------------------