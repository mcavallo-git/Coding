<# Add the directory name to all contained files using the format "[directory-name] filename.ext" #>
Get-ChildItem "${Home}\Desktop\*.mp3" | ForEach-Object {
	$TagLib_FullName = "$($_.FullName)";
	$TagLib_Basename = "$($_.Name)";
	$TagLib_Dir_Basename = "$($_.Directory.Name)";
	$TagLib_Dir_Dirname = "$($_.Directory.Parent.FullName)";  <# Directory's Parent-Directory's Fullpath #>
	$Taglib_NewFullname = "${TagLib_Dir_Dirname}\${TagLib_Dir_Basename}\[${TagLib_Dir_Basename}] ${TagLib_Basename}";
	Write-Host "`n `${TagLib_FullName}  = `"${TagLib_FullName}`"";
	Write-Host "`n `${TagLib_Basename}  = `"${TagLib_Basename}`"";
	Write-Host "`n `${TagLib_Dir_Basename}  = `"${TagLib_Dir_Basename}`"";
	Write-Host "`n `${TagLib_Dir_Dirname}  = `"${TagLib_Dir_Dirname}`"";
	Write-Host "`n `${Taglib_NewFullname}  = `"${Taglib_NewFullname}`"";
	Rename-Item -Path "${TagLib_FullName}" -NewName "${Taglib_NewFullname}";
};


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Rename-Item (Microsoft.PowerShell.Management) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/rename-item?view=powershell-5.1
#
# ------------------------------------------------------------