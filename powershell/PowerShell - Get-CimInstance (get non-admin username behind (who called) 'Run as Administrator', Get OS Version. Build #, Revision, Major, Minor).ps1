# ------------------------------------------------------------
#
# PowerShell  -  Get-CimInstance -ClassName "Win32_..."
#
# ------------------------------------------------------------


If ($True) {
# Non-Admin User Details -  Get info about the non-admin user who kicked off the current 'Run as administrator' terminal/command

# Get all obtaining info  -  Pertains to either [ the user running this command ] or [ the user BEHIND the admin who is running this command ]
$NonAdmin_UserDetails=(Get-CimInstance -ClassName "Win32_ComputerSystem");
  Write-Output $NonAdmin_UserDetails | Format-List *;

# Non-Admin Username (with domain)
$NonAdmin_SAM_Username=(${NonAdmin_UserDetails}.UserName);
  Write-Output ${NonAdmin_SAM_Username};

# Non-Admin Username (w/o domain)
$NonAdmin_Username=(((${NonAdmin_UserDetails}.UserName).Split("\"))[1]);
  Write-Output ${NonAdmin_UserSID};

# Non-Admin User's Domain
$NonAdmin_User_Domain=(${NonAdmin_UserDetails}.DNSHostName);
  Write-Output ${NonAdmin_User_Domain};

# FINALLY, get the Non-Admin User's SID
$NonAdmin_UserSID=((Get-CimInstance -ClassName "Win32_UserAccount" -Filter "UserName='$(${NonAdmin_UserDetails}.UserName)'").SID);
  Write-Output ${NonAdmin_UserSID};

}


# ------------------------------

# Get all users' info
$All_UserDetails=(Get-CimInstance -ClassName "Win32_UserAccount"); $All_UserDetails | Format-List *;


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
#   docs.microsoft.com  |  "Win32_ComputerSystem class - Win32 apps | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/win32-computersystem
#
#   docs.microsoft.com  |  "Win32_OperatingSystem class - Win32 apps | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/win32-operatingsystem
#
#   docs.microsoft.com  |  "Win32_UserAccount class - Win32 apps | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/win32-useraccount
#
#   docs.microsoft.com  |  "Windows 10 - release information | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/release-health/release-information
#
#   stackoverflow.com  |  "How to find the Windows version from the PowerShell command line - Stack Overflow"  |  https://stackoverflow.com/a/59664454/7600236
#
# ------------------------------------------------------------