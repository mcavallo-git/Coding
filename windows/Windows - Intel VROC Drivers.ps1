# ------------------------------------------------------------

# !!! NOTE: The following is stated in the "Intel VROC Quick Configuration Guide" @  [ https://www.intel.com/content/dam/support/us/en/documents/server-products/server-boards/Intel-VROC-Quick-Configuration-Guide.pdf ]:
$Intel_QuickStart_DirectStatement="Note: Intel VROC is not compatible with Secure Boot. If you want to use Intel VROC (VMD NVME RAID), do not enable the system's Secure Boot feature. If Secure boot is required for the solution Intel VROC cannot be used";

### The soution for the P520c workstation was tp set the following values within the BIOS/UEFI settings:
#
# SECURE BOOT = OFF
#
# CSM = ENABLED
#
# BOOT FROM PCI-E/PCI DEVICES --> SET TO BOOT FROM UEFI, FIRST
#



# ------------------------------------------------------------

# View Citation(s), below (and elsewhere) to locate the drivers required for your specific hardware RAID controller (Intel VROC RAID 1 used in this example)

# Once you feel you have your necessary drivers  follow the guide at  [ http://woshub.com/integrate-drivers-to-windows-install-media/ ]  to run the necessary DISM/etc. commands to create Windows boot media w/ RAID (VROC) drivers pre-installed and ready to go


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