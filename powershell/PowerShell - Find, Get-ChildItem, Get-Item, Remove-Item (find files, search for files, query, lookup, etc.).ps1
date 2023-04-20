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


# Filename equals (matches exactly) "___"
Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { $_.Name -Eq "___" } | ForEach-Object { $_.FullName; };


# Filename equals (matches exactly) "___.exe"
Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { $_.Name -Eq "___.exe" } | ForEach-Object { $_.FullName; };


# Filename ends with a given file extension ".exe"
Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { ($_.Name -Like "*.exe") } | ForEach-Object { $_.FullName; };


# Filename equals (matches regex) "PATTERN"
Get-ChildItem -Path ("${HOME}") -File -Recurse -Force -EA:0 | Where-Object { ([Regex]::Match($_.FullName,"^C:\\Users\\${env:USERNAME}\\[^\\]*$")).Success; } | ForEach-Object { $_.FullName; };  <# Gets all files 0 levels deep in current userprofile dir #>


# Filename starts with "___"
Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { ($_.Name -Like "___*") } | ForEach-Object { $_.FullName; };


# Filename ends with "___"
Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { ($_.Name -Like "*___") } | ForEach-Object { $_.FullName; };


# Parent directory name equals "_____"
Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { ($_.Directory.Name -Eq "_____") } | ForEach-Object { $_.FullName; };


# Filename STARTS WITH ...
#  &&  Filename ENDS WITH ...
Get-ChildItem -Path ("C:\ISO") -File -Recurse -Force -EA:0 | Where-Object { ($_.Name -Like "MATCH_STARTSWITH*") -And ($_.Name -Like "*MATCH_ENDSWITH") } | ForEach-Object { $_.FullName; };


#
# Filename CONTAINS ...
#  &&  Parent directory's basename CONTAINS ...
#  &&  Grandparent directory's basename CONTAINS ...
#
If ($True) {
	$Dirname_TopLevel="${Env:LOCALAPPDATA}\Packages"; # Directory to search within
	$Basename_FindFilesMatching="*"; # Filename pattern to match against
	$Basename_ParentDirectory="Settings"; # Parent directory pattern to match against
	$Basename_ParentsParentsDirectory="Microsoft.Windows.ContentDeliveryManager_*"; # Grandparent directory pattern to match against
	$Basename_ParentsParentsParentsDirectory="*"; # Great Grandparent directory pattern to match against
	Get-ChildItem -Path ("${Dirname_TopLevel}") -File -Recurse -Force -EA:0 `
		| Where-Object { $_.Directory.Parent.Parent.Name -Like "${Basename_ParentsParentsParentsDirectory}" } `
		| Where-Object { $_.Directory.Parent.Name -Like "${Basename_ParentsParentsDirectory}" } `
		| Where-Object { $_.Directory.Name -Like "${Basename_ParentDirectory}" } `
		| Where-Object { $_.Name -Like "${Basename_FindFilesMatching}" } `
		| ForEach-Object { $_.FullName; } `
	;
}


# File [ matches filename ... (exactly) ]  &&  [ stop after finding a single file (do not search for more) ]
Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { $_.Name -Eq "MATCH_EXACTLY.exe" } | Select-Object -First 1 | ForEach-Object { $_.FullName; };


# ------------------------------------------------------------
#
# WARNING:  Using Remove-Item DOES NOT allow file to be recovered (cannot restore from Recycle Bin)
#

# Permanently delete a file (skips recycle bin)
Remove-Item -Path ("${env:USERPROFILE}\Desktop\tester.txt") -Force -Confirm:$False;

# Permanently delete a directory (skips recycle bin)
Remove-Item -Path ("${env:USERPROFILE}\Desktop\tester") -Recurse -Force -Confirm:$False;


# Delete a file (to the recycle bin)
$Filepath_ToDelete="${env:USERPROFILE}\Desktop\tester.txt"; Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile("${Filepath_ToDelete}",'OnlyErrorDialogs','SendToRecycleBin'); <# Delete file to the Recycle Bin #>

