# ------------------------------------------------------------
#
# PowerShell - Get Windows ISO version (determine version, build, and release numbers)
#
# ------------------------------------------------------------
If ($False) { # RUN THIS SCRIPT:

$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/PowerShell%20-%20Get%20Windows%20ISO%20version%20%28determine%20version%2c%20build%2c%20and%20release%20numbers%29.ps1') ).Content) } Catch {};

}
# ------------------------------------------------------------

### !!! REQUIRES ADMIN PRIVILEGES !!! ###

If ($True) {

	$ISO_FullPath = "${HOME}\Desktop\Windows.iso";


	$ISO_Fullpath = "${HOME}\Desktop\Windows.iso";

	# Determine if the iso file is already mounted
	$Mounted_DriveLetter = ((Get-DiskImage -ImagePath "${ISO_FullPath}" | Get-Volume).DriveLetter);

	# If iso file is not already mounted, then mount it now
	If ($null -eq (Get-DiskImage -ImagePath "${ISO_FullPath}" | Get-Volume)) {
		Mount-DiskImage -ImagePath ("${ISO_FullPath}") | Out-Null;
		Start-Sleep -Seconds (1);
	}

	# Get the mounted iso file's drive letter
	$Mounted_DriveLetter = ((Get-DiskImage -ImagePath "${ISO_FullPath}" | Get-Volume).DriveLetter); $Mounted_DriveLetter;

	If (([String]::IsNullOrEmpty("${Mounted_DriveLetter}")) -Eq $True) {

		# Error(s) mounting ISO file
		Write-Output "Error:  Unable to mount ISO file `"${ISO_FullPath}`"";

	} Else {

		# ISO file mounted successfully
		Write-Output "Info:  Located ISO file `"${ISO_FullPath}`" mounted to drive letter `"${Mounted_DriveLetter}`"";

		# Get the version # of Windows (stored within the .iso file)
		$Install_Esd_MountPath = ("${Mounted_DriveLetter}:\sources\install.esd");

		$DISM_Info=(Dism /Get-WimInfo /WimFile:${Install_Esd_MountPath} /index:1); $EXIT_CODE=([int]${EXIT_CODE}+([int](!${?})));

		If (${EXIT_CODE} -NE 0) {

			Write-Output "Error: Unable to get info using DISM - Error message:";
			Write-Output "------------------------------";
			${DISM_Info};
			Write-Output "------------------------------";

		} Else {

			$Regex_Win10_Name = "^Name : (.+)";

			$Regex_Win10_VersionNum = "^Version : (.+)";
			# $Regex_Win10_VersionNum = "^Version : ([\d]+\.[\d]+\.[\d]+)\s*$";

			$Regex_Win10_BuildNum = "^ServicePack\s+Build : (.+)";
			# $Regex_Win10_BuildNum = "^ServicePack\s+Build : (\S+)\s*$";

			$ISO_Name = ([Regex]::Match("$(${DISM_Info} -match ${Regex_Win10_Name})","${Regex_Win10_Name}").Captures.Groups[1].Value);
			$ISO_VersionNumber = ([Regex]::Match("$(${DISM_Info} -match ${Regex_Win10_VersionNum})","${Regex_Win10_VersionNum}").Captures.Groups[1].Value);
			$ISO_BuildNumber = ([Regex]::Match("$(${DISM_Info} -match ${Regex_Win10_BuildNum})","${Regex_Win10_BuildNum}").Captures.Groups[1].Value);

			If ($False) {
				Write-Output "Verbose Info - `${DISM_Info}:";
				Write-Output "------------------------------";
				${DISM_Info};
				Write-Output "------------------------------";
				Write-Output "`${ISO_Name} = [ ${ISO_Name} ]";
				Write-Output "`${ISO_VersionNumber} = [ ${ISO_VersionNumber} ]";
				Write-Output "`${ISO_BuildNumber} = [ ${ISO_BuildNumber} ]";
			}

			Write-Output "";
			Write-Output "------------------------------";
			Write-Output "";
			Write-Output "  Filepath:  ${ISO_FullPath}";
			Write-Output "";
			Write-Output "  Image Name:  ${ISO_Name}";
			Write-Output "";
			Write-Output "  Version.Build:  ${ISO_VersionNumber}.${ISO_BuildNumber}";
			Write-Output "";
			Write-Output "------------------------------";

			Write-Output "";

		}

		# Unmount the iso file
		Get-DiskImage -ImagePath "${ISO_FullPath}" | Dismount-DiskImage | Out-Null;

	}

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   answers.microsoft.com  |  "How to identify windows version and OS build of any windows disc image - Microsoft Community"  |  https://answers.microsoft.com/en-us/windows/forum/all/how-to-identify-windows-version-and-os-build-of/f8f8fe67-9554-4e63-a4d3-87f5dd58184e
#
#   docs.microsoft.com  |  "Get-Volume (Storage) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/storage/get-volume
#
#   docs.microsoft.com  |  "Get-DiskImage (Storage) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/storage/get-diskimage
#
#   docs.microsoft.com  |  "Mount-DiskImage (Storage) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/storage/mount-diskimage
#
#   docs.microsoft.com  |  "Dismount-DiskImage (Storage) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/storage/dismount-diskimage
#
# ------------------------------------------------------------