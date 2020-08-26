# @ECHO OFF
# ------------------------------------------------------------
# !!! Prerequisite !!!
# 	HandBrakeCLI must be installed for this script to function as-intended
# 	Download [ HandBrakeCLI ] Application from URL [ https://handbrake.fr/downloads2.php ]
# 	Extract [ HandBrakeCLI.exe ] from aforementioned URL (downloads as a .zip archive as-of 20191222-070342 CST)
# 	Place the extracted file at filepath [ C:\Program Files\HandBrake\HandBrakeCLI.exe ]
# ------------------------------------------------------------
# RUN THIS SCRIPT:
#
If ($False) {

. "${Home}\Documents\GitHub\Coding\windows\HandBrake\HandBrakeCLI-InputOutput\HandBrake-Fast1080p.ps1"


PowerShell -Command "Start-Process -Filepath ('C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe') -ArgumentList ('-File ${Home}\Documents\GitHub\Coding\windows\HandBrake\HandBrakeCLI-InputOutput\HandBrake-Fast1080p.ps1') -Verb 'RunAs' -Wait -PassThru | Out-Null;"


}

#
#
#
# ------------------------------------------------------------
#
# Instantiate Runtime Variable(s)
#

$ThisScript = (Split-Path $MyInvocation.MyCommand.Name -Leaf);

$ThisDir = (Split-Path $MyInvocation.MyCommand.Path -Parent);

$InputDir = ("${ThisDir}\Input");

$OutputDir = ("${ThisDir}\Output");

$HandBrakeCLI = ("${ThisDir}\HandBrakeCLI.exe");

$HandBrake_Preset = "Very Fast 1080p30";

$OutputExtension = "mp4";

$Framerate_MatchSource = $True;
# $Framerate_MatchSource = $False;

$AspectRatio_MatchSource = $True;
# $AspectRatio_MatchSource = $False;

$Timestamps_IncludeDecimalSeconds = $False;
# $Timestamps_IncludeDecimalSeconds = $True;

$DoEncoding_InSameWindow = $True;
# $DoEncoding_InSameWindow = $False;

# Write-Output "`n`$ThisScript = [ ${ThisScript} ]";
# Write-Output "`n`$ThisDir = [ ${ThisDir} ]";
# Write-Output "`n`$InputDir = [ ${InputDir} ]";
# Write-Output "`n`$OutputDir = [ ${OutputDir} ]";
# Write-Output "`n`$HandBrakeCLI = [ ${HandBrakeCLI} ]";


# ------------------------------------------------------------
#
# Dynamic Settings (based on runtime variable(s), above
#

$ExtraOptions = "";
If ($Framerate_MatchSource -Eq $True) {
	$ExtraOptions = "--vfr ${ExtraOptions}";
}
If ($AspectRatio_MatchSource -Eq $True) {
	$ExtraOptions = "--non-anamorphic ${ExtraOptions}";
}

# ------------------------------------------------------------

