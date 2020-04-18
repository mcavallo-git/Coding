# ------------------------------------------------------------
#
# Run a local package 
#

$AppNameContains="Lockscreenaswallpaper";

explorer.exe shell:AppsFolder\$(Get-AppxPackage | Where-Object { ("$($_.Name)".Contains("${AppNameContains}")) -Eq $True } | Select-Object -ExpandProperty "PackageFamilyName")!App


# ------------------------------------------------------------
#
# Search locally installed packages
#

$PackageNameContains="Help"; Get-AppxPackage | Sort-Object -Property Name | Where-Object { $_.Name -Like "*${PackageNameContains}*" };


# ------------------------------------------------------------
#
# Search for local package manifests and installers (files)
#

Get-ChildItem -Path ("${Home}\Desktop") -File -Recurse -Force -ErrorAction "SilentlyContinue" `
| Where-Object { ($_.Name -Eq "Appxmanifest.xml") -Or ($_.Name -Like "*.msix") };


# ------------------------------------------------------------
#
# Install package(s)
#

Get-ChildItem -Path ("${Home}\Desktop") -File -Recurse -Force -ErrorAction "SilentlyContinue" `
| Where-Object { ($_.Name -Eq "Appxmanifest.xml") -Or ($_.Name -Like "*.msix") } `
| ForEach-Object { Add-AppxPackage -Path ("$($_.FullName)") -Register -DisableDevelopmentMode; }



# ------------------------------------------------------------
#
# Uninstall package(s)
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