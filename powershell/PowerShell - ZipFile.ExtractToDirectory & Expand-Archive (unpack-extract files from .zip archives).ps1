# ------------------------------------------------------------
#
# PowerShell  -  ZipFile.ExtractToDirectory  (unpack/extract files from .zip archives)
#

#
# General Syntax  -  ZipFile.ExtractToDirectory
#
Add-Type -AssemblyName ("System.IO.Compression.FileSystem");
[System.IO.Compression.ZipFile]::ExtractToDirectory(("C:\Archive.zip"),("C:\ArchiveContents"));


#
# Example  -  ZipFile.ExtractToDirectory
#  |
#  |--> Download a zip archive & unpack it  (note: uses [System.IO.Compression.ZipFile] class instead of Expand-Archive cmdlet)
#
If ($True) {

	# 7-Zip - Set runtime vars for remote URI(s) && local filepath(s)
	$URL_AgentZip="https://github.com/mcavallo-git/Coding/raw/master/windows/7-Zip/7za.exe.zip";
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

	# Run the downloaded/unpacked executable
	Start-Process -Filepath ("${FullPath_7z_Exe}") -ArgumentList (@("--help")) -NoNewWindow -Wait -PassThru -ErrorAction ("SilentlyContinue") | Out-Null;

	# Handbrake - Set runtime vars for remote URI(s) && local filepath(s)
	$URL_AgentZip="https://github.com/mcavallo-git/Coding/raw/master/windows/7-Zip/HandBrakeCLI_Input-Output.7z";
	$FullPath_7z_Dir = "${env:TEMP}\7-Zip-Standalone";
	$FullPath_7z_Exe = "${FullPath_7z_Dir}\7za.exe";
	$FullPath_7z_Zip="${FullPath_7z_Dir}\$(Split-Path -Path ("${URL_AgentZip}") -Leaf;)";


FILEPATH_ARCHIVE_7Z="${HOME}/var-www-html-20191101_183748.7z";
DIR_TO_EXTRACT_INTO="$(basename ${FILEPATH_ARCHIVE_7Z})_unpacked";
mkdir -p "${DIR_TO_EXTRACT_INTO}";
7z x "${FILEPATH_ARCHIVE_7Z}" -o${DIR_TO_EXTRACT_INTO};


}


# ------------------------------------------------------------
#
#  PowerShell  -  Expand-Archive  (unpack/extract files from .zip archives)
#

#
# General Syntax  -  Expand-Archive
#
Expand-Archive -LiteralPath ("C:\Archive.zip") -DestinationPath ("C:\ArchiveContents");


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Expand-Archive"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.archive/expand-archive?view=powershell-7
#
#   docs.microsoft.com  |  "Start-Process - Starts one or more processes on the local computer"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process
#
#   docs.microsoft.com  |  "ZipFile Class (System.IO.Compression) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.io.compression.zipfile
#
#   docs.microsoft.com  |  "ZipFile.ExtractToDirectory Method (System.IO.Compression) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.io.compression.zipfile.extracttodirectory
#
# ------------------------------------------------------------