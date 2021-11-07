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


# Filename EQUALS (matches exactly) ...
#   &&  Only return the first matched file found
Get-ChildItem -Path ("C:\") -File -Recurse -Force -EA:0 | Where-Object { $_.Name -Eq "MATCH_EXACTLY.exe" } | Select-Object -First 1 | ForEach-Object { $_.FullName; };


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
# TO-DO:  Debug & resolve most effective syntax for using "[System.IO.Directory]::EnumerateFiles(...)" in place of "Get-Childitem ..." (if applicable)
#

# [System.IO.Directory]::EnumerateFiles("C:\","*.*","AllDirectories"); # MUCH LIGHTER-WEIGHT THAN 'Get-ChildItem' METHOD


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
#   stackoverflow.com  |  "Variables in nested Foreach-Object and Where-Object"  |  https://stackoverflow.com/a/26715697
#
#   superuser.com  |  "Powershell to delete all files with a certain file extension"  |  https://superuser.com/a/1233722
#
#   powershell-guru.com  |  "# The fastest Powershell 4 : Count all files in a large network share"  |  https://powershell-guru.com/fastest-powershell-2-count-all-files-in-large-network-share/
#
# ------------------------------------------------------------