# Download Handbrake runtime executable (if it doesn't exist)
If ((Test-Path -Path ("${HandBrakeCLI}")) -Eq $False) {
	$ExeArchive_Url="https://download.handbrake.fr/releases/1.3.0/HandBrakeCLI-1.3.0-win-x86_64.zip";
	$ExeArchive_Local=("${Env:TEMP}\$(Split-Path ${ExeArchive_Url} -Leaf)");
	$ExeArchive_Unpacked=("${Env:TEMP}\$([IO.Path]::GetFileNameWithoutExtension(${ExeArchive_Local}))");
	# Download HandBrakeCLI
	Write-Output "`nFile not found:  [ ${HandBrakeCLI} ]";
	Write-Output "`nDownloading archive-version of HandBrakeCLI from  [ ${ExeArchive_Url} ]  to  [ ${ExeArchive_Local} ]...";
	$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; $(New-Object Net.WebClient).DownloadFile("${ExeArchive_Url}", "${ExeArchive_Local}"); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
	# Unpack the downloaded archive
	Write-Output "`nUnpacking  [ ${ExeArchive_Local} ]  into  [ ${ExeArchive_Unpacked} ]  ...";
	Expand-Archive -LiteralPath ("${ExeArchive_Local}") -DestinationPath ("${ExeArchive_Unpacked}") -Force;
	# Clean-up the archive once it has been unpacked
	$ExeArchive_HandBrakeCLI = (Get-ChildItem -Path ("${ExeArchive_Unpacked}") -Depth (0) -File | Where-Object { $_.Name -Like "*HandBrakeCLI*.exe" } | Select-Object -First (1) -ExpandProperty ("FullName"));
	If ((Test-Path -Path ("${ExeArchive_HandBrakeCLI}")) -Ne $True) {
		Write-Output "`n`n  Error:  FILE NOT FOUND (HandBrakeCLI executable) at path `"${ExeArchive_HandBrakeCLI}`"`n`n";
		If ($True) {
			# Wait 60 seconds before proceeding
			Start-Sleep 60;
		} Else {
			# "Press any key to close this window..."
			Write-Output -NoNewLine "`n`n  Press any key to close this window...`n`n";
			$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
		}
		Exit 1;
	} Else {
		Write-Output "`nMoving downloaded/extracted executable from  [ ${ExeArchive_HandBrakeCLI} ]  to  [ ${HandBrakeCLI} ]"
		Move-Item -Path ("${ExeArchive_HandBrakeCLI}") -Destination ("${HandBrakeCLI}") -Force;
	}
}


# ------------------------------------------------------------

