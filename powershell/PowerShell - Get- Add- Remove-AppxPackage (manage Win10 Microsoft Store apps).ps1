# ------------------------------------------------------------
# PowerShell - Get- Add- Remove-AppxPackage (manage Win10 Microsoft Store apps)
# ------------------------------------------------------------
#
# Get/List installed package(s)/application(s)
#

$PackageNameContains="Help"; Get-AppxPackage | Sort-Object -Property Name | Where-Object { $_.Name -Like "*${PackageNameContains}*" };

$PackageNameContains="DynamicTheme"; Get-AppxPackage | Sort-Object -Property Name | Where-Object { $_.Name -Like "*${PackageNameContains}*" };

$PackageNameContains="Microsoft.WindowsTerminal"; Get-AppxPackage | Sort-Object -Property Name | Where-Object { $_.Name -Like "*${PackageNameContains}*" };


# ------------------------------------------------------------
#
# Run a local package/application 
#

# As a one-liner (with no single quotes, double quotes, or dollar signs anywhere in the call):
SV AppNameContains (Write-Output Microsoft.WindowsTerminal); SV AppNameResolved (Get-AppxPackage | Where-Object { ((((GV _).Value).Name).Contains(((GV AppNameContains).Value))) } | Select-Object -ExpandProperty PackageFamilyName); SV ExplorerTarget ((Write-Output shell:AppsFolder\)+((GV AppNameResolved).Value)+(Write-Output !App)); explorer.exe ((GV ExplorerTarget).Value);;


# As a one-liner in a powershell run command:
PowerShell -Command "SV AppNameContains (Write-Output Microsoft.WindowsTerminal); SV AppNameResolved (Get-AppxPackage | Where-Object { ((((GV _).Value).Name).Contains(((GV AppNameContains).Value))) } | Select-Object -ExpandProperty PackageFamilyName); SV ExplorerTarget ((Write-Output shell:AppsFolder\)+((GV AppNameResolved).Value)+(Write-Output !App)); explorer.exe ((GV ExplorerTarget).Value);";


# Expanded:
If ($True) {
$AppNameContains="Microsoft.WindowsTerminal";
$AppNameResolved=(Get-AppxPackage | Where-Object { ("$($_.Name)".Contains("${AppNameContains}")) -Eq $True } | Select-Object -ExpandProperty "PackageFamilyName");
explorer.exe shell:AppsFolder\$(Write-Output ${AppNameResolved};)!App;
}


# ------------------------------------------------------------
#
# Uninstall package(s)/application(s)
#

# Remove package from every user it's installed to ("like" name-matching)
If ($True) {
  $PackageName_Contains="Xbox";
  Get-AppxPackage | Where-Object { $_.Name -Like "*${PackageName_Contains}*" } | ForEach-Object {
    $PackageFullName = ($_.PackageFullName);
    $_.PackageUserInformation.UserSecurityId | ForEach-Object {
      Write-Host "Calling [ Remove-AppxPackage -User ($($_.Sid)) -Package (`"${PackageFullName}`"); ]...";
      Remove-AppxPackage -User ($_.Sid) -Package ("${PackageFullName}");
    }
  }
}


# Remove package from every user it's installed to ("equals" name-matching (exact))
If ($True) {
  $PackageName = "Microsoft.YourPhone";
  Get-AppxPackage -Name "${PackageName}" -AllUsers | ForEach-Object {
    $PackageFullName = ($_.PackageFullName);
    $_.PackageUserInformation.UserSecurityId | ForEach-Object {
      Write-Host "Calling [ Remove-AppxPackage -User ($($_.Sid)) -Package (`"${PackageFullName}`"); ]...";
      Remove-AppxPackage -User ($_.Sid) -Package ("${PackageFullName}");
    }
  }
}


#
# Some packages are installed under the "System" user, and you must create a scheduled task to masquerade as the "System" user & uninstall them
#
# Open "Task Scheduler"
#   > Create Task
#     > Name/Description:  "Uninstall-Microsoft.YourPhone.vbs"
#     > Trigger:  Run at system startup  (to auto-select "System" user)
#     > Action:  Start a Program
#       > Program/script:  C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
#       > Add arguments:  -c "Remove-AppxPackage -User 'S-1-5-21-664227053-1759174218-1597799016-1008' -Package 'Microsoft.YourPhone_1.22102.229.0_x64__8wekyb3d8bbwe';"
#
# Before running the task, check for the package via powershell:  Get-AppxPackage Microsoft.YourPhone -AllUsers
#
# Run the scheduled task
#
# After running the task, check for the package via powershell:  Get-AppxPackage Microsoft.YourPhone -AllUsers
#


#
# Note: The App "Microsoft.YourPhone" can no longer be uninstalled - Refer to Microsoft post @ https://support.microsoft.com/en-us/windows/why-can-t-i-uninstall-the-your-phone-app-1c0ac9f4-26a2-7e5c-ec76-feb9e715db59
#  |
#  |--> "The Your Phone app is deeply integrated into Windows to light up multiple cross-device experiences now and in the future. In order to build more of these experiences between phones, PCs, and other devices, the app can't be uninstalled."
#


# ------------------------------------------------------------
#
# Install package(s)/application(s)   (via an installation file "Appxmanifest.xml" (standardized filename))
#

Get-ChildItem -Path ("${Home}\Desktop") -File -Recurse -Force -ErrorAction "SilentlyContinue" `
| Where-Object { ($_.Name -Eq "Appxmanifest.xml") -Or ($_.Name -Like "*.msix") } `
| ForEach-Object { Add-AppxPackage -Path ("$($_.FullName)") -Register -DisableDevelopmentMode; }


# ------------------------------------------------------------
#
# Show available "*Appx*" cmdlets
#
Get-Command | Where-Object { $_.Name -Like '*appx*' };


# ------------------------------------------------------------
#
# Search for local package/application manifests & installation files
#

Get-ChildItem -Path ("${Home}\Desktop") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { ($_.Name -Eq "Appxmanifest.xml") -Or ($_.Name -Like "*.msix") };


# ------------------------------------------------------------
#
# Citation(s)
#
#  learn.microsoft.com  |  "Add-AppxPackage (Appx) | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/appx/add-appxpackage?view=win10-ps
#
#  learn.microsoft.com  |  "Get-AppxPackage (Appx) | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/appx/get-appxpackage?view=windowsserver2022-ps
#
#  learn.microsoft.com  |  "Remove-AppxPackage (Appx) | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/appx/remove-appxpackage?view=windowsserver2022-ps
#
#  stackoverflow.com  |  "How to Start a Universal Windows App (UWP) from PowerShell in Windows 10?"  |  https://stackoverflow.com/a/48856168
#
#  superuser.com  |  "windows 10 - Remove appx package for all users - Super User"  |  https://superuser.com/a/1266885
#
# ------------------------------------------------------------