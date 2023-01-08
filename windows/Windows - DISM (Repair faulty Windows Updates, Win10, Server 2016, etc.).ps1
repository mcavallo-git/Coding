EXIT

# ------------------------------------------------------------

# Check for OS component store corruption using DISM's "/ScanHealth" option
DISM /Online /Cleanup-Image /ScanHealth

# Check for OS corruption flags using DISM's "/CheckHealth" option
DISM /Online /Cleanup-Image /CheckHealth

# Check for + repair OS component store corruption using DISM's "/RestoreHealth" option
DISM /Online /Cleanup-Image /RestoreHealth


# ------------------------------------------------------------
#
# Repair current OS image using "/source" + "Windows.iso" external source
#

#
# Step 1: Obtain an "install.esd" file from a "Windows.iso" file or drive (under "sources" folder)
#  |
#  |-->  Create "Windows.iso" file via "Create Windows 10 installation media" tool @ https://www.microsoft.com/en-us/software-download/windows10
#  |      |
#  |      |-->  Mount any created "Windows.iso" files via right-click -> "Mount" option
#  |
#  |-->  If your Windows source contains an "sources/install.wim" file, skip steps 2 and 3 & reference its fullpath, below
#


#
# Step 2: Determine install.esd's "index" for your desired OS
#  |
#  |--> Ignore all images whose name ends in " N" (unless you are certain that's the type of OS image you're trying to repair)
#

$Input_Esd_FullPath=[string]"C:\ISO\install.esd";
DISM /Get-WimInfo /WimFile:"${Input_Esd_FullPath}"

#
# Example output (find OS list that matches your OS - use that index, below)
#   Index : 6
#   Name : Windows 10 Pro
#   Description : Windows 10 Pro
#   Size : 15,071,438,212 bytes
#


#
# Step 3: Convert "install.esd" + [index] into "install.wim"  (will output with a single index of 1)
#

$Input_Esd_Index=[int](6);
$Input_Esd_FullPath=[string]"C:\ISO\install.esd";
$Output_Wim_FullPath=[string]"C:\ISO\install.wim";
DISM /Export-Image /SourceImageFile:"${Input_Esd_FullPath}" /SourceIndex:"${Input_Esd_Index}" /DestinationImageFile:"${Output_Wim_FullPath}" /Compress:none /CheckIntegrity


#
# Step 4: Reference the "install.wim" (with index of 1) as a source file for DISM to repair the current OS image off-of
#

$Output_Wim_FullPath=[string]"C:\ISO\install.wim";
$Output_Wim_Index=[int](1);
DISM /Online /Cleanup-Image /RestoreHealth /source:WIM:${Output_Wim_FullPath}:${Output_Wim_Index} /LimitAccess


# ------------------------------------------------------------
#
# Use DISM to cleanup the "C:\Windows\WinSxS" folder via:
#

DISM /Online /Cleanup-Image /StartComponentCleanup


# ------------------------------------------------------------
#
# Use DISM to remove all previous updates (WARNING: cannot roll-back if ANY errors occur) via:
#

DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase


# ------------------------------------------------------------
#
# Citation(s)
#
#   microsoft.com  |  "Download Windows 10"  |  https://www.microsoft.com/en-us/software-download/windows10
#
#   windowscentral.com  |  "How to use DISM command tool to repair Windows 10 image"  |  https://www.windowscentral.com/how-use-dism-command-line-utility-repair-windows-10-image
#
#   laptopmag.com  |  "How to Save Space By Cleaning Windows' WinSxS Folder"  |  https://www.laptopmag.com/articles/clean-winsxs-folder-to-save-space
#
# ------------------------------------------------------------