# Ensure that Handbrake runtime executable exists
If ((Test-Path -Path ("${HandBrakeCLI}")) -Eq $True) {
	
	# Determine which files are video-files from within the input-directory (by using ActiveX Objects)

	$Directory_ToSearch = "${InputDir}";
	$Filetype_ToDetect = "video";
	$ActiveXDataObject_Connection = (New-Object -com ADODB.Connection);
	$ActiveXDataObject_RecordSet = (New-Object -com ADODB.Recordset);
	${ActiveXDataObject_Connection}.Open("Provider=Search.CollatorDSO;Extended Properties='Application=Windows';");
	${ActiveXDataObject_RecordSet}.Open("SELECT System.ItemPathDisplay FROM SYSTEMINDEX WHERE System.Kind = '${Filetype_ToDetect}' AND System.ItemPathDisplay LIKE '${Directory_ToSearch}\%'", ${ActiveXDataObject_Connection});
	If (${ActiveXDataObject_RecordSet}.EOF -Eq $False) {
		${ActiveXDataObject_RecordSet}.MoveFirst();
	}
	<# Walk through the input directory's contained video files, one-by-one #>

	# Set-Location -Path ("${ThisDir}\");
	# Get-ChildItem -Path ("${InputDir}\") -Exclude (".gitignore") | ForEach-Object {
	# 	$EachInput_BasenameNoExt = "$($_.BaseName)";
	# 	$EachInput_FullName = "$($_.FullName)";

	While (${ActiveXDataObject_RecordSet}.EOF -NE $True) {
		$EachInput_FullName = (${ActiveXDataObject_RecordSet}.Fields.Item("System.ItemPathDisplay").Value);
		$EachInput_BasenameNoExt = ((Get-Item -Path ("${EachInput_FullName}")).Basename);

		Write-Output "------------------------------------------------------------";
		Write-Output "";
		Write-Output "`$EachInput_FullName = [ ${EachInput_FullName} ]";
		Write-Output "`$EachInput_BasenameNoExt = [ ${EachInput_BasenameNoExt} ]";
		Write-Output "";
		<# Determine unique output-filenames by timestamping the end of the output files' basenames (before extension) #>
		$FirstLoop_DoQuickNaming = $True;
		Do {
			$EpochDate = ([Decimal](Get-Date -UFormat ("%s")));
			$EpochToDateTime = (New-Object -Type DateTime -ArgumentList 1970, 1, 1, 0, 0, 0, 0).AddSeconds([Math]::Floor($EpochDate));
			$TimestampShort = ([String](Get-Date -Date ("${EpochToDateTime}") -UFormat ("%Y%m%d-%H%M%S")));
			$DecimalTimestampShort = ( ([String](Get-Date -Date ("${EpochToDateTime}") -UFormat ("%Y%m%d-%H%M%S"))) + (([String]((${EpochDate}%1))).Substring(1).PadRight(6,"0")) );
			If (${FirstLoop_DoQuickNaming} -Eq $True) {
				$EachOutput_BasenameNoExt = "${EachInput_BasenameNoExt}.comp";
			} Else {
				If ($Timestamps_IncludeDecimalSeconds -Eq $True) {
					$EachOutput_BasenameNoExt = "${EachInput_BasenameNoExt}.comp.${DecimalTimestampShort}";
				} Else {
					$EachOutput_BasenameNoExt = "${EachInput_BasenameNoExt}.comp.${TimestampShort}";
				}
			}
			$EachOutput_FullName = "${OutputDir}\${EachOutput_BasenameNoExt}.${OutputExtension}";
			$FirstLoop_DoQuickNaming = $False;
			Write-Output "Verifying `$EachOutput_FullName = [ ${EachOutput_FullName} ]...";
		} While ((Test-Path "${EachOutput_FullName}") -Eq ($True));
		Write-Output "Verified. Using `$EachOutput_FullName = [ ${EachOutput_FullName} ]...";
		Write-Output "";

		# ----------------------------------------------- #
		#                                                 #
		#   ! ! !   Perform the actual encoding   ! ! !   #
		#                                                 #
		If (${DoEncoding_InSameWindow} -Eq $False) {
			$EachConversion = (Start-Process -Filepath ("${HandBrakeCLI}") -ArgumentList ("--preset `"${HandBrake_Preset}`" ${ExtraOptions}-i `"${EachInput_FullName}`" -o `"${EachOutput_FullName}`"")  -Wait); $EachExitCode=$?;
		} Else {
			$EachConversion = (Start-Process -Filepath ("${HandBrakeCLI}") -ArgumentList ("--preset `"${HandBrake_Preset}`" ${ExtraOptions}-i `"${EachInput_FullName}`" -o `"${EachOutput_FullName}`"") -NoNewWindow  -Wait -PassThru); $EachExitCode=$?;
		}
		If ((Test-Path -Path ("${EachOutput_FullName}")) -Eq $True) {
			Write-Output "`n`n";
			Write-Output "Info:  Output file exists with path:   `"${EachOutput_FullName}`"";
			Write-Output " |-->  Removing input file from path:  `"${EachInput_FullName}`"";
			Remove-Item -Path ("${EachInput_FullName}") -Force;
		}
		Write-Output "";
		Write-Output "`$EachInput_FullName = [${EachInput_FullName}]";
		Write-Output "";
		Write-Output "`$EachConversion = [${EachConversion}]";
		Write-Output "";
		Write-Output "`$EachExitCode = [${EachExitCode}]";
		Write-Output "";
		Start-Sleep -Seconds (10);
		Write-Output "";

		${ActiveXDataObject_RecordSet}.MoveNext(); <# Iterate onto the next ActiveX Input Item (Input Video File, if another exists) #>
	}

	# Open the exported-files directory
	Write-Output "`nFinished Script - Opening output directory @  [ ${OutputDir} ]`n";

	Explorer.exe "${OutputDir}";

	# Wait a few seconds (for user to read the terminal, etc.) before exiting
	Start-Sleep -Seconds 10;

	Exit 0;

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Expand-Archive - Extracts files from a specified archive (zipped) file"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.archive/expand-archive?view=powershell-6
#
#   docs.microsoft.com  |  "Get-ChildItem - Gets the items and child items in one or more specified locations"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem
#
#   docs.microsoft.com  |  "Move-Item - Moves an item from one location to another"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/move-item
#
#   docs.microsoft.com  |  "Split-Path - Returns the specified part of a path"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/split-path
#
#   handbrake.fr  |  "Command line reference"  |  https://handbrake.fr/docs/en/latest/cli/command-line-reference.html
#
#   reddit.com  |  "A HandBrake script to run through subfolders and convert to a custom preset"  |  https://www.reddit.com/r/PleX/comments/9anvle/a_handbrake_script_to_run_through_subfolders_and/
#
# ------------------------------------------------------------
