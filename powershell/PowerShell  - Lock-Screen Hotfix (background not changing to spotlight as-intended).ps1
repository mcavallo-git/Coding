# ------------------------------------------------------------
#####  REM - VIA CMD:
#####		: Reset Windows Spotlight
#####		DEL /F /S /Q /A "%USERPROFILE%/AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
#####		DEL /F /S /Q /A "%USERPROFILE%/AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\Settings"

#####		:: Re-register Windows Spotlight
#####		PowerShell -ExecutionPolicy Unrestricted -Command "& {$manifest = (Get-AppxPackage *ContentDeliveryManager*).InstallLocation + '\AppxManifest.xml' ; Add-AppxPackage -DisableDevelopmentMode -Register $manifest}"



#	------------------------------------------------------------
#	Reset Spotlight - Remove all files in the Spotlight dir "LocalState\Assets"

$Basename="*";
$Parent_1="Assets"; # one step back (first directory name)
$Parent_2="LocalState"; # one step back (first directory name)
$Parent_3="Microsoft.Windows.ContentDeliveryManager_*"; # another step back
$Parent_X="${Env:USERPROFILE}\AppData\Local\Packages\"; # remaining steps-back to the root directory ("/" in linux, or the drive letter, such as "C:\", in Windows)

Get-ChildItem `
-Path ("$Parent_X") `
-Depth (4) `
-Force `
-ErrorAction "SilentlyContinue" `
| Where-Object { $_.Directory.Parent.Parent.Name -Like "$Parent_3" } `
| Where-Object { $_.Directory.Parent.Name -Like "$Parent_2" } `
| Where-Object { $_.Directory.Name -Like "$Parent_1" } `
| Where-Object { $_.Name -Like "$Basename" } `
| ForEach-Object { Remove-Item -Path ($_.FullName) -Force -Recurse; } `
;
Start-Sleep -Seconds 2;



#	------------------------------------------------------------
#	Reset Spotlight - Remove all files in the Spotlight dir "Settings"

$Basename="*";
$Parent_1="Settings"; # one step back (first directory name)
$Parent_2="Microsoft.Windows.ContentDeliveryManager_*"; # another step back
$Parent_X="${Env:USERPROFILE}\AppData\Local\Packages\"; # remaining steps-back to the root directory ("/" in linux, or the drive letter, such as "C:\", in Windows)

Get-ChildItem `
-Path ("$Parent_X") `
-Depth (3) `
-Force `
-ErrorAction "SilentlyContinue" `
| Where-Object { $_.Directory.Parent.Name -Like "$Parent_2" } `
| Where-Object { $_.Directory.Name -Like "$Parent_1" } `
| Where-Object { $_.Name -Like "$Basename" } `
| ForEach-Object { Remove-Item -Path ($_.FullName) -Force -Recurse; } `
;
Start-Sleep -Seconds 2;



#	------------------------------------------------------------
#	Re-register Windows Spotlight
Get-AppxPackage `
-Name "Microsoft.Windows.ContentDeliveryManager" `
-User "$(whoami)" `
| ForEach {

Add-AppxPackage `
-Path ("$($_.InstallLocation)\AppxManifest.xml") `
-Register `
-DisableDevelopmentMode `
;

};
Start-Sleep -Seconds 2;


# ------------------------------------------------------------
# Open "Lock screen" Settings
start ms-settings:lockscreen;

# Set "Background" to "Picture" (select any picture)

# Set "Background" to "Windows Spotlight"



#	------------------------------------------------------------

# Restart Workstation



# ------------------------------------------------------------
#
#	Citation(s)
#
#		tenforums.com  |  "How to Reset and Re-register Windows Spotlight in Windows 10"  |  https://www.tenforums.com/tutorials/82156-reset-re-register-windows-spotlight-windows-10-a.html
#
#		windowscentral.com  |  "How to fix Windows Spotlight Lock screen errors on Windows 10"  |  https://www.windowscentral.com/how-fix-windows-spotlight-stuck-same-image-windows-10
#
#		ss64.com  |  "ms-settings"  |  https://ss64.com/nt/syntax-settings.html
#
#		docs.microsoft.com  |  "Launch the Windows Settings app"  |  https://docs.microsoft.com/en-us/windows/uwp/launch-resume/launch-settings-app
#
#		docs.microsoft.com  |  "Get-AppxPackage - Gets a list of the app packages that are installed in a user profile"  |  https://docs.microsoft.com/en-us/powershell/module/appx/get-appxpackage
#
#		docs.microsoft.com  |  "Add-AppxPackage - Adds a signed app package to a user account"  |  https://docs.microsoft.com/en-us/powershell/module/appx/add-appxpackage
#
# ------------------------------------------------------------