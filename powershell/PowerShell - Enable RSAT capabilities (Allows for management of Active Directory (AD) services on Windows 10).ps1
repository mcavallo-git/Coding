# ------------------------------------------------------------
#
# Install Active Directory (AD) Management Tools on Win10 (Installs all RSAT* Windows capability packages)
#  |
#  |--> Script wil auto-upgrade to admin if needed
#

PowerShell -Command "Start-Process -Filepath ('C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe') -ArgumentList ('-Command Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online;') -Verb 'RunAs' -Wait -PassThru | Out-Null;"


# ------------------------------------------------------------
#
# Base-coommand (Without auto-run-as-admin
#

Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Add-WindowsCapability - Installs a Windows capability package on the specified operating system image"  |  https://docs.microsoft.com/en-us/powershell/module/dism/add-windowscapability
#
#   docs.microsoft.com  |  "Get-WindowsCapability - Gets Windows capabilities for an image or a running operating system"  |  https://docs.microsoft.com/en-us/powershell/module/dism/get-windowscapability
#
#   docs.microsoft.com  |  "ktpass | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/ktpass
#
#   mikefrobbins.com  |  "Use PowerShell to Install the Remote Server Administration Tools (RSAT) on Windows 10 version 1809 – Mike F Robbins"  |  https://mikefrobbins.com/2018/10/03/use-powershell-to-install-the-remote-server-administration-tools-rsat-on-windows-10-version-1809/
#
# ------------------------------------------------------------