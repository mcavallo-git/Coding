# ------------------------------------------------------------
#
#   PowerShell - Get-ChildItem
#
# ------------------------------------------------------------

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
| ForEach-Object { $_.FullName; } `
);


# ------------------------------------------------------------
#
#	Citation(s)
#
#   docs.microsoft.com  |  "DirectoryInfo Class (System.IO)"  |  https://docs.microsoft.com/en-us/dotnet/api/system.io.directoryinfo
#
#   docs.microsoft.com  |  "FileInfo Class (System.IO)"  |  https://docs.microsoft.com/en-us/dotnet/api/system.io.fileinfo
#
#   docs.microsoft.com  |  "about_Providers - PowerShell"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_providers
#
#   docs.microsoft.com  |  "about_Wildcards - PowerShell"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_wildcards
#
#   stackoverflow.com  |  "Variables in nested Foreach-Object and Where-Object"  |  https://stackoverflow.com/a/26715697
#
#   superuser.com  |  "Powershell to delete all files with a certain file extension"  |  https://superuser.com/a/1233722
#
# ------------------------------------------------------------
