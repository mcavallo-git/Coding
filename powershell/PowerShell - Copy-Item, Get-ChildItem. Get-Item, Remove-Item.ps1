# ------------------------------------------------------------


Copy-Item -Path ($From) -Destination ($To) -Force;


# ------------------------------------------------------------
#
# FIND FILES MATCHING FILENAME *.JSON TWO FOLDERS DEEP WITHIN CURRENT DIRECTORY
#

(Get-Item ".\*\*.json") | Format-List *;


# ------------------------------------------------------------
#
# GOOGLE PHOTOS EXPORTS --> UPDATE MEDIA'S DATE-CREATED TIMESTAMP/DATETIME ON MEDIA FILES BASED OFF OF THEIR ASSOCIATED METADATA (JSON) FILES' CONTENTS
#

# Download and use "Json-Decoder" instead of using less-powerful (but native) "ConvertFrom-Json"
Set-ExecutionPolicy -ExecutionPolicy "Bypass" -Scope "CurrentUser" -Force; New-Item -Force -ItemType "File" -Path ("${Env:TEMP}\JsonDecoder.psm1") -Value (($(New-Object Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/JsonDecoder/JsonDecoder.psm1"))) | Out-Null; Import-Module -Force ("${Env:TEMP}\JsonDecoder.psm1");

<# Locate all json metadata files #>
(Get-Item ".\*\*.json") | ForEach-Object {
	$EachMetadata_Fullpath = ($_.FullName);
	$EachMetadata_BaseName= ($_.BaseName);
	$EachMetadata_DirectoryName = ($_.DirectoryName);
	$EachMediaFile_Fullpath = "${EachMetadata_DirectoryName}\${EachMetadata_BaseName}";
	<# Ensure associated media-file exists #>
	If (Test-Path "${EachMediaFile_Fullpath}") {
		<# Get the date-created timestamp/datetime from the json-file #>
		$EachMetadata_Contents = [IO.File]::ReadAllText("${EachMetadata_Fullpath}");
		$EachMetadata_Object = JsonDecoder -InputObject (${EachMetadata_Contents});
		$EachCreation_EpochSeconds = $EachMetadata_Object.creationTime.timestamp;
		$EachCreation_DateTime = (New-Object -Type DateTime -ArgumentList 1970, 1, 1, 0, 0, 0, 0).AddSeconds([Math]::Floor($EachCreation_EpochSeconds));
		<# Update the date-created timestamp/datetime on the target media file  #>
		(Get-Item "${EachMediaFile_Fullpath}").CreationTime = ($EachCreation_DateTime);
		<# .CreationTime=("02 June 2020 03:22:03 UTC") #>

	}
}


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
} `
;


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
# EX) REMOVE ASUS' EXISTENT LEFTOVER EXECUTABLES (FROM "C:\Windows\System32")
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
#   stackoverflow.com  |  "How can I delete files with PowerShell without confirmation? - Stack Overflow"  |  https://stackoverflow.com/a/43611773
#
# ------------------------------------------------------------