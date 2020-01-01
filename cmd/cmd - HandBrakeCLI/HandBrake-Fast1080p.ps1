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

$InputDir = ("${ThisDir}\Input\");
$OutputDir = ("${ThisDir}\Output\");
$OutputDir = ("$(Split-Path $MyInvocation.MyCommand.Path -Parent)\${INPUT_DIR}\");

$PRESET_NAME = "Fast 1080p30";
$INPUT_DIR = "Input";
$OUTPUT_DIR = "Output";
$OUTPUT_EXT = "mp4";

# ------------------------------------------------------------
# Compress input video(s) using HandBrakeCLI

Get-ChildItem -Path ("$(Split-Path $MyInvocation.MyCommand.Path -Parent)\${INPUT_DIR}\") -Exclude (".gitignore") | ForEach-Object {
	Show $_;
}

# $EXT = "vob";
# FOR %%I IN ("${INPUT_DIR}\*.${EXT}") DO (
# 	Write-Host "   %%I  --->  ${OUTPUT_DIR}\%%~nI.${OUTPUT_EXT}"
# 	"HandBrakeCLI.exe" --preset "${PRESET_NAME}" -i "%%I" -o "${OUTPUT_DIR}\%%~nI.${OUTPUT_EXT}"
# 	IF EXIST "${OUTPUT_DIR}\%%~nI.${OUTPUT_EXT}" (
# 		DEL /f "%%I"
# 	)
# 	ECHO.
# )

# $EXT = "mpg";
# FOR %%I IN ("${INPUT_DIR}\*.${EXT}") DO (
# 	ECHO|set /p="   %%I  --->  ${OUTPUT_DIR}\%%~nI.${OUTPUT_EXT}"
# 	"HandBrakeCLI.exe" --preset "${PRESET_NAME}" -i "%%I" -o "${OUTPUT_DIR}\%%~nI.${OUTPUT_EXT}"
# 	IF EXIST "${OUTPUT_DIR}\%%~nI.${OUTPUT_EXT}" (
# 		DEL /f "%%I"
# 	)
# 	ECHO.
# )

# $EXT = "mov";
# FOR %%I IN ("${INPUT_DIR}\*.${EXT}") DO (
# 	ECHO|set /p="   %%I  --->  ${OUTPUT_DIR}\%%~nI.${OUTPUT_EXT}"
# 	"HandBrakeCLI.exe" --preset "${PRESET_NAME}" -i "%%I" -o "${OUTPUT_DIR}\%%~nI.${OUTPUT_EXT}"
# 	IF EXIST "${OUTPUT_DIR}\%%~nI.${OUTPUT_EXT}" (
# 		DEL /f "%%I"
# 	)
# 	ECHO.
# )


# ------------------------------------------------------------
# 
# ### Original Script (see Citation(s), below)
# 
# FOR /R H:\Video\ %%F IN (*.mkv) DO (
# 	"C:\Program Files\HandBrake\HandBrakeCLI.exe" --preset "Fast 1080p30" -i "%%~fF" -o "%%~dpF%%~nF_conv.mkv"
# 	IF EXIST "%%~dpF%%~nF_conv.mkv" (
# 		DEL "%%~fF"
# 		REN "%%~dpF%%~nF_conv.mkv" "%%~nxF"
# 	)
# )


# ------------------------------------------------------------
# Once finished, open the output directory

# explorer.exe "${OUTPUT_DIR}";

Start-Sleep -Seconds 30;

EXIT;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Split-Path - Returns the specified part of a path"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/split-path
#
#   reddit.com  |  "A HandBrake script to run through subfolders and convert to a custom preset"  |  https://www.reddit.com/r/PleX/comments/9anvle/a_handbrake_script_to_run_through_subfolders_and/
#
# ------------------------------------------------------------
