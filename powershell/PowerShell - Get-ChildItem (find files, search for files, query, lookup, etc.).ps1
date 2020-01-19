# ------------------------------------------------------------
#
#   PowerShell - Get-ChildItem
#
# ------------------------------------------------------------

$Basename_FindFilesMatching="*";
$Basename_ParentDirectory="Settings"; # one step back (first directory name)
$Basename_ParentsParentsDirectory="Microsoft.Windows.ContentDeliveryManager_*"; # another step back
$Dirname_TopLevel="${Env:USERPROFILE}\AppData\Local\Packages\"; # remaining steps-back to the root directory ("/" in linux, or the drive letter, such as "C:\", in Windows)
(`
Get-ChildItem `
-Path ("$Dirname_TopLevel") `
-Depth (3) `
-File `
-Recurse `
-Force `
-ErrorAction "SilentlyContinue" `
| Where-Object { $_.Directory.Parent.Name -Like "$Basename_ParentsParentsDirectory" } `
| Where-Object { $_.Directory.Name -Like "$Basename_ParentDirectory" } `
| Where-Object { $_.Name -Like "$Basename_FindFilesMatching" } `
| ForEach-Object { $_.FullName; } `
);


# ------------------------------------------------------------
#
#	Citation(s)
#
#   docs.microsoft.com  |  "about_Providers - PowerShell"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_providers
#
#   docs.microsoft.com  |  "about_Wildcards - PowerShell"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_wildcards
#
#   docs.microsoft.com  |  "DirectoryInfo Class (System.IO)"  |  https://docs.microsoft.com/en-us/dotnet/api/system.io.directoryinfo
#
#   docs.microsoft.com  |  "FileInfo Class (System.IO)"  |  https://docs.microsoft.com/en-us/dotnet/api/system.io.fileinfo
#
#   docs.microsoft.com  |  "ForEach-Object"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/foreach-object
#
#   stackoverflow.com  |  "Variables in nested Foreach-Object and Where-Object"  |  https://stackoverflow.com/a/26715697
#
#   superuser.com  |  "Powershell to delete all files with a certain file extension"  |  https://superuser.com/a/1233722
#
# ------------------------------------------------------------