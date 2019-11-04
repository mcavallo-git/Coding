
$AppNameContains="Lockscreenaswallpaper";

explorer.exe shell:AppsFolder\$(Get-AppxPackage | Where-Object { ("$($_.Name)".Contains("${AppNameContains}")) -Eq $True } | Select-Object -ExpandProperty "PackageFamilyName")!App

# ------------------------------------------------------------
# Citation(s)
#
#  stackoverflow.com  |  "How to Start a Universal Windows App (UWP) from PowerShell in Windows 10?"  |  https://stackoverflow.com/a/48856168
#
# ------------------------------------------------------------