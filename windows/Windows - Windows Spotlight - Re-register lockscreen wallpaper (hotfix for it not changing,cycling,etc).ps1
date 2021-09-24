# ------------------------------------------------------------


If ($True) {
Write-Host "";
Write-Host "True solution is to avoid using Windows Spotlight in general (for its overall bugginess"
Write-Host " |";
Write-Host " |--> Suggestion - Use Application `"Dynamic Theme`", instead @ https://www.microsoft.com/store/productId/9NBLGGH1ZBKW ";
Write-Host "";
} Else {
<# Windows Spotlight - [Attempt to] Re-register lockscreen wallpaper (hotfix for it not changing,cycling,etc) #> 
Get-AppxPackage Microsoft.Windows.ContentDeliveryManager -allusers | foreach {Add-AppxPackage -register "$($_.InstallLocation)\appxmanifest.xml" -DisableDevelopmentMode};
}

# ------------------------------------------------------------
#
# Citation(s)
#
#   www.reddit.com  |  "Powershell to set Windows 10 Lockscreen? : PowerShell"  |  https://www.reddit.com/r/PowerShell/comments/5fglby/powershell_to_set_windows_10_lockscreen/
#
# ------------------------------------------------------------