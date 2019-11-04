CreateObject( "WScript.Shell" ).Run "PowerShell -Command ""explorer.exe shell:AppsFolder\$(Get-AppxPackage | Where-Object { ($($_.Name).Contains('Lockscreenaswallpaper')) -Eq $True } | Select-Object -ExpandProperty 'PackageFamilyName')!App;"" ", 0, True

' Program/script:   C:\Windows\System32\wscript.exe
' Add arguments:    "%USERPROFILE%\Documents\GitHub\Coding\visual basic\LockScreenAsWallpaperNonAdmin.vbs"
