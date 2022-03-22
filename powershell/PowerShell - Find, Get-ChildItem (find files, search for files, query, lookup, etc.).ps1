# ------------------------------------------------------------
#
# PowerShell - Get-ChildItem
#
# ------------------------------------------------------------
#
# Get-ChildItem - Find local files whose...
#


# Filename contains "___"
Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { ($_.Name -Like "*___*") } | ForEach-Object { $_.FullName; };


# Filename equals (matches exactly) "___.exe"
Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { $_.Name -Eq "___.exe" } | ForEach-Object { $_.FullName; };


# Filename starts with "___"
Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { ($_.Name -Like "___*") } | ForEach-Object { $_.FullName; };


# Filename ends with "___"
Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { ($_.Name -Like "*___") } | ForEach-Object { $_.FullName; };


#   Filename STARTS WITH ...
#     &&  Filename ENDS WITH ...
Get-ChildItem -Path ("C:\ISO") -File -Recurse -Force -EA:0 | Where-Object { ($_.Name -Like "MATCH_STARTSWITH*") -And ($_.Name -Like "*MATCH_ENDSWITH") } | ForEach-Object { $_.FullName; };


#
#   Filename CONTAINS ...
#     &&  Parent directory's basename CONTAINS ...
#     &&  Grandparent directory's basename CONTAINS ...
#
If ($True) {
	$Dirname_TopLevel="${Env:LOCALAPPDATA}\Packages"; # Directory to search within
	$Basename_FindFilesMatching="*"; # Filename like ....
	$Basename_ParentDirectory="Settings"; # Parent directory matches ...
	$Basename_ParentsParentsDirectory="Microsoft.Windows.ContentDeliveryManager_*"; # Grandparent directory like ...
	Get-ChildItem -Path ("${Env:LOCALAPPDATA}\Packages") -File -Recurse -Force -EA:0 `
		| Where-Object { $_.Directory.Parent.Name -Like "$Basename_ParentsParentsDirectory" } `
		| Where-Object { $_.Directory.Name -Like "$Basename_ParentDirectory" } `
		| Where-Object { $_.Name -Like "$Basename_FindFilesMatching" } `
		| ForEach-Object { $_.FullName; } `
	;
}


# File [ matches filename ... (exactly) ]  &&  [ stop after finding a single file (do not search for more) ]
Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { $_.Name -Eq "MATCH_EXACTLY.exe" } | Select-Object -First 1 | ForEach-Object { $_.FullName; };


# Date-based (based on CreationTime) --> File [ matches filename syntax ... ]  &&  [ is older than ... ]
$FullPath_Pattern = "C:\ISO\*";
$Retention_Days = "90";
$Retention_OldestAllowedDate = (Get-Date).AddDays([int]${Retention_Days} * -1);
Get-ChildItem -Path "$(Split-Path -Path ("${FullPath_Pattern}") -Parent;)" -File -Recurse -Force -EA:0 `
| Where-Object { ($_.Name -Like "$(Split-Path -Path ("${FullPath_Pattern}") -Leaf;)") } `
| Where-Object { $_.CreationTime -LT ${Retention_OldestAllowedDate} } `
| ForEach-Object { $_.FullName; } `
;


# Delete files (to the recycle bin)
#  |--> Date-based (based on LastWriteTime) --> File [ matches filename syntax ... ]  &&  [ is older than ... ]
Add-Type -AssemblyName "Microsoft.VisualBasic"; <# Required to use Recycle Bin action 'SendToRecycleBin' #>
$FullPath_Pattern = "C:\ISO\*";
$Retention_Days = "90";
$Retention_OldestAllowedDate = (Get-Date).AddDays([int]${Retention_Days} * -1);
Get-ChildItem -Path "$(Split-Path -Path ("${FullPath_Pattern}") -Parent;)" -File -Recurse -Force -EA:0 `
| Where-Object { ($_.Name -Like "$(Split-Path -Path ("${FullPath_Pattern}") -Leaf;)") } `
| Where-Object { $_.LastWriteTime -LT ${Retention_OldestAllowedDate} } `
| ForEach-Object { [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile("$(${_}.FullName)",'OnlyErrorDialogs','SendToRecycleBin'); <# Delete file to the Recycle Bin #> } `
;


# ------------------------------------------------------------
#
# Simple search - Example(s)
#

Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { ($_.Name -Like "*.unf") } | ForEach-Object { $_.FullName; }

Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { $_.Name -Eq "Microsoft.Cpp.Default.props" } | ForEach-Object { $_.FullName; }

Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { $_.Name -Eq "mbnapi.h" } | ForEach-Object { $_.FullName; }

Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { $_.Name -Eq "MSBuild.exe" } | ForEach-Object { $_.FullName; }

Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { ($_.Name -Eq "devenv.com") -Or ($_.Name -Eq "devenv.exe") } | ForEach-Object { $_.FullName; }

Get-ChildItem -Path ("C:\") -Directory -Recurse -Force -EA:0 | Where-Object { ($_.Name -Eq "Microsoft Platform SDK") -Or ($_.Name -Eq "mfc") } | ForEach-Object { $_.FullName; }

Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { $_.Name -Like "devenv.*" } | ForEach-Object { $_.FullName; }

Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { $_.Name -Like "vsdevcmd*" } | ForEach-Object { $_.FullName; }

Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { $_.Name -Like "signtool.*" } | ForEach-Object { $_.FullName; }

Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { ($_.Name -Like "vs_*.exe") } | ForEach-Object { $_.FullName; }

Get-ChildItem -Path ("C:\Program Files (x86)") -Depth 1 -Directory -Recurse -Force -EA:0 | Where-Object { $_.Name -Like "WiX Toolset v*" }

Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { $_.Name -Like "*.msixbundle" } | ForEach-Object { $_.FullName; }

Get-ChildItem -Path ("${Home}\Desktop") -File -Recurse -Force -EA:0 | Where-Object { $_.Name -Eq "Appxmanifest.xml" } | ForEach-Object { $_.FullName; }

<# Search at-most [ 9 ] subdirectory-levels deep within parent directory [ C:\ ] (e.g. C:\ is at depth=0) for a file whose basename is equal to [ MSBuild.exe ] #>
Get-ChildItem -Path ("C:\") -File -Recurse -Depth (9) -Force -EA:0 | Where-Object { $_.Name -Eq "MSBuild.exe" };

<# Case IN-sensitive multi-match #>
Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { @("devenv.com","devenv.exe","msbuild.exe").Contains("$($_.Name)".ToLower()) } | ForEach-Object { $_.FullName; }


# ------------------------------------------------------------
#
# TO-DO:  Debug & determine the most effective syntax for file searches between [ [System.IO.Directory]::EnumerateFiles(...) ] and [ Get-Childitem ... ]  (also how to use the former in place of the latter (GCI) in all use cases where GCI can be used)
#
#
#   [System.IO.Directory]::EnumerateFiles("C:\","*.*","AllDirectories"); # MUCH LIGHTER-WEIGHT THAN 'Get-ChildItem' METHOD
#
#
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
#   docs.microsoft.com  |  "Get-ChildItem - Gets the items and child items in one or more specified locations"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-5.1
#
#   stackoverflow.com  |  "Delete files older than 15 days using PowerShell - Stack Overflow"  |  https://stackoverflow.com/a/19326146
#
#   stackoverflow.com  |  "Variables in nested Foreach-Object and Where-Object"  |  https://stackoverflow.com/a/26715697
#
#   superuser.com  |  "Powershell to delete all files with a certain file extension"  |  https://superuser.com/a/1233722
#
#   powershell-guru.com  |  "# The fastest Powershell 4 : Count all files in a large network share"  |  https://powershell-guru.com/fastest-powershell-2-count-all-files-in-large-network-share/
#
#   www.thomasmaurer.ch  |  "PowerShell: Delete Files older than - Thomas Maurer"  |  https://www.thomasmaurer.ch/2010/12/powershell-delete-files-older-than/
#
# ------------------------------------------------------------