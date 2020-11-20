# ------------------------------------------------------------
#
# Determine the version number of a given Windows ".iso" image-file
#
# ------------------------------------------------------------
If ($False) {

. "${Home}\Documents\GitHub\Coding\powershell\PowerShell - Determine Windows ISO's version number.ps1";

}
# ------------------------------------------------------------

If ($True) {

	$ISO_Fullpath = "${Home}\Desktop\Windows.iso";
	$MountDir = "${Home}\Desktop\Mount";
	$Possible_DriveLetters = @("E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z");
	ForEach ($EachDriveLetter In (${Possible_DriveLetters})) {
		If ((Test-Path -Path ("${EachDriveLetter}:\")) -Eq $False) {
			Set-Variable -Name "DriveLetter" -Scope "Script" -Value "${EachDriveLetter}";
			Break;
		};
	};

	$Mounted_ISO = Mount-DiskImage -ImagePath ("${ISO_Fullpath}");

	If ((Test-Path ("${MountDir}")) -Eq $False) {
	New-Item -ItemType ("Directory") -Path ("${MountDir}") | Out-Null;
	Start-Sleep -Seconds (1);
	};


	<# Get the version # of Windows (stored within the .iso file) #>
	$Install_Esd_MountPath = ( "${DriveLetter}:\sources\install.esd" );
	$Install_Esd_Desktop = ( "${Home}\Desktop\install.esd" );

	$DISM_Info = (DISM /Get-WimInfo /WimFile:${Install_Esd_MountPath} /index:0);

	$Regex_Win10_VersionNum = "Version\s*:\s*[\d]+\.[\d]+\.[\d]+\.[\d]+\s*";
	$ISO_VersionNumber = ((((${DISM_Info} -match ${Regex_Win10_VersionNum}) -Replace "Version","") -Replace ":","") -Replace " ","");
	Write-Host "";
	Write-Host "Version Number (Windows ISO):";
	Write-Host "";
	Write-Host "${ISO_VersionNumber}";
	Write-Host "";

	${Mounted_ISO} | Dismount-DiskImage | Out-Null;

	<# Copy-Item ("${Install_Esd_MountPath}") ("${Install_Esd_Desktop}") -Force; #>
	<# Copy-Item ("${DriveLetter}:\*") ("${MountDir}\") -Recurse -Force; #>
	<# $Install_Wim = "${MountDir}\sources\install.wim"; #>
	<# $Install_Esd = "${MountDir}\sources\install.esd"; #>

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   answers.microsoft.com  |  "How to identify windows version and OS build of any windows disc image - Microsoft Community"  |  https://answers.microsoft.com/en-us/windows/forum/all/how-to-identify-windows-version-and-os-build-of/f8f8fe67-9554-4e63-a4d3-87f5dd58184e
#
# ------------------------------------------------------------