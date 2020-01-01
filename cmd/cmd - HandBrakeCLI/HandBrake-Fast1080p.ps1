# @ECHO OFF
# ------------------------------------------------------------
# !!! Prerequisite !!!
# 	HandBrakeCLI must be installed for this script to function as-intended
# 	Download [ HandBrakeCLI ] Application from URL [ https://handbrake.fr/downloads2.php ]
# 	Extract [ HandBrakeCLI.exe ] from aforementioned URL (downloads as a .zip archive as-of 20191222-070342 CST)
# 	Place the extracted file at filepath [ C:\Program Files\HandBrake\HandBrakeCLI.exe ]
# ------------------------------------------------------------
# 
# Instantiate Runtime Variable(s)
#
# HandBrakeCLI.exe

$ThisDir = (Split-Path $MyInvocation.MyCommand.Path -Parent);
$ThisScript = (Split-Path $MyInvocation.MyCommand.Name -Leaf);

Set-Location -Path ("${ThisDir}\");

$InputDir = ("${ThisDir}\Input");
$OutputDir = ("${ThisDir}\Output");
$HandBrakeCLI = ("${ThisDir}\HandBrakeCLI.exe");

$HandBrake_Preset = "Fast 1080p30";
$OutputExtension = "mp4";

# ------------------------------------------------------------
# Compress input video(s) using HandBrakeCLI

Get-ChildItem -Path ("${InputDir}\") -Exclude (".gitignore") | ForEach-Object {
	$EachInputFile = $_.FullName;
	$EachOutputFile = "${OutputDir}\$($_.BaseName).${OutputExtension}";
	Write-Host "";
	Write-Host "`$HandBrakeCLI = [ ${HandBrakeCLI} ]";
	Write-Host "`$EachInputFile = [ ${EachInputFile} ]";
	Write-Host "`$EachOutputFile = [ ${EachOutputFile} ]";
	# $EachConversion = (Start-Process "${HandBrakeCLI}" -ArgumentList "--preset `"${HandBrake_Preset}`" -i `"${EachInputFile}`" -o `"${EachOutputFile}`""); $EachExitCode=$?;
	$EachConversion = ("${HandBrakeCLI}" --preset "${HandBrake_Preset}" -i "${EachInputFile}" -o "${EachOutputFile}"); $EachExitCode=$?;
	Write-Host "`$EachConversion = [ ${EachConversion} ]";
	Write-Host "`$EachExitCode = [ ${EachExitCode} ]";
	Write-Host "";
}

# ------------------------------------------------------------
# Once finished, open the output directory

# explorer.exe "${OutputDir}";

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
