
$AppNameContains="Lockscreenaswallpaper";

explorer.exe shell:AppsFolder\$(Get-AppxPackage | Where-Object { ("$($_.Name)".Contains("${AppNameContains}")) -Eq $True } | Select-Object -ExpandProperty "PackageFamilyName")!App


# ------------------------------------------------------------
# Task Scheduler Action:
#   Program/script:   C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
#   Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\windows\LockScreenAsWallpaper\LockScreenAsWallpaper.ps1"
# 
# ------------------------------------------------------------
# Citation(s)
#
#  stackoverflow.com  |  "How to Start a Universal Windows App (UWP) from PowerShell in Windows 10?"  |  https://stackoverflow.com/a/48856168
#
# ------------------------------------------------------------