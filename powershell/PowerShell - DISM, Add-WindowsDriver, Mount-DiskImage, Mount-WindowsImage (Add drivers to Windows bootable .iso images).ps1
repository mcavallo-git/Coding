# ------------------------------------------------------------
#
# PowerShell
#  > Creating/Updating bootable Windows 10 (Win10/WinPE) installation media w/ custom drivers
#   > DISM, Export-WindowsDriver, Add-WindowsDriver, Mount-DiskImage, Mount-WindowsImage
#
# ------------------------------------------------------------

#
# Download Updated Win10 installation media from URL:   https://www.microsoft.com/en-us/software-download/windows10
#    > Select option "Create installation media (USB flash drive, DVD, or ISO file) for another pc" and output the .iso file to your desktop w/ name "Windows.iso"
#


#
# While that runs, go to the manufacturer's sites for the components which you'll be upgrading-to & need drivers for
#  > Grab drivers for:  GPU (graphics card), CPU (chipsets), RAID controllers (HBA), NICs (Network interface cards, wired & wireless), etc.
#   > These drivers will be 'burned' into the Windows .iso image
#    > Once you feel you have all/enough necessary drivers (formatted as .CAB files, which often have associated ini files), proceed with this script
#


#
# Mount the disk image, copy the working installation files off of it, then dismount the disk image
#  > Note: Command 'Mount-DiskImage' mounts the .iso file using the next-available drive letter (in alphabetical order from C to Z) as a virtual dvd-drive
#   > Note: Not tested in an environment where every single drive letter is already taken/reserved by an existing disk/partition
#    > Note: Approach seems somewhat archaic - need to (ideally) update this methodology to work directly on/within a target .iso
#
$ISO_Fullpath = "${Home}\Desktop\Windows.iso";
$MountDir = "${Home}\Desktop\Mount";
$DriveLetter = "";
$Possible_DriveLetters = @("C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z");
$Possible_DriveLetters | ForEach-Object { If ((Test-Path -Path ("$($_):\")) -Eq $False) { $DriveLetter = $_; Break; }; };
Write-Host "`$DevicePath  = $DriveLetter";
$Mounted_ISO = Mount-DiskImage -ImagePath ("${ISO_Fullpath}");
If ((Test-Path ("${MountDir}")) -Eq $False) {
	New-Item -ItemType ("Directory") -Path ("${MountDir}") | Out-Null;
};
Copy-Item ("${DriveLetter}:\*") ("${MountDir}\") -Recurse -Force;
$Mounted_ISO | Dismount-DiskImage;


# Determine which index to pull out of the downloaded Windows image
$WimInfoIndex = $Null;
$Install_Wim = "${MountDir}\sources\install.wim"
$Install_Esd = "${MountDir}\sources\install.esd"
If ((Test-Path ("${Install_Wim}")) -Eq $False) {
	If ((Test-Path ("${Install_Esd}")) -Eq $True) {
		# Determine which image you want to convert (as each, separate image will require a few minutes to update)
		12..1 | ForEach-Object {
			$EachIndex = $_;
			$pinfo = New-Object System.Diagnostics.ProcessStartInfo;
			$pinfo.FileName = "C:\Windows\system32\Dism.exe";
			$pinfo.RedirectStandardError = $True;
			$pinfo.RedirectStandardOutput = $True;
			$pinfo.UseShellExecute = $False;
			$pinfo.Arguments = (@("/Get-WimInfo","/WimFile:`"${MountDir}\sources\install.esd`"","/Index:${EachIndex}"));
			$p = New-Object System.Diagnostics.Process;
			$p.StartInfo = $pinfo;
			$p.Start() | Out-Null;
			$p.WaitForExit();
			$stdout = $p.StandardOutput.ReadToEnd();
			$stderr = $p.StandardError.ReadToEnd();
			If (($p.ExitCode) -Eq 0) {
				<# Search for desired index/release/version of windows within the .iso image #>
				$Haystack = $stdout;
				$Pattern  = '^Name : Windows 10 Pro$';
				$KeepImage = $False;
				($stdout -split "`r`n") | ForEach-Object {
					$EachLine = $_;
					Write-Host "------------------------------------------------------------";
					Write-Host "$EachLine";
					$Needle   = [Regex]::Match($Haystack, $Pattern);
					If ($Needle.Success -Eq $True) {
						$KeepImage = $True;
						$WimInfoIndex = $EachIndex;
						Write-Host "`$WimInfoIndex = $WimInfoIndex";
					}
				}
				If (${KeepImage} -Eq $False) {
					Remove-WindowsImage -ImagePath "c:\imagestore\custom.wim" -Index $WimInfoIndex -CheckIntegrity;
				}
			}
			$pinfo = $Null;
		}

		<# Locate the index in the "install.esd" corresponding to the "Windows 10 Pro" image --> and NOT the "N" version of it, either #>
		If ($WimInfoIndex -Eq $Null) {
			$WimInfoIndex = 1;
		}

		<# Export the image by creating/updating the "Install.wim" windows image-file #>
		<#   > Note: this process often requires a few (~2-3) minutes to complete, and may take longer if you've added many more drivers to the customized Windows image #>
		DISM /Export-Image /SourceImageFile:"${Install_Esd}" /SourceIndex:${WimInfoIndex} /DestinationImageFile:"${Install_Wim}" /Compress:max /CheckIntegrity;

		<# Double-check to ensure that this image is the one you want #>
		Get-WindowsImage -ImagePath ("${Install_Wim}") -Index ($WimInfoIndex);
	}
}



If ($True) {

# Mount the windows image
$WorkingDir = "${Home}\Desktop\WinImage";
If ((Test-Path ("${WorkingDir}")) -Eq $False) {
	New-Item -ItemType ("Directory") -Path ("${WorkingDir}\") | Out-Null;
}
Mount-WindowsImage -Path ("${WorkingDir}\") -ImagePath ("${Install_Wim}") -Index ($WimInfoIndex);

# Recursively 'burn-in' (add) all .CAB driver-files from "${Dir_DriversSource}" directory to the mounted Windows image (this is the 'customization' step)
#  > Optionally, burn all drivers from the current system into the custom .iso)
$Dir_DriversSource = "C:\DRIVERS\";
$Dir_CurrentSystemDrivers = "${Dir_DriversSource}\Drivers_$(${Env:COMPUTERNAME})_$(Get-Date -UFormat '%Y%m%d_%H%M%S')";
If ((Test-Path ("${Dir_CurrentSystemDrivers}")) -Eq $False) {
	New-Item -ItemType ("Directory") -Path ("${Dir_CurrentSystemDrivers}") | Out-Null;
}
Export-WindowsDriver -Online -Destination ("${Dir_CurrentSystemDrivers}");
Add-WindowsDriver -Path ("${WorkingDir}\") -Driver ("${Dir_DriversSource}\") -Recurse -ForceUnsigned;

# Dismount & save the image
Dismount-WindowsImage -Path ("${WorkingDir}\") –Save;

}


<# Convert the "install.wim" back to an "install.esd" file to prep for .iso export #>
<#   Note:  Converting the image back from ".wim" to ".esd" format  often requires a few (~2-3) minutes to complete, and may take longer depending on the number of drivers added #>
Remove-Item "${Install_Esd}" -Force;
DISM /Export-Image /SourceImageFile:"${Install_Wim}" /SourceIndex:$WimInfoIndex /DestinationImageFile:"${Install_Esd}" /Compress:recovery;
If ((Test-Path ("${Install_Esd}")) -Eq $True) { Remove-Item "${Install_Wim}" -Force; }


# Convert the image into a .iso file
If ((Get-Command "oscdimg" -ErrorAction "SilentlyContinue") -Ne $Null) {
	Set-Location "${Home}\Desktop\";
	oscdimg -n -m -bc:"\Users\${Env:USERNAME}\Desktop\Mount\boot\etfsboot.com" "${Home}\Desktop\Mount" "${Home}\Desktop\Win10Pro_Customized-UpdatedDrivers_$(Get-Date -UFormat '%Y%m%d_%H%M%S').iso";
} Else {
	Write-Host "";
	Write-Host "Error:  Command `"oscdimg.exe`"' not found (required as it creates a .iso file from a target Windows PE local image to a image into an exportable .iso file)" -ForegroundColor "Yellow";
	Write-Host "        here, which comes from Microsoft's 'Windows Assessment and Deployment Kit' (ADK) ";
	Write-Host "";
	Write-Host "Error:  Missing required command 'oscdimg.exe' here, which comes from Microsoft's 'Windows Assessment and Deployment Kit' (ADK) ";
	# Alert the user why we need the "oscdimg" command
	#   > Essentially, the "oscdimg" command allows us to convert the windows image from [ the directory we previously worked-on/added-drivers-to ] to [ a .iso file, which can then be burned onto a flash drive and used as bootable media (which installs Windows with all previously attached drivers burned into said Windows image) ] ###
	Write-Host "";
	Write-Host "Download Windows ADK (source):  https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install?WT.mc_id=thomasmaurer-blog-thmaure#other-adk-downloads ";
	Write-Host "";
	Write-Host "Download Windows ADK (direct):  https://go.microsoft.com/fwlink/?linkid=2086042 ";
	Write-Host "";
}

# > Use a tool such as "Rufus" to image a flash drive with this updated .iso file


# > Format your device-to-be-formatted and you should be good to go


# ------------------------------------------------------------
#
# !!! NOTE: The following is stated in the "Intel VROC Quick Configuration Guide" @  [ https://www.intel.com/content/dam/support/us/en/documents/server-products/server-boards/Intel-VROC-Quick-Configuration-Guide.pdf ]:

$Intel_QuickStart_DirectStatement= `
"Note: Intel VROC is not compatible with Secure Boot. 
 If you want to use Intel VROC (VMD NVME RAID), do not enable the
 system's Secure Boot feature. If Secure boot is required for the
 solution Intel VROC cannot be used.        --Intel";
Write-Host "$Intel_QuickStart_DirectStatement";

#
### The soution for a Lenovo P520c workstation was two-part:
#
#
### Part 1/2: Set the following values within the BIOS/UEFI settings:
#
# SECURE BOOT = OFF
#
# CSM = ENABLED
#
# BOOT FROM PCI-E/PCI DEVICES --> SET TO BOOT FROM UEFI, FIRST
#
#
### Part 2/2
# > Injecting the necessary drivers into the Windows Install media's image (much easier than it sounds thanks to guide, below)
#  > Pull the RAID Controller drivers from your motherboard-manufacturer's website (if software RAID) or from your RAID-controller manufacturer's website (if hardware RAID)
#   > Install (unpack) all drivers into the directory "C:\Drivers" (create it if it doesn't already exist)
#
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Add-WindowsDriver - Adds a driver to an offline Windows image"  |  https://docs.microsoft.com/en-us/powershell/module/dism/add-windowsdriver
#
#   docs.microsoft.com  |  "Get-DiskImage - Gets one or more disk image objects (virtual hard disk or ISO)"  |  https://docs.microsoft.com/en-us/powershell/module/storage/get-diskimage
#
#   docs.microsoft.com  |  "Get-WindowsImage - Gets information about a Windows image in a WIM or VHD file"  |  https://docs.microsoft.com/en-us/powershell/module/storage/dismount-diskimage
#
#   docs.microsoft.com  |  "Get-WindowsImageContent - Displays a list of the files and folders in a specified image"  |  https://docs.microsoft.com/en-us/powershell/module/dism/get-windowsimagecontent
#
#   docs.microsoft.com  |  "Dismount-DiskImage - Dismounts a disk image (virtual hard disk or ISO) so that it can no longer be accessed as a disk"  |  https://docs.microsoft.com/en-us/powershell/module/dism/get-windowsimage
#
#   docs.microsoft.com  |  "Dismount-WindowsImage - Dismounts a Windows image from the directory it is mapped to"  |  https://docs.microsoft.com/en-us/powershell/module/dism/dismount-windowsimage

#   docs.microsoft.com  |  "Mount-DiskImage - Mounts a previously created disk image (virtual hard disk or ISO), making it appear as a normal disk"  |  https://docs.microsoft.com/en-us/powershell/module/storage/mount-diskimage

#   docs.microsoft.com  |  "Mount-WindowsImage - Mounts a Windows image in a WIM or VHD file to a directory on the local computer"  |  https://docs.microsoft.com/en-us/powershell/module/dism/mount-windowsimage

#   docs.microsoft.com  |  "Oscdimg Command-Line Options | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/oscdimg-command-line-options
#
#   downloadcenter.intel.com  |  "Intel® Virtual RAID on CPU (Intel® VROC) and Intel® Rapid Storage Technology Enterprise (Intel® RSTe) Driver for Windows*"  |  https://downloadcenter.intel.com/download/29246/Intel-Virtual-RAID-on-CPU-Intel-VROC-and-Intel-Rapid-Storage-Technology-Enterprise-Intel-RSTe-Driver-for-Windows-
#
#   stackoverflow.com  |  "powershell - Capturing standard out and error with Start-Process - Stack Overflow"  |  https://stackoverflow.com/a/8762068
#
#   support.lenovo.com  |  "SCCM Packages For Windows PE 10 (64-bit) - ThinkStation P520, P520c"  |  https://support.lenovo.com/us/en/downloads/ds502154
#
#   support.lenovo.com  |  "Unable to image P520c"  |  https://support.lenovo.com/us/en/downloads/ds502154
#
#   woshub.ch  |  "How to Inject Drivers into a Windows 10 WIM/ISO Install Image? | Windows OS Hub"  |  http://woshub.com/integrate-drivers-to-windows-install-media/
#
#   www.intel.com  |  "Intel Solid State Drives with PCIe NVMe"  |  https://www.intel.com/content/dam/support/us/en/documents/memory-and-storage/enthusiast-ssds/PCIe-NVMe-SSD-Install-Boot-Guide.pdf
#
#   www.intel.com  |  "Intel VROC Quick Configuration Guide"  |  https://www.intel.com/content/dam/support/us/en/documents/server-products/server-boards/Intel-VROC-Quick-Configuration-Guide.pdf
#
#   www.thomasmaurer.ch  |  "Add Drivers to a Windows Server 2019 ISO Image - Thomas Maurer"  |  https://www.thomasmaurer.ch/2019/07/add-drivers-to-a-windows-server-2019-iso-image/
#
#   www.windowscentral.com  |  "How to mount or unmount ISO images on Windows 10 | Windows Central"  |  https://www.windowscentral.com/how-mount-or-unmount-iso-images-windows-10
#
# ------------------------------------------------------------