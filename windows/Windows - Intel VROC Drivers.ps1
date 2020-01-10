# ------------------------------------------------------------

# !!! NOTE: The following is stated in the "Intel VROC Quick Configuration Guide" @  [ https://www.intel.com/content/dam/support/us/en/documents/server-products/server-boards/Intel-VROC-Quick-Configuration-Guide.pdf ]:
$Intel_QuickStart_DirectStatement="Note: Intel VROC is not compatible with Secure Boot. If you want to use Intel VROC (VMD NVME RAID), do not enable the system's Secure Boot feature. If Secure boot is required for the solution Intel VROC cannot be used";


### The soution for a Lenovo P520c workstation was two-part:


### Part 1/2: Set the following values within the BIOS/UEFI settings:
#
# SECURE BOOT = OFF
#
# CSM = ENABLED
#
# BOOT FROM PCI-E/PCI DEVICES --> SET TO BOOT FROM UEFI, FIRST
#


### Part 2/2: Inject the necessary drivers into the Windows Install media's image (much easier than it sounds thanks to guide, below)
#
# Pull the RAID Controller drivers from your motherboard-manufacturer's website (if software RAID) or from your RAID-controller manufacturer's website (if hardware RAID)
#
# Install (unpack) all drivers into the directory "C:\Drivers" (create it if it doesn't already exist)
#
# Once you feel you have your necessary drivers, follow the guide @ 
# http://woshub.com/integrate-drivers-to-windows-install-media/
# to run the necessary DISM/etc. commands to create Windows boot media w/ RAID (VROC) drivers pre-installed and ready to go
#
#


# ------------------------------------------------------------
#
# Citation(s)
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
# ------------------------------------------------------------