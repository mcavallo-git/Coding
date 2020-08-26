# ------------------------------------------------------------
#
# Split-Path --> Get either dirname or basename (only)
#
If ($True) {
	$FullPath = "${PSCommandPath}";
	$SplitPath_Parent = (Split-Path -Path ("${FullPath}") -Parent);  <# Dirname #>
	$SplitPath_Leaf = (Split-Path -Path ("${FullPath}") -Leaf);  <# Basename #>
	Write-Host "";
	Write-Host "`n `$FullPath = `"${FullPath}`"";
	Write-Host "";
	Write-Host "`n `$SplitPath_Parent  = `"${SplitPath_Parent}`"";
	Write-Host "`n `$SplitPath_Leaf  = `"${SplitPath_Leaf}`"";
}


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
	Write-Host "`n `${PathItem}.Basename  = `"$( ${PathItem}.Basename )`"";
	Write-Host "`n `${PathItem}.Extension  = `"$( ${PathItem}.Extension )`"";
}


# ------------------------------------------------------------
# Ex) Get Current runtime script's directory / basename

$ThisDir = (Split-Path -Path ($MyInvocation.MyCommand.Path) -Parent);

$ThisScript = (Split-Path -Path ($MyInvocation.MyCommand.Name) -Leaf);


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-Item - Gets the item at the specified location"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-item?view=powershell-5.1
#
#   docs.microsoft.com  |  "Split-Path - Returns the specified part of a path"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/split-path?view=powershell-5.1
#
#   stackoverflow.com  |  "file - Removing path and extension from filename in powershell - Stack Overflow"  |  https://stackoverflow.com/a/32634452
#
# ------------------------------------------------------------