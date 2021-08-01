# ------------------------------------------------------------
#
# Split-Path --> Get either dirname or basename (only)
#
If ($True) {
	$FullPath = "${PSHOME}";
	$SplitPath_Parent = (Split-Path -Path ("${FullPath}") -Parent);  <# Dirname #>
	$SplitPath_Leaf = (Split-Path -Path ("${FullPath}") -Leaf);  <# Basename #>
	Write-Host "";
	Write-Host "`n `$FullPath = `"${FullPath}`"";
	Write-Host "";
	Write-Host "`n `$SplitPath_Parent  = `"${SplitPath_Parent}`"";
	Write-Host "`n `$SplitPath_Leaf  = `"${SplitPath_Leaf}`"";
}
If ($True) {
	$Dirname_System32 = (Split-Path -Path ("${Env:ComSpec}") -Parent);
}


# ------------------------------------------------------------
#
# IO.Path --> Get basename without extension or get just the extension
#
If ($True) {
	$FullPath = "C:\foo.txt";
	$Basename_NoExt = [IO.Path]::GetFileNameWithoutExtension("${FullPath}");
	$ExtensionOnly = [IO.Path]::GetExtension("${FullPath}");
	$DirNameOnly = [IO.Path]::GetDirectoryName("${FullPath}");
	Write-Host "";
	Write-Host "`n `$FullPath = `"${FullPath}`"";
	Write-Host "`n `$Basename_NoExt  = `"${Basename_NoExt}`"";
	Write-Host "`n `$ExtensionOnly  = `"${ExtensionOnly}`"";
	Write-Host "`n `$DirNameOnly  = `"${DirNameOnly}`"";
	Write-Host "";
}


# ------------------------------------------------------------
#
# Get-Item --> Get target filepath's dirname, basename, file-extension, etc.
#
If ($True) {
	$FullPath = "${PSHOME}";
	$PathItem = (Get-Item -Path "${FullPath}");
	Write-Host "";
	$PathItem | Format-List -Property ([String][Char]42);
	# Write-Host "`n `${PathItem}.FullName  = `"$( ${PathItem}.FullName )`"";              <# File's Fullpath #>
	# Write-Host "`n `${PathItem}.Name  = `"$( ${PathItem}.Name )`"";                      <# File's Basename #>
	# Write-Host "`n `${PathItem}.Basename  = `"$( ${PathItem}.Basename )`"";              <# File's Basename w/o Extension #>
	# Write-Host "`n `${PathItem}.Extension  = `"$( ${PathItem}.Extension )`"";            <# File's Extension #>
	# Write-Host "`n `${PathItem}.DirectoryName  = `"$( ${PathItem}.DirectoryName )`"";    <# Directory Fullpath #>
	# Write-Host "`n `${PathItem}.DirectoryName  = `"$( ${PathItem}.Directory )`"";        <# Directory File-Object #>
	# Write-Host "`n `${PathItem}.Directory.Name  = `"$( ${PathItem}.Directory.Name )`"";  <# Directory's Basename #>
	# Write-Host "`n `${PathItem}.Directory.Parent.FullName  = `"$( ${PathItem}.Directory.Parent.FullName )`"";  <# Directory's Parent-Directory's Fullpath #>
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
#   stackoverflow.com  |  "file - Removing path and extension from filename in powershell - Stack Overflow"  |  https://stackoverflow.com/a/12503910
#
#   stackoverflow.com  |  "file - Removing path and extension from filename in powershell - Stack Overflow"  |  https://stackoverflow.com/a/32634452
#
# ------------------------------------------------------------