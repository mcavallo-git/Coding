# ------------------------------------------------------------
#
#   PowerShell - Get-ChildItem
#
# ------------------------------------------------------------
#
# Simple search
#

Get-ChildItem -Path ("C:\") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Name -Eq "Common.Logging.dll" } | ForEach-Object { $_.FullName; }

Get-ChildItem -Path ("C:\") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Name -Eq "Microsoft.Cpp.Default.props" } | ForEach-Object { $_.FullName; }

Get-ChildItem -Path ("C:\") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Name -Eq "MSBuild.exe" } | ForEach-Object { $_.FullName; }

Get-ChildItem -Path ("C:\") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { ($_.Name -Eq "devenv.com") -Or ($_.Name -Eq "devenv.exe") } | ForEach-Object { $_.FullName; }

Get-ChildItem -Path ("C:\") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Name -Like "devenv.*" } | ForEach-Object { $_.FullName; }

Get-ChildItem -Path ("C:\") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Name -Like "*devenv*" } | ForEach-Object { $_.FullName; }

Get-ChildItem -Path ("C:\") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { ($_.Name -Like "vs_*.exe") } | ForEach-Object { $_.FullName; }

Get-ChildItem -Path ("C:\Program Files (x86)") -Depth 1 -Directory -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Name -Like "WiX Toolset v*" }

<# Search at-most [ 9 ] subdirectory-levels deep within parent directory [ C:\ ] (e.g. C:\ is at depth=0) for a file whose basename is equal to [ MSBuild.exe ] #>
Get-ChildItem -Path ("C:\") -File -Recurse -Depth (9) -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Name -Eq "MSBuild.exe" };


# ------------------------------------------------------------
#
# Advanced search
#


$Basename_FindFilesMatching="*";
$Basename_ParentDirectory="Settings"; # one step back (first directory name)
$Basename_ParentsParentsDirectory="Microsoft.Windows.ContentDeliveryManager_*"; # another step back
$Dirname_TopLevel="${Env:USERPROFILE}\AppData\Local\Packages"; # remaining steps-back to the root directory ("/" in linux, or the drive letter, such as "C:\", in Windows)
(`
Get-ChildItem -Path ("$Dirname_TopLevel") -File -Recurse -Force -ErrorAction "SilentlyContinue" `
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