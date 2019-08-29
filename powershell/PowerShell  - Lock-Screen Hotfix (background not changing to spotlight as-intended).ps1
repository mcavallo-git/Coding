
# Clear the cache containing this user's lock-screen background config
$Basename="*";
$Parent_1="Settings"; # one step back (first directory name)
$Parent_2="Microsoft.Windows.ContentDeliveryManager_*"; # another step back
$Parent_X="${Env:USERPROFILE}\AppData\Local\Packages\"; # remaining steps-back to the root directory ("/" in linux, or the drive letter, such as "C:\", in Windows)
(`
Get-ChildItem `
-Path ("$Parent_X") `
-Depth (3) `
-File `
-Recurse `
-Force `
-ErrorAction "SilentlyContinue" `
| Where-Object { $_.Directory.Parent.Name -Like "$Parent_2" } `
| Where-Object { $_.Directory.Name -Like "$Parent_1" } `
| Where-Object { $_.Name -Like "$Basename" } `
| ForEach-Object { Remove-Item -Path ($_.FullName) -Force -Recurse; } `
);

# Open Win10's "Lock screen	"Settings
start ms-settings:lockscreen;

# ------------------------------------------------------------
#
#	Citation(s)
#
#		youtube.com  |  "How to fix Lockscreen Wallpaper not changing issue in Windows 10"  |  https://www.youtube.com/watch?v=rZo4Ste8NfU
#
#		ss64.com  |  "ms-settings"  |  https://ss64.com/nt/syntax-settings.html
#
#		docs.microsoft.com  |  "Launch the Windows Settings app"  |  https://docs.microsoft.com/en-us/windows/uwp/launch-resume/launch-settings-app
#
# ------------------------------------------------------------