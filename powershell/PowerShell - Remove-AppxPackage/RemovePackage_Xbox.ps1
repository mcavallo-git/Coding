

# Uninstall the built-in Xbox app(s) which come pre-packaged with stock installs of Win10 / WinServer2016 / WinServer2019
PowerShell -Command ("Get-AppxPackage *Xbox* | Remove-AppxPackage;");


# Re-install the built-in Xbox app(s) which come pre-packaged with stock installs of Win10 / WinServer2016 / WinServer2019
Get-AppXPackage -allusers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-AppxPackage - Gets a list of the app packages that are installed in a user profile"  |  https://docs.microsoft.com/en-us/powershell/module/appx/get-appxpackage?view=win10-ps
#
#   www.winhelponline.com  |  "Restore or Reinstall Windows Store in Windows 10 after uninstalling it with PowerShell"  |  https://www.winhelponline.com/blog/restore-windows-store-windows-10-uninstall-with-powershell/
#
# ------------------------------------------------------------