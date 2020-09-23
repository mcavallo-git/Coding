# ------------------------------------------------------------
#
# GOOGLE PHOTOS EXPORTS --> UPDATE MEDIA'S DATE-CREATED TIMESTAMP/DATETIME ON MEDIA FILES BASED OFF OF THEIR ASSOCIATED METADATA (JSON) FILES' CONTENTS
#

If ($True) {

	<# Download and use "Json-Decoder" instead of using less-powerful (but native) "ConvertFrom-Json" #>
	Set-ExecutionPolicy -ExecutionPolicy "Bypass" -Scope "CurrentUser" -Force; New-Item -Force -ItemType "File" -Path ("${Env:TEMP}\JsonDecoder.psm1") -Value (($(New-Object Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/JsonDecoder/JsonDecoder.psm1"))) | Out-Null; Import-Module -Force ("${Env:TEMP}\JsonDecoder.psm1");
	
	<# Required to use Recycle Bin action 'SendToRecycleBin' #>
	Add-Type -AssemblyName Microsoft.VisualBasic;

	<# Prep all non-matching metadata files to match their associated media-files' basenames #>
	ForEach ($EachExt In @('GIF','HEIC','JPG','MOV','MP4','PNG')) {
		For ($i = 0; $i -LT 10; $i++) {
			Get-ChildItem "./*/*.${EachExt}(${i}).json" | ForEach-Object {
				$Each_FullName = "$($_.FullName)";
				$Each_NewFullName = (("${Each_FullName}").Replace(".${EachExt}(${i}).json","(${i}).${EachExt}.json"));
				Rename-Item -Path ("${Each_FullName}") -NewName ("${Each_NewFullName}");
			}
		}
	}

	<# Remove Excess "metadata.json" files #>
	$Parent_Directory = ".";
	$Filenames_To_Remove = @();
	$Filenames_To_Remove += ("metadata.json");
	Get-ChildItem -Path ("${Parent_Directory}") -File -Recurse -Depth (1) -Force -ErrorAction "SilentlyContinue" `
	| Where-Object { (${Filenames_To_Remove}) -Contains ("$($_.Name)"); } `
	| ForEach-Object { `
		$Each_Fullpath = ("$($_.FullName)");
		Write-Host "Removing file with path  `"${Each_Fullpath}`"  ..."; `
		[Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile("${Each_Fullpath}",'OnlyErrorDialogs','SendToRecycleBin');
	}

	<# Locate all json metadata files #>
	(Get-Item ".\*\*.json") | ForEach-Object {
		$EachMetadata_Fullpath = ($_.FullName);
		$EachMetadata_BaseName= ($_.BaseName);
		$EachMetadata_DirectoryName = ($_.DirectoryName);
		$EachMetaData_GrandDirname = (Split-Path -Path ("${EachMetadata_DirectoryName}") -Parent);
		$EachMediaFile_CurrentFullpath = "${EachMetadata_DirectoryName}\${EachMetadata_BaseName}";
		$EachMediaFile_FinalFullpath = "${EachMetaData_GrandDirname}\${EachMetadata_BaseName}";
		<# Ensure associated media-file exists #>
		If (Test-Path "${EachMediaFile_CurrentFullpath}") {
			<# Get the date-created timestamp/datetime from the json-file #>
			$EachMetadata_Contents = [IO.File]::ReadAllText("${EachMetadata_Fullpath}");
			$EachMetadata_Object = JsonDecoder -InputObject (${EachMetadata_Contents});
			$EachCreation_EpochSeconds = $EachMetadata_Object.photoTakenTime.timestamp;
			$EachCreation_DateTime = (New-Object -Type DateTime -ArgumentList 1970, 1, 1, 0, 0, 0, 0).AddSeconds([Math]::Floor($EachCreation_EpochSeconds));
			<# Update the date-created timestamp/datetime on the target media file  #>
			(Get-Item "${EachMediaFile_CurrentFullpath}").CreationTime = ($EachCreation_DateTime);
			<# Copy files to the conjoined folder #>
			Copy-Item -Path ("${EachMediaFile_CurrentFullpath}") -Destination ("${EachMediaFile_FinalFullpath}") -Force;
			<# Delete old file(s) to the Recycle Bin #>
			Write-Host "Removing file with path  `"${EachMetadata_Fullpath}`"  ..."; `
			[Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile("${EachMetadata_Fullpath}",'OnlyErrorDialogs','SendToRecycleBin');
			Write-Host "Removing file with path  `"${EachMediaFile_CurrentFullpath}`"  ..."; `
			[Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile("${EachMediaFile_CurrentFullpath}",'OnlyErrorDialogs','SendToRecycleBin');
		}
	}

	<# Update remaining files which dont have related metadata #>
	ForEach ($EachExt In @('GIF','HEIC','JPG','MOV','MP4','PNG')) {
		(Get-Item ".\*\*.${EachExt}") | ForEach-Object {
			$EachMediaFile_CurrentFullpath = ($_.FullName);
			$EachMediaFile_Name= ($_.Name);
			$EachMediaFile_DirectoryName = ($_.DirectoryName);
			$EachMediaFile_Directory_Basename = (Split-Path -Path ("${EachMediaFile_DirectoryName}") -Leaf);
			<# Parse the date off-of directory date-names ending with "... #2", "... #3", etc. #>
			For ($i = 100; $i -GT 0; $i--) {
				$EachMediaFile_Directory_Basename = (("${EachMediaFile_Directory_Basename}").Replace(" #${i}",""));
			}
			$EachMediaFile_GrandDirname = (Split-Path -Path ("${EachMediaFile_DirectoryName}") -Parent);
			$EachMediaFile_FinalFullpath = "${EachMediaFile_GrandDirname}\${EachMediaFile_Name}";
			<# Update the date-created timestamp/datetime on the target media file  #>
			$EachCreation_EpochSeconds = (Get-Date -Date ("${EachMediaFile_Directory_Basename}") -UFormat ("%s"));
			$EachCreation_Date = (New-Object -Type DateTime -ArgumentList 1970, 1, 1, 0, 0, 0, 0).AddSeconds([Math]::Floor($EachCreation_EpochSeconds));
			(Get-Item "${EachMediaFile_CurrentFullpath}").CreationTime = ($EachCreation_Date);
			<# Copy files to the conjoined folder #>
			Copy-Item -Path ("${EachMediaFile_CurrentFullpath}") -Destination ("${EachMediaFile_FinalFullpath}") -Force;
			<# Delete old file(s) to recycle bin #>
			Write-Host "Removing file with path  `"${EachMediaFile_CurrentFullpath}`"  ..."; `
			[Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile("${EachMediaFile_CurrentFullpath}",'OnlyErrorDialogs','SendToRecycleBin');
		}
	}

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   See "PowerShell - Copy-Item, Get-ChildItem. Get-Item, Remove-Item.ps1" (in same directory in repository)
#
# ------------------------------------------------------------