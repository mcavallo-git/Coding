# ------------------------------------------------------------


Copy-Item -Path ($From) -Destination ($To) -Force;


# ------------------------------------------------------------
#
# REMOVE FILES WHILE FIRST VERIFYING THAT THEY EXIST
#

$Parent_Directory = "C:\Windows\System32";
$Filenames_To_Remove = @();
$Filenames_To_Remove += ("AsusDownloadAgent.exe");
$Filenames_To_Remove += ("AsusDownLoadLicense.exe");
$Filenames_To_Remove += ("AsusUpdateCheck.exe");
Get-ChildItem -Path ("${Parent_Directory}") -File -Recurse -Depth (1) -Force -ErrorAction "SilentlyContinue" `
| Where-Object { (${Filenames_To_Remove}) -Contains ("$($_.Name)"); } `
| ForEach-Object { `
	$Each_Fullpath = ("$($_.FullName)");
	Write-Host "Removing file with path  `"${Each_Fullpath}`"  ..."; `
	Remove-Item -Path ("${Each_Fullpath}") -Force; `
} `
;


#
# GET ALL DIFFERENT LANGUAGE-TYPES HELD WITHIN TARGET FILES
#
Get-ChildItem -Path ("C:\Windows\System32") -File -Recurse -Depth (0) -Force -ErrorAction "SilentlyContinue" `
| ForEach-Object { If (($_.VersionInfo) -NE ($Null)) { $_.VersionInfo.Language; }; } `
| Select-Object -Unique `
| Sort-Object `
;


#
# SHOW FILEPATHS FOR FILES BASED IN CHINESE
#
Get-ChildItem -Path ("C:\Windows\System32") -File -Recurse -Depth (0) -Force -ErrorAction "SilentlyContinue" `
| Where-Object { If (($_.VersionInfo) -NE ($Null)) { $_.VersionInfo.Language -Like "*Chinese*"; } Else { $False; }; } `
| ForEach-Object { $_.FullName; } `



# ------------------------------------------------------------
#
# Ex) REMOVE ASUS' EXISTENT LEFTOVER EXECUTABLES (FROM "C:\Windows\System32")
#

Get-ChildItem -Path ("C:\Windows\System32") -File -Recurse -Depth (1) -Force -ErrorAction "SilentlyContinue" `
| Where-Object { @("AsusDownloadAgent.exe", "AsusDownLoadLicense.exe", "AsusUpdateCheck.exe") -Contains ("$($_.Name)"); } `
| ForEach-Object { `
	$Each_Fullpath = ("$($_.FullName)");
	Write-Host "Removing file with path  `"${Each_Fullpath}`"  ..."; `
	Remove-Item -Path ("$Each_Fullpath") -Recurse -Force -Confirm:$false; `
} `
;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Copy-Item - Copies an item from one location to another"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/copy-item?view=powershell-5.1
#
#   docs.microsoft.com  |  "Get-ChildItem - Gets the items and child items in one or more specified locations"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-5.1
#
#   docs.microsoft.com  |  "Get-Item - Gets the item at the specified location"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-item?view=powershell-5.1
#
#   docs.microsoft.com  |  "Remove-Item - Deletes the specified items"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-5.1
#
# ------------------------------------------------------------