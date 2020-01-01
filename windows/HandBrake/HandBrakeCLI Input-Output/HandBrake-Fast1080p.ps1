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
#
#   . "${Home}\Documents\GitHub\Coding\windows\HandBrake\HandBrakeCLI Input-Output\HandBrake-Fast1080p.ps1"
#
#
# ------------------------------------------------------------
# 
# Instantiate Runtime Variable(s)
#
# HandBrakeCLI.exe

$ThisScript = (Split-Path $MyInvocation.MyCommand.Name -Leaf);
$ThisDir = (Split-Path $MyInvocation.MyCommand.Path -Parent);
$InputDir = ("${ThisDir}\Input");
$OutputDir = ("${ThisDir}\Output");

$HandBrakeCLI = ("${ThisDir}\HandBrakeCLI.exe");

$HandBrake_Preset = "Fast 1080p30";

$OutputExtension = "mp4";

# ------------------------------------------------------------

$ExeArchive_Url="https://download.handbrake.fr/releases/1.3.0/HandBrakeCLI-1.3.0-win-x86_64.zip";

$ExeArchive_Local=("${Env:TEMP}\$(Split-Path ${ExeArchive_Url} -Leaf)");

$ExeArchive_Unpacked=("${Env:TEMP}\$([IO.Path]::GetFileNameWithoutExtension(${ExeArchive_Local}))");

# Download HandBrakeCLI
Write-Host "";
Write-Host "Downloading  [ ${ExeArchive_Url} ]  to  [ ${ExeArchive_Local} ]  ...";
$(New-Object Net.WebClient).DownloadFile("${ExeArchive_Url}", "${ExeArchive_Local}");

# Unpack the downloaded archive
Write-Host "";
Write-Host "Unpacking  [ ${ExeArchive_Local} ]  into  [ ${ExeArchive_Unpacked} ]  ...";
Expand-Archive -LiteralPath ("${ExeArchive_Local}") -DestinationPath ("${ExeArchive_Unpacked}") -Force;

# Cleanup the archive once it has been unpacked
# Remove-Item -Path ("${Env:TEMP}\esxi-create-bootmedia.ps1");

$ExeArchive_HandBrakeCLI = (Get-ChildItem -Path ("${ExeArchive_Unpacked}") -Depth (0) -File | Where-Object { $_.Name -Like "*HandBrakeCLI*.exe" } | Select-Object -First (1) -ExpandProperty ("FullName"));


If ((Test-Path -Path ("${ExeArchive_HandBrakeCLI}")) -Ne $True) {
	Write-Host "";
	Write-Host "HandBrakeCLI executable path NOT FOUND" -ForegroundColor ("Red");
	Write-Host "";
	Exit 1;


} Else {
	Write-Host ""
	Write-Host "Moving downloaded/extracted executable from  [ ${ExeArchive_HandBrakeCLI} ]  to  [ ${HandBrakeCLI} ]"
	
	Move-Item -Path ("${ExeArchive_HandBrakeCLI}") -Destination ("${HandBrakeCLI}") -Force;

	# Compress videos from the input directory into the output directory
	Set-Location -Path ("${ThisDir}\");
	Get-ChildItem -Path ("${InputDir}\") -Exclude (".gitignore") | ForEach-Object {
		$EachInputFile = $_.FullName;
		$EachOutputFile = "${OutputDir}\$($_.BaseName).${OutputExtension}";
		Write-Host "";
		Write-Host "`$EachInputFile = [ ${EachInputFile} ]";
		Write-Host "`$EachOutputFile = [ ${EachOutputFile} ]";
		$EachConversion = (Start-Process -Wait -FilePath "${HandBrakeCLI}" -ArgumentList "--preset `"${HandBrake_Preset}`" -i `"${EachInputFile}`" -o `"${EachOutputFile}`""); $EachExitCode=$?;
		If ((Test-Path -Path ("${EachOutputFile}")) -Eq $True) {
			Remove-Item -Path ("${EachInputFile}") -Force;
		}
		Write-Host "";
	}

	# Open the exported-files directory
	Write-Host "";
	Write-Host "Finished Script - Opening output directory @  [ ${OutputDir} ]";
	Explorer.exe "${OutputDir}";

	# Wait a few seconds (for user to read the terminal, etc.) before exiting
	# Start-Sleep -Seconds 60;

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
