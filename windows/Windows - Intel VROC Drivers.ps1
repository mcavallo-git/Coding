# ------------------------------------------------------------
#
# !!! NOTE: The following is stated in the "Intel VROC Quick Configuration Guide" @  [ https://www.intel.com/content/dam/support/us/en/documents/server-products/server-boards/Intel-VROC-Quick-Configuration-Guide.pdf ]:

$Intel_QuickStart_DirectStatement= `
"Note: Intel VROC is not compatible with Secure Boot. 
 If you want to use Intel VROC (VMD NVME RAID), do not enable the
 system's Secure Boot feature. If Secure boot is required for the
 solution Intel VROC cannot be used.        --Intel";

#
# ------------------------------------------------------------
#
### The soution for a Lenovo P520c workstation was two-part:
#
# ------------------------------------------------------------
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
# ------------------------------------------------------------
#
### Part 2/2
# > Injecting the necessary drivers into the Windows Install media's image (much easier than it sounds thanks to guide, below)
#  > Pull the RAID Controller drivers from your motherboard-manufacturer's website (if software RAID) or from your RAID-controller manufacturer's website (if hardware RAID)
#   > Install (unpack) all drivers into the directory "C:\Drivers" (create it if it doesn't already exist)
#
# ------------------------------------------------------------
#
# To begin, start by creating updated Windows10 installation media, locally  (a .iso file on the desktop will be what this example will use)
# Download Windows 10 (URL):  https://www.microsoft.com/en-us/software-download/windows10
#  > Create bootable Windows 10 media as a ".iso" file (and just output the final file to your desktop as "Windows.iso")
#
#
# While that runs, go to the manufacturer's sites for the components which you'll be upgrtading
# to which you want to make sure you have drivers burnt into the Windows image-for. This could be
# graphics card, CPU chipsets, RAID controllers, etc.
#  > Create the directory "C:\DRIVERS\" if it doesn't already exist, and drop all drivers you download/want-to-add-to-the-image into that directory
#   > Note: it doesn't matter if the drivers are directly in the "C:\DRIVERS\" folder, or
#     like ten directories deep within it - we will be using a command to recursively grab
#     all .CAB files from "C:\DRIVERS", so don't sweat it!

# Once you feel you have your necessary drivers (.CAB files often with ini files, to be sure), we will begin adding the drivers

# Open a powershell prompt and set-location (cd) to your desktop, right where the "Windows.iso" installation media should be

# Mount the disk image (acts as if it added a disk-drive & puts it in "This PC" as D:\, E:\, whatever your next letter is)
Mount-DiskImage -ImagePath ("${Home}\Desktop\Windows.iso") -StorageType ("ISO") -Access ("ReadWrite");

# Inspect the image to verify it is the image you want
Get-WindowsImage -ImagePath ("D:\sources\boot.wim");
#
# ImageIndex       : 1
# ImageName        : Microsoft Windows PE (x64)
# ImageDescription : Microsoft Windows PE (x64)
# ImageSize        : 1,706,317,122 bytes
#
# ImageIndex       : 2
# ImageName        : Microsoft Windows Setup (x64)
# ImageDescription : Microsoft Windows Setup (x64)
# ImageSize        : 1,882,672,563 bytes
#

# Mount the windows image 
New-Item -ItemType ("Directory") -Path ("${Home}\Desktop\Mount\");
Mount-WindowsImage -ImagePath ("D:\sources\boot.wim") -Index (2) -Path ("${Home}\Desktop\Mount\");

# Add the drivers
Add-WindowsDriver -Path ("${Home}\Desktop\Mount\") -Driver ("C:\DRIVERS\") -Recurse -ForceUnsigned;

# Simultaneously dismount & save the Windows-Image
Dismount-WindowsImage -Path ("${Home}\Desktop\Mount\") –Save

# Dismount the virtualized CD/DVD
Dismount-DiskImage -ImagePath ("${Home}\Desktop\Mount\");



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
#   docs.microsoft.com  |  "Dismount-DiskImage - Dismounts a disk image (virtual hard disk or ISO) so that it can no longer be accessed as a disk"  |  https://docs.microsoft.com/en-us/powershell/module/dism/get-windowsimage
#
#   docs.microsoft.com  |  "Dismount-WindowsImage - Dismounts a Windows image from the directory it is mapped to"  |  https://docs.microsoft.com/en-us/powershell/module/dism/dismount-windowsimage

#   docs.microsoft.com  |  "Mount-DiskImage - Mounts a previously created disk image (virtual hard disk or ISO), making it appear as a normal disk"  |  https://docs.microsoft.com/en-us/powershell/module/storage/mount-diskimage

#   docs.microsoft.com  |  "Mount-WindowsImage - Mounts a Windows image in a WIM or VHD file to a directory on the local computer"  |  https://docs.microsoft.com/en-us/powershell/module/dism/mount-windowsimage
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
#   www.windowscentral.com  |  "How to mount or unmount ISO images on Windows 10 | Windows Central"  |  https://www.windowscentral.com/how-mount-or-unmount-iso-images-windows-10
#
# ------------------------------------------------------------