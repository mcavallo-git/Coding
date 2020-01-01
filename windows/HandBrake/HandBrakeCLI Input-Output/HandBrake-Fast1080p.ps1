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
# Download HandBrakeCLI
#

$ExeArchive_Url="https://handbrake.fr/rotation.php?file=HandBrakeCLI-1.3.0-win-x86_64.zip";

$ExeArchive_Local=("${Env:TEMP}\HandBrakeCLI.zip");

$ExeArchive_Unpacked=("${Env:TEMP}\HandBrakeCLI");

# Download HandBrakeCLI
New-Item -Path ("${ExeArchive_Local}") -Value (($(New-Object Net.WebClient).DownloadString("${ExeArchive_Url}"))) -Force | Out-Null;

# Unpack the download
Expand-Archive -LiteralPath ("${ExeArchive_Local}") -DestinationPath ("${ExeArchive_Unpacked}");
# Remove-Item -Path ("${Env:TEMP}\esxi-create-bootmedia.ps1");

Exit

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

Set-Location -Path ("${ThisDir}\");

$HandBrake_Preset = "Fast 1080p30";

$OutputExtension = "mp4";

# ------------------------------------------------------------
# Compress input video(s) using HandBrakeCLI

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

# ------------------------------------------------------------
# Once finished, open the output directory

Explorer.exe "${OutputDir}";

Start-Sleep -Seconds 30;

EXIT;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Split-Path - Returns the specified part of a path"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/split-path
#
#   handbrake.fr  |  "Command line reference"  |  https://handbrake.fr/docs/en/latest/cli/command-line-reference.html
#
#   reddit.com  |  "A HandBrake script to run through subfolders and convert to a custom preset"  |  https://www.reddit.com/r/PleX/comments/9anvle/a_handbrake_script_to_run_through_subfolders_and/
#
# ------------------------------------------------------------
