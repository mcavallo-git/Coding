# ------------------------------------------------------------
#
# PowerShell
#  > Creating/Updating bootable Windows 10 (Win10/WinPE) installation media w/ custom drivers
#   > DISM, Export-WindowsDriver, Add-WindowsDriver, Mount-DiskImage, Mount-WindowsImage
#
# ------------------------------------------------------------

#
# Download Windows 10 (URL):  https://www.microsoft.com/en-us/software-download/windows10
#  > Create bootable Windows 10 media as a ".iso" file (and just output the final file to your desktop as "Windows.iso")
#
$WorkingDir = "${Home}\Desktop\WinImage";
If ((Test-Path ("${WorkingDir}")) -Eq $False) {
	New-Item -ItemType ("Directory") -Path ("${WorkingDir}\") | Out-Null;
}


#
# Optionally, export all drivers from current system (to later be included by the custom .iso)
#
$Dir_ExportedDrivers = "${WorkingDir}\Drivers_$(${Env:COMPUTERNAME})_$(Get-Date -UFormat '%Y-%m-%d_%H-%M-%S')";
If ((Test-Path ("${Dir_ExportedDrivers}")) -Eq $False) {
	New-Item -ItemType ("Directory") -Path ("${Dir_ExportedDrivers}") | Out-Null;
}
Export-WindowsDriver -Online -Destination ("${Dir_ExportedDrivers}");


#
# While that runs, go to the manufacturer's sites for the components which you'll be upgrtading
# to which you want to make sure you have drivers burnt into the Windows image-for. This could be
# graphics card, CPU chipsets, RAID controllers, etc.
#  > Create the directory "C:\DRIVERS\" if it doesn't already exist, and drop all drivers you download/want-to-add-to-the-image into that directory
#   > Note: it doesn't matter if the drivers are directly in the "C:\DRIVERS\" folder, or
#     like ten directories deep within it - we will be using a command to recursively grab
#     all .CAB files from "C:\DRIVERS", so don't sweat it!
#


#
# Once you feel you have your necessary drivers (.CAB files often with ini files, to be sure), we will begin adding the drivers
#


#
# Open a powershell prompt and set-location (cd) to your desktop, right where the "Windows.iso" installation media should be
#


# Mount the disk image (acts as if it added a disk-drive & puts it in "This PC" as D:\, E:\, whatever your next letter is)
Mount-DiskImage -ImagePath ("${Home}\Desktop\Windows.iso");


# Copy the image off of the ISO (archaic - need to update this methodology)
$MountDir = "${Home}\Desktop\Mount";
If ((Test-Path ("${MountDir}")) -Eq $False) {
	New-Item -ItemType ("Directory") -Path ("${MountDir}") | Out-Null;
}
Copy-Item ("D:\*") ("${MountDir}\") -Recurse -Force;


# Dismount the virtualized CD/DVD (We'll create it back into a .iso, later)
Dismount-DiskImage -ImagePath ("${MountDir}\");


# Mount the windows image
New-Item -ItemType ("Directory") -Path ("${WorkingDir}\") | Out-Null;
If ((Test-Path ("${MountDir}\sources\install.wim")) -Eq $False) {
	If ((Test-Path ("${MountDir}\sources\install.esd")) -Eq $True) {
		### Determine which image you want to convert, as it takes a couple minutes just for one
		DISM /Get-WimInfo /WimFile:"${MountDir}\sources\install.esd" /Index:1
		DISM /Get-WimInfo /WimFile:"${MountDir}\sources\install.esd" /Index:2
		DISM /Get-WimInfo /WimFile:"${MountDir}\sources\install.esd" /Index:3
		DISM /Get-WimInfo /WimFile:"${MountDir}\sources\install.esd" /Index:4
		DISM /Get-WimInfo /WimFile:"${MountDir}\sources\install.esd" /Index:5
		DISM /Get-WimInfo /WimFile:"${MountDir}\sources\install.esd" /Index:6
		DISM /Get-WimInfo /WimFile:"${MountDir}\sources\install.esd" /Index:7
		DISM /Get-WimInfo /WimFile:"${MountDir}\sources\install.esd" /Index:8
		DISM /Get-WimInfo /WimFile:"${MountDir}\sources\install.esd" /Index:9
		DISM /Get-WimInfo /WimFile:"${MountDir}\sources\install.esd" /Index:10
		DISM /Get-WimInfo /WimFile:"${MountDir}\sources\install.esd" /Index:11
		DISM /Get-WimInfo /WimFile:"${MountDir}\sources\install.esd" /Index:12

		### Locate the index in the "isntall.esd" corresponding to the "Windows 10 Pro" image --> and NOT the "N" version of it, either
		DISM /Export-Image /SourceImageFile:"${MountDir}\sources\install.esd" /SourceIndex:6 /DestinationImageFile:"${MountDir}\sources\install.wim" /Compress:max /CheckIntegrity;
		### ^^^ This may take up to a couple minutes to complete
	}
}
# Double-check to ensure that this image is the one you want
Get-WindowsImage -ImagePath ("${MountDir}\sources\install.wim") -Index (1);


# Mount the windows image
Mount-WindowsImage -Path ("${WorkingDir}\") -ImagePath ("${MountDir}\sources\install.wim") -Index (1);


# Add the drivers to the image
Add-WindowsDriver -Path ("${WorkingDir}\") -Driver ("C:\DRIVERS\") -Recurse -ForceUnsigned;


# Dismount & save the image
Dismount-WindowsImage -Path ("${WorkingDir}\") –Save;


# Convert the "install.wim" back into a "install.esd" file to prep for .iso export
Remove-Item "${MountDir}\sources\install.esd" -Force;
DISM /Export-Image /SourceImageFile:"${MountDir}\sources\install.wim" /SourceIndex:1 /DestinationImageFile:"${MountDir}\sources\install.esd" /Compress:recovery;
If ((Test-Path ("${MountDir}\sources\install.esd")) -Eq $True) { Remove-Item "${MountDir}\sources\install.wim" -Force; }


# Convert the image into a .iso file
If ((Get-Command "oscdimg" -ErrorAction "SilentlyContinue") -Eq $Null) {


	Write-Host "";
	Write-Host "Error:  Command `"oscdimg.exe`"' not found (required as it creates a .iso file from a target Windows PE local image to a image into an exportable .iso file)" -ForegroundColor "Yellow";
	Write-Host "        here, which comes from Microsoft's 'Windows Assessment and Deployment Kit' (ADK) ";
	Write-Host "";
	Write-Host "Error:  Missing required command 'oscdimg.exe' here, which comes from Microsoft's 'Windows Assessment and Deployment Kit' (ADK) ";
	### This is necessary so that we can convert the windows image back into a .iso file to burn onto a disk / image onto a flash-drive ###
	Write-Host "";
	Write-Host "Download Windows ADK (source):  https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install?WT.mc_id=thomasmaurer-blog-thmaure#other-adk-downloads ";
	Write-Host "";
	Write-Host "Download Windows ADK (direct):  https://go.microsoft.com/fwlink/?linkid=2086042 ";
	Write-Host "";
} Else {
	Set-Location "${Home}\Desktop\";
	oscdimg -n -m -bc:"\Users\${Env:USERNAME}\Desktop\Mount\boot\etfsboot.com" "${Home}\Desktop\Mount" "${Home}\Desktop\Windows-UpdatedDrivers.iso";
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