# Delete a directory (to the recycle bin)
$Filepath_ToDelete="${env:USERPROFILE}\Desktop\tester"; Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory("${Filepath_ToDelete}",'OnlyErrorDialogs','SendToRecycleBin'); <# Delete directory to the Recycle Bin #>


# ------------------------------------------------------------

# Find old files
$FullPath_Pattern = "C:\ISO\*";
$Retention_Days = "90";
$Retention_OldestAllowedDate = (Get-Date).AddDays([int]${Retention_Days} * -1);
Get-ChildItem -Path "$(Split-Path -Path ("${FullPath_Pattern}") -Parent;)" -File -Recurse -Force -EA:0 `
| Where-Object { ($_.Name -Like "$(Split-Path -Path ("${FullPath_Pattern}") -Leaf;)") } `
| Where-Object { $_.CreationTime -LT ${Retention_OldestAllowedDate} } `
| ForEach-Object { $_.FullName; } `
;


# Delete old files (to the recycle bin)
Add-Type -AssemblyName "Microsoft.VisualBasic"; <# Required to use Recycle Bin action 'SendToRecycleBin' #>
$FullPath_Pattern = "C:\ISO\*";
$Retention_Days = "90";
$Retention_OldestAllowedDate = (Get-Date).AddDays([int]${Retention_Days} * -1);
Get-ChildItem -Path "$(Split-Path -Path ("${FullPath_Pattern}") -Parent;)" -File -Recurse -Force -EA:0 `
| Where-Object { ($_.Name -Like "$(Split-Path -Path ("${FullPath_Pattern}") -Leaf;)") } `
| Where-Object { $_.LastWriteTime -LT ${Retention_OldestAllowedDate} } `
| ForEach-Object { [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile("$(${_}.FullName)",'OnlyErrorDialogs','SendToRecycleBin'); <# Delete file to the Recycle Bin #> } `
;


# Delete old files (permanently - skips recycle bin)
$FullPath_Pattern = "C:\ISO\*";
$Retention_Days = "90";
$Retention_OldestAllowedDate = (Get-Date).AddDays([int]${Retention_Days} * -1);
Get-ChildItem -Path "$(Split-Path -Path ("${FullPath_Pattern}") -Parent;)" -File -Recurse -Force -EA:0 `
| Where-Object { ($_.Name -Like "$(Split-Path -Path ("${FullPath_Pattern}") -Leaf;)") } `
| Where-Object { $_.LastWriteTime -LT ${Retention_OldestAllowedDate} } `
| Remove-Item -Recurse -Force -Confirm:$False `
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
# File files matching "*.json" nested exactly two folders deep within current directory
#

(Get-Item ".\*\*.json") | Format-List *;


# ------------------------------------------------------------
#
# Remove files (after verifying that they exist)
#

$Parent_Directory = ".";
$Filenames_To_Remove = @();
$Filenames_To_Remove += ("metadata.json");
Get-ChildItem -Path ("${Parent_Directory}") -File -Recurse -Depth (1) -Force -ErrorAction "SilentlyContinue" `
| Where-Object { (${Filenames_To_Remove}) -Contains ("$($_.Name)"); } `
| ForEach-Object { `
	$Each_Fullpath = ("$($_.FullName)");
	Write-Host "Removing file with path  `"${Each_Fullpath}`"  ..."; `
	Remove-Item -Path ("${Each_Fullpath}") -Force; `
}


# ------------------------------------------------------------
#
# Get all different language types from amongst target files
#
Get-ChildItem -Path ("C:\Windows\System32") -File -Recurse -Depth (0) -Force -ErrorAction "SilentlyContinue" `
| ForEach-Object { If (($_.VersionInfo) -NE ($Null)) { $_.VersionInfo.Language; }; } `
| Select-Object -Unique `
| Sort-Object `
;


# ------------------------------------------------------------
#
# Show filepaths for files based in the [ Chinese ] language
#
Get-ChildItem -Path ("C:\Windows\System32") -File -Recurse -Depth (0) -Force -ErrorAction "SilentlyContinue" `
| Where-Object { If (($_.VersionInfo) -NE ($Null)) { $_.VersionInfo.Language -Like "*Chinese*"; } Else { $False; }; } `
| ForEach-Object { $_.FullName; } `


# ------------------------------------------------------------
#
# Get-Item --> Get target filepath's dirname, basename, file-extension, etc.
#
If ($True) {
	$FullPath = "${PSCommandPath}";
	$PathItem = (Get-Item -Path "${FullPath}");
	Write-Host "";
	Write-Host "`n `${PathItem}.FullName  = `"$( ${PathItem}.FullName )`"";
	Write-Host "`n `${PathItem}.DirectoryName  = `"$( ${PathItem}.DirectoryName )`"";
	Write-Host "`n `${PathItem}.Name  = `"$( ${PathItem}.Name )`"";
	Write-Host "`n `${PathItem}.BaseName  = `"$( ${PathItem}.BaseName )`"";
	Write-Host "`n `${PathItem}.Extension  = `"$( ${PathItem}.Extension )`"";
}


# ------------------------------------------------------------
#
# EX) Google Photos Export --> Update media's "Date Created" timestamp/datetime on media files based off of their included (exported) JSON metadata files' contents
#

### REFER TO:  "PowerShell - Google Photo Export Cleanup.ps1"  (in the same source-repository as this file)


# ------------------------------------------------------------
#
# EX) Remove ASUS' existent leftover executables (from "C:\Windows\System32")
#

Get-ChildItem -Path ("C:\Windows\System32") -File -Recurse -Depth (1) -Force -ErrorAction "SilentlyContinue" `
| Where-Object { @("AsusDownloadAgent.exe", "AsusDownLoadLicense.exe", "AsusUpdateCheck.exe") -Contains ("$($_.Name)"); } `
| ForEach-Object { `
	$Each_Fullpath = ("$($_.FullName)");
	Write-Host "Removing file with path  `"${Each_Fullpath}`"  ..."; `
	Remove-Item -Path ("${Each_Fullpath}") -Recurse -Force -Confirm:$False; `
} `
;


# ------------------------------------------------------------
#
# Delete files (to the recycle bin)
#  |--> Date-based (based on LastWriteTime) --> File [ matches filename syntax ... ]  &&  [ is older than ... ]
#

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
#   docs.microsoft.com  |  "about_Properties - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_properties?view=powershell-5.1
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
#   docs.microsoft.com  |  "Get-Item - Gets the item at the specified location"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-item?view=powershell-5.1
#
#   learn.microsoft.com  |  "FileSystem.DeleteDirectory Method (Microsoft.VisualBasic.FileIO) | Microsoft Learn"  |  https://learn.microsoft.com/en-us/dotnet/api/microsoft.visualbasic.fileio.filesystem.deletedirectory
#
#   learn.microsoft.com  |  "Remove-Item (Microsoft.PowerShell.Management) - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item
#
#   powershell-guru.com  |  "# The fastest Powershell 4 : Count all files in a large network share"  |  https://powershell-guru.com/fastest-powershell-2-count-all-files-in-large-network-share/
#
#   stackoverflow.com  |  "Delete files older than 15 days using PowerShell - Stack Overflow"  |  https://stackoverflow.com/a/19326146
#
#   stackoverflow.com  |  "How can I delete files with PowerShell without confirmation? - Stack Overflow"  |  https://stackoverflow.com/a/43611773
#
#   stackoverflow.com  |  "Variables in nested Foreach-Object and Where-Object"  |  https://stackoverflow.com/a/26715697
#
#   superuser.com  |  "Powershell to delete all files with a certain file extension"  |  https://superuser.com/a/1233722
#
#   www.thomasmaurer.ch  |  "PowerShell: Delete Files older than - Thomas Maurer"  |  https://www.thomasmaurer.ch/2010/12/powershell-delete-files-older-than/
#
# ------------------------------------------------------------