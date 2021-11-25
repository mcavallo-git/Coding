# ------------------------------------------------------------
#
#  PowerShell - Expand-Archive (unpack-extract files from .zip archives)
#


# General Syntax
Expand-Archive -LiteralPath ("C:\Archives\Draft[v1].Zip") -DestinationPath ("C:\Reference");


# ------------------------------------------------------------
#
# Example
#  |-->  Download a zip archive & unpack it  (note: uses [System.IO.Compression.ZipFile] class instead of Expand-Archive cmdlet)
#

If ($True) {

	# Setup Runtime vars for remote URI(s) && local filepath(s)
	$URL_AgentZip="https://github.com/mcavallo-git/Coding/raw/master/windows/7-Zip/7z-Standalone.zip";
	$FullPath_7z_Dir = "${env:TEMP}\7-Zip-Standalone";
	$FullPath_7z_Exe = "${FullPath_7z_Dir}\7za.exe";
	$FullPath_7z_Zip="${FullPath_7z_Dir}\$(Split-Path -Path ("${URL_AgentZip}") -Leaf;)";

	# Ensure the working directory exists
	If ((Test-Path "${FullPath_7z_Dir}") -NE $True) {
	New-Item -ItemType ("Directory") -Path ("${FullPath_7z_Dir}") | Out-Null;
	}

	# Ensure the executable exists
	If ((Test-Path "${FullPath_7z_Exe}") -NE $True) {

		# Hide Invoke-WebRequest's progress bar
		$ProgressPreference="SilentlyContinue";

		# Download the executable contained in a zip archive
		[System.Net.ServicePointManager]::SecurityProtocol=([System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12);
		Invoke-WebRequest -UseBasicParsing -Uri ("${URL_AgentZip}") -OutFile ("${FullPath_7z_Zip}") -TimeoutSec (60);

		# Extract the zip archive's contents to the working directory
		Add-Type -AssemblyName ("System.IO.Compression.FileSystem");
		[System.IO.Compression.ZipFile]::ExtractToDirectory(("${FullPath_7z_Zip}"),("${FullPath_7z_Dir}"));

		# Delete the zip archive (send it to the Recycle Bin) once its been unpacked
		Add-Type -AssemblyName ("Microsoft.VisualBasic");
		[Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile("${FullPath_7z_Zip}",'OnlyErrorDialogs','SendToRecycleBin');

	}

	# Open the working directory
	explorer.exe "${FullPath_7z_Dir}";

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Expand-Archive"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.archive/expand-archive?view=powershell-7
#
# ------------------------------------------------------------