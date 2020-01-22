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
#
#
# While that runs, go to the manufacturer's sites for the components which you'll be upgrtading
# to which you want to make sure you have drivers burnt into the Windows image-for. This could be
# graphics card, CPU chipsets, RAID controllers, etc.
#
#
# Once you feel you have your necessary drivers (CAB files w/ ini files, to be sure...)
#  > Follow the guide @ http://woshub.com/integrate-drivers-to-windows-install-media/
#   > Run the necessary DISM/PowerShell commands to create Windows boot media w/ RAID (VROC) drivers pre-installed and ready to go
#
#
# Starting with the "Windows.iso" media, which was output to the Desktop via the Microsoft "Create Windows 10 installation media" tool


# Mount the media (must un-mount / pack-back-up before ending)
Mount-DiskImage -ImagePath ("${Home}\Desktop\Windows.iso");

New-Item -ItemType ("Directory") -Path ("${Home}\Desktop\Mount\");
Mount-WindowsImage -Path ("${Home}\Desktop\Mount\") -ImagePath ("${Home}\Desktop\Windows.iso") -Index (1);


# Inspect the media to determine which image(s) you want to keep & which you want to remove
Get-WindowsImage -ImagePath ("C:\WinWork\ISO\Windows.iso");




Mount-DiskImage -ImagePath ("${Home}\Desktop\Windows.iso");
## Adds the disk as a D:\ Drive on "This PC" (in Win10)

Dismount-DiskImage -ImagePath ("${Home}\Desktop\Windows.iso");
## Respectively removes the aforementioned drive






# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Mount-DiskImage - Mounts a previously created disk image (virtual hard disk or ISO), making it appear as a normal disk"  |  https://docs.microsoft.com/en-us/powershell/module/storage/mount-diskimage
#
#   docs.microsoft.com  |  "Dismount-DiskImage - Dismounts a disk image (virtual hard disk or ISO) so that it can no longer be accessed as a disk"  |  https://docs.microsoft.com/en-us/powershell/module/storage/dismount-diskimage?view=win10-ps
#
#   www.windowscentral.com  |  "How to mount or unmount ISO images on Windows 10 | Windows Central"  |  https://www.windowscentral.com/how-mount-or-unmount-iso-images-windows-10
#
# ------------------------------------------------------------












# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Dismount-DiskImage - Dismounts a disk image (virtual hard disk or ISO) so that it can no longer be accessed as a disk"  |  https://docs.microsoft.com/en-us/powershell/module/storage/dismount-diskimage?view=win10-ps

#   docs.microsoft.com  |  "Mount-DiskImage - Mounts a previously created disk image (virtual hard disk or ISO), making it appear as a normal disk"  |  https://docs.microsoft.com/en-us/powershell/module/storage/mount-diskimage
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