# ------------------------------------------------------------
#
# GOOGLE PHOTOS EXPORTS --> UPDATE MEDIA'S DATE-CREATED TIMESTAMP/DATETIME ON MEDIA FILES BASED OFF OF THEIR ASSOCIATED METADATA (JSON) FILES' CONTENTS
#

If ($True) {

	# Download and use "Json-Decoder" instead of using less-powerful (but native) "ConvertFrom-Json"
	Set-ExecutionPolicy -ExecutionPolicy "Bypass" -Scope "CurrentUser" -Force; New-Item -Force -ItemType "File" -Path ("${Env:TEMP}\JsonDecoder.psm1") -Value (($(New-Object Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/JsonDecoder/JsonDecoder.psm1"))) | Out-Null; Import-Module -Force ("${Env:TEMP}\JsonDecoder.psm1");

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
			Copy-Item -Path ("${EachMediaFile_CurrentFullpath}") -Destination ("${EachMediaFile_FinalFullpath}");
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