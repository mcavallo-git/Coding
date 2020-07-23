


# Get locally-available Xbox apps (across all users on the local device) - must run in an elevated (run as admin) terminal --> shows apps that you may have uninstalled but want to re-install, and already exist, locally
Get-AppXPackage -AllUsers -Name "Microsoft.Xbox*" | Sort-Object -Property Name | Format-Table -AutoSize;



# Uninstall the built-in Xbox app(s) which come pre-packaged with stock installs of Win10 / WinServer2016 / WinServer2019
Get-AppxPackage -Name "Microsoft.Xbox*" | Remove-AppxPackage;


# Re-install the built-in Xbox app(s) which come pre-packaged with stock installs of Win10 / WinServer2016 / WinServer2019
Get-AppXPackage -AllUsers -Name "Microsoft.Xbox*" | Foreach { Write-Host "Attempting to install package `"$($_.Name)`"..." -ForegroundColor "Cyan"; Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"; };


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-AppxPackage - Gets a list of the app packages that are installed in a user profile"  |  https://docs.microsoft.com/en-us/powershell/module/appx/get-appxpackage?view=win10-ps
#
#   www.winhelponline.com  |  "Restore or Reinstall Windows Store in Windows 10 after uninstalling it with PowerShell"  |  https://www.winhelponline.com/blog/restore-windows-store-windows-10-uninstall-with-powershell/
#
# ------------------------------------------------------------