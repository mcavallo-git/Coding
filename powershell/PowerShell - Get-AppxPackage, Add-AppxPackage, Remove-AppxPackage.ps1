# ------------------------------------------------------------

$AppNameContains="Lockscreenaswallpaper";

explorer.exe shell:AppsFolder\$(Get-AppxPackage | Where-Object { ("$($_.Name)".Contains("${AppNameContains}")) -Eq $True } | Select-Object -ExpandProperty "PackageFamilyName")!App


# ------------------------------------------------------------
#
# Search for local packages
#

$PackageNameContains = "Help"; Get-AppxPackage | Sort-Object -Property Name | Where-Object { $_.Name -Like "*${PackageNameContains}*" } | Format-Table


# ------------------------------------------------------------
#
# Install a package
#

Add-AppxPackage -Path "C:\Users\user1\Desktop\MyApp.msix" -DependencyPath "C:\Users\user1\Desktop\winjs.msix"


# ------------------------------------------------------------
#
# Uninstall a package
#

$RemovePackagesContaining="Xbox"; Get-AppxPackage | Where-Object { $_.Name -Like "*${RemovePackagesContaining}*" } | Remove-AppxPackage;


# ------------------------------------------------------------
# Citation(s)
#
#  docs.microsoft.com  |  "Add-AppxPackage - Adds a signed app package to a user account"  |  https://docs.microsoft.com/en-us/powershell/module/appx/add-appxpackage?view=win10-ps
#
#  stackoverflow.com  |  "How to Start a Universal Windows App (UWP) from PowerShell in Windows 10?"  |  https://stackoverflow.com/a/48856168
#
# ------------------------------------------------------------