# ------------------------------------------------------------


Copy-Item -Path ($From) -Destination ($To) -Force;


# ------------------------------------------------------------
#
# FIND FILES MATCHING FILENAME *.JSON TWO FOLDERS DEEP WITHIN CURRENT DIRECTORY
#

(Get-Item ".\*\*.json") | Format-List *;


# ------------------------------------------------------------
#
# REMOVE FILES WHILE FIRST VERIFYING THAT THEY EXIST
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
# GET ALL DIFFERENT LANGUAGE-TYPES HELD WITHIN TARGET FILES
#
Get-ChildItem -Path ("C:\Windows\System32") -File -Recurse -Depth (0) -Force -ErrorAction "SilentlyContinue" `
| ForEach-Object { If (($_.VersionInfo) -NE ($Null)) { $_.VersionInfo.Language; }; } `
| Select-Object -Unique `
| Sort-Object `
;


# ------------------------------------------------------------
#
# SHOW FILEPATHS FOR FILES BASED IN CHINESE
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
	Write-Host "`n `${PathItem}.Basename  = `"$( ${PathItem}.Basename )`"";
	Write-Host "`n `${PathItem}.Extension  = `"$( ${PathItem}.Extension )`"";
}


# ------------------------------------------------------------
#
# EX) GOOGLE PHOTOS EXPORTS --> UPDATE MEDIA'S DATE-CREATED TIMESTAMP/DATETIME ON MEDIA FILES BASED OFF OF THEIR ASSOCIATED METADATA (JSON) FILES' CONTENTS
#

### REFER TO:  "PowerShell - Google Photo Export Cleanup.ps1"  (in the same source-repository as this file)


# ------------------------------------------------------------
#
# EX) REMOVE ASUS' EXISTENT LEFTOVER EXECUTABLES (FROM "C:\Windows\System32")
#

Get-ChildItem -Path ("C:\Windows\System32") -File -Recurse -Depth (1) -Force -ErrorAction "SilentlyContinue" `
| Where-Object { @("AsusDownloadAgent.exe", "AsusDownLoadLicense.exe", "AsusUpdateCheck.exe") -Contains ("$($_.Name)"); } `
| ForEach-Object { `
	$Each_Fullpath = ("$($_.FullName)");
	Write-Host "Removing file with path  `"${Each_Fullpath}`"  ..."; `
	Remove-Item -Path ("$Each_Fullpath") -Recurse -Force -Confirm:$False; `
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
# Citation(s)
#
#   docs.microsoft.com  |  "about_Properties - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_properties?view=powershell-5.1
#
#   docs.microsoft.com  |  "Copy-Item - Copies an item from one location to another"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/copy-item?view=powershell-5.1
#
#   docs.microsoft.com  |  "Get-ChildItem - Gets the items and child items in one or more specified locations"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-5.1
#
#   docs.microsoft.com  |  "Get-Item - Gets the item at the specified location"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-item?view=powershell-5.1
#
#   docs.microsoft.com  |  "Remove-Item - Deletes the specified items"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-item?view=powershell-5.1
#
#   stackoverflow.com  |  "How can I delete files with PowerShell without confirmation? - Stack Overflow"  |  https://stackoverflow.com/a/43611773
#
# ------------------------------------------------------------