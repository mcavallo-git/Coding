# ------------------------------------------------------------
#
#  PowerShell - Expand-Archive (unpack-extract files from .zip archives)
#


# General Syntax
Expand-Archive -LiteralPath 'C:\Archives\Draft[v1].Zip' -DestinationPath C:\Reference


# ------------------------------------------------------------
#
# Example
#  |-->  Download a zip archive & unpack it  (note: uses [System.IO.Compression.ZipFile] class instead of Expand-Archive cmdlet)
#

If ($True) {

# Setup Runtime vars for remote URI(s) && local filepath(s)
$URL_AgentZip="https://github.com/mcavallo-git/Coding/raw/master/windows/7-Zip/7z-Standalone.zip";
$FullPath_WorkingDir = "${env:TEMP}\7-Zip-Standalone";
$FullPath_AgentZip="${FullPath_WorkingDir}\$(Split-Path -Path ("${URL_AgentZip}") -Leaf;)";

# Ensure the working directory exists
New-Item -ItemType 'Directory' -Path ("${FullPath_WorkingDir}") | Out-Null;
Set-Location -Path ("${FullPath_WorkingDir}");

# Hide Invoke-WebRequest's progress bar
$ProgressPreference='SilentlyContinue';

# Download the pipeline agent's zip archive
[System.Net.ServicePointManager]::SecurityProtocol=([System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12);
Measure-Command { Invoke-WebRequest -UseBasicParsing -Uri ("${URL_AgentZip}") -OutFile ("${FullPath_AgentZip}") -TimeoutSec (60) };

# Extract the zip archive
Add-Type -AssemblyName ('System.IO.Compression.FileSystem');
[System.IO.Compression.ZipFile]::ExtractToDirectory(("${FullPath_AgentZip}"),("${FullPath_WorkingDir}"));

# Open the working directory
explorer.exe "${FullPath_WorkingDir}";

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Expand-Archive"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.archive/expand-archive?view=powershell-7
#
# ------------------------------------------------------------