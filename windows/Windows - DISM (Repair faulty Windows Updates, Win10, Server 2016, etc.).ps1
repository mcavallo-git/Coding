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
# Repair using DISM's "/source" option
#


If ($True) {
  #
  # Step 1: Acquire a "Windows.iso" file (or plug in an external installation media USB drive)
  #  |
  #  |-->  Create a new "Windows.iso" file via "Create Windows 10 installation media" tool @ https://www.microsoft.com/en-us/software-download/windows10
  #  |      |
  #  |      |--> Mount a "Windows.iso" file via right-click -> "Mount" option
  #  |
  #  |-->  If your Windows source contains an "sources/install.wim" file, use it instead and skip Step 2 & Step 3, below
  #

  $Windows_Iso_FullPath=[string]"C:\ISO\Windows.iso";
  $Input_Esd_FullPath=[string]"C:\ISO\install.esd";
  $Input_Wim_FullPath=[string]"C:\ISO\install.wim";

  Mount-DiskImage -ImagePath ("${Windows_Iso_FullPath}");  # Mount the ISO
  $Iso_Esd_FullPath=[string]"D:\sources\install.esd";  # Locate the "install.esd" on the ISO
  $Iso_Wim_FullPath=[string]"D:\sources\install.wim";  # Locate the "install.esd" on the ISO

  If (Test-Path "${Iso_Esd_FullPath}") {
    Copy-Item -Path ("${Iso_Esd_FullPath}") -Destination ("${Input_Esd_FullPath}") -Force;  # Extract ISO file's "sources/install.esd"
  } Else {
    Copy-Item -Path ("${Iso_Wim_FullPath}") -Destination ("${Input_Wim_FullPath}") -Force;  # Extract ISO file's "sources/install.esd"
  }
  Dismount-DiskImage -ImagePath ("${Windows_Iso_FullPath}");  # Unmount the ISO
}



If ($True) {
  #
  # Step 2: Determine install.esd's "index" for your desired OS
  #  |
  #  |--> Ignore all images whose name ends in " N" (unless you are certain that's the type of OS image you're trying to repair)
  #

  $Input_Esd_FullPath=[string]"C:\ISO\install.esd";
  $Input_Wim_FullPath=[string]"C:\ISO\install.wim";

  If (Test-Path "${Input_Esd_FullPath}") {
    DISM /Get-WimInfo /WimFile:"${Input_Esd_FullPath}"
  } Else {
    DISM /Get-WimInfo /WimFile:"${Input_Wim_FullPath}"
  }

  #
  # Example output (find OS list that matches your OS - use that index, below)
  #   Index : 6
  #   Name : Windows 10 Pro
  #   Description : Windows 10 Pro
  #   Size : 15,071,438,212 bytes
  #
}



If ($True) {
  #
  # Step 3: Convert "install.esd" + [index] into "install.wim"  (will output with a single index of 1)
  #

  $Image_Index=[int](6);
  $Input_Esd_FullPath=[string]"C:\ISO\install.esd";
  $Input_Wim_FullPath=[string]"C:\ISO\install.wim";
  $Output_Wim_FullPath=[string]"C:\ISO\install_singledistro.wim";

  If (Test-Path "${Input_Esd_FullPath}") {
    DISM /Export-Image /SourceImageFile:"${Input_Esd_FullPath}" /SourceIndex:"${Image_Index}" /DestinationImageFile:"${Output_Wim_FullPath}" /Compress:none /CheckIntegrity
  } Else {
    DISM /Export-Image /SourceImageFile:"${Input_Wim_FullPath}" /SourceIndex:"${Image_Index}" /DestinationImageFile:"${Output_Wim_FullPath}" /Compress:none /CheckIntegrity
  }

}



If ($True) {
  #
  # Step 4: Reference the "install.wim" (with index of 1) as a source file for DISM to repair the current OS image off-of
  #

  $Output_Wim_FullPath=[string]"C:\ISO\install_singledistro.wim";
  $Output_Wim_Index=[int](1);

  DISM /Online /Cleanup-Image /RestoreHealth /source:WIM:${Output_Wim_FullPath}:${Output_Wim_Index} /LimitAccess

}


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
#   laptopmag.com  |  "How to Save Space By Cleaning Windows' WinSxS Folder"  |  https://www.laptopmag.com/articles/clean-winsxs-folder-to-save-space
#
#   microsoft.com  |  "Download Windows 10"  |  https://www.microsoft.com/en-us/software-download/windows10
#
#   windowscentral.com  |  "How to use DISM command tool to repair Windows 10 image"  |  https://www.windowscentral.com/how-use-dism-command-line-utility-repair-windows-10-image
#
#   windowsreport.com  |  "DISM Failed on a Windows PC? 9 Quick Fixes"  |  https://windowsreport.com/dism-failed-windows-10/#2-enter-the-correct-location-of-install-wim-file
#
# ------------------------------------------------------------