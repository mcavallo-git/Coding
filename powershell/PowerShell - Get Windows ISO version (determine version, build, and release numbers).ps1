# ------------------------------------------------------------
#
# PowerShell - Get Windows ISO version (determine version, build, and release numbers)
#
# ------------------------------------------------------------
If ($False) { # RUN THIS SCRIPT:

$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/PowerShell%20-%20Determine%20Windows%20ISO%27s%20version%2C%20build%2C%20and%20release%20numbers.ps1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'Show' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\Show\Show.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;

}
# ------------------------------------------------------------

### !!! REQUIRES ADMIN PRIVILEGES !!! ###

If ($True) {

	$ISO_FullPath = "${HOME}\Desktop\Windows.iso";


	$ISO_Fullpath = "${HOME}\Desktop\Windows.iso";

	# Determine if the iso file is already mounted
	$Mounted_DriveLetter = ((Get-DiskImage -ImagePath "${ISO_FullPath}" | Get-Volume).DriveLetter);

	# If iso file is not already mounted, then mount it now
	If ((Get-DiskImage -ImagePath "${ISO_FullPath}" | Get-Volume) -Eq $Null) {
		Mount-DiskImage -ImagePath ("${ISO_FullPath}") | Out-Null;
		Start-Sleep -Seconds (1);
	}

	# Get the mounted iso file's drive letter
	$Mounted_DriveLetter = ((Get-DiskImage -ImagePath "${ISO_FullPath}" | Get-Volume).DriveLetter); $Mounted_DriveLetter;

	If (([String]::IsNullOrEmpty("${Mounted_DriveLetter}")) -Eq $True) {

		# Error(s) mounting ISO file
		Write-Host "Error:  Unable to mount ISO file `"${ISO_FullPath}`"";

	} Else {

		# ISO file mounted successfully
		Write-Host "Info:  Located ISO file `"${ISO_FullPath}`" mounted to drive letter `"${Mounted_DriveLetter}`"";

		# Get the version # of Windows (stored within the .iso file)
		$Install_Esd_MountPath = ("${Mounted_DriveLetter}:\sources\install.esd");

		$DISM_Info = (Dism /Get-WimInfo /WimFile:${Install_Esd_MountPath} /index:1);

		$Regex_Win10_VersionNum = "Version\s+:\s+[\d]+\.[\d]+\.[\d]+\s*";
		$Regex_Win10_BuildNum = "ServicePack\s+Build\s+:\s+[\d]+\s*";
		
		$ISO_VersionNumber = ((((${DISM_Info} -match ${Regex_Win10_VersionNum}) -Replace "Version","") -Replace ":","") -Replace " ","");
		$ISO_BuildNumber = ((((${DISM_Info} -match ${Regex_Win10_BuildNum}) -Replace "ServicePack Build","") -Replace ":","") -Replace " ","");
		$ISO_Version_Combined = "${ISO_VersionNumber}.${ISO_BuildNumber}";

		Write-Output "${ISO_Version_Combined}";
		# Write-Output "${DISM_Info}";

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