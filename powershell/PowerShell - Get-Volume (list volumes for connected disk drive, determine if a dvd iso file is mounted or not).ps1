# ------------------------------------------------------------
#
# PowerShell - Get-Volume (list volumes for connected disk drive, determine if a dvd iso file is mounted or not)
#
# ------------------------------------------------------------


# Gets all Volume objects
Get-Volume


# ------------------------------------------------------------


# Determine if an ISO file is mounted or not
If ((Get-DiskImage -ImagePath "${ISO_FullPath}" | Get-Volume) -Eq $Null) {  # If iso file is not already mounted...
	Mount-DiskImage -ImagePath ("${ISO_FullPath}"); # Mount the iso
} Else {
	Write-Host "ISO `"${ISO_FullPath}`" already mounted";
}



# Mount an iso file, then get the mounted iso file's drive letter
$ISO_FullPath = "${HOME}\Desktop\Windows.iso";
If ((Get-DiskImage -ImagePath "${ISO_FullPath}" | Get-Volume) -Eq $Null) {  # If iso file is not already mounted...
	Mount-DiskImage -ImagePath ("${ISO_FullPath}"); # Mount the iso
}
($Mount_DiskImage | Get-Volume).DriveLetter; $Mount_DriveLetter; # Get the mount's drive letter
$Mount_DiskImage | Dismount-DiskImage | Out-Null; # Unmount the iso file



(Get-DiskImage -ImagePath "${ISO_FullPath}" | Get-Volume)



# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-Volume (Storage) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/storage/get-volume
#
# ------------------------------------------------------------