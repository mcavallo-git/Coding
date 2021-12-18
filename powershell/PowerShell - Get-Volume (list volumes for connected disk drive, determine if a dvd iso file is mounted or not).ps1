# ------------------------------------------------------------
#
# PowerShell - Get-Volume (list volumes for connected disk drive, determine if a dvd iso file is mounted or not)
#
# ------------------------------------------------------------


#
# Get all volume objects
#
Get-Volume


# ------------------------------------------------------------
#
#  Get-DiskImage  +  Get-Volume
#

# Determine if an ISO file is mounted or not
$ISO_Fullpath = "${HOME}\Desktop\Windows.iso";
If ((Get-DiskImage -ImagePath "${ISO_FullPath}" | Get-Volume) -Eq $Null) {  # If iso file is not already mounted...
	Write-Host "ISO file NOT mounted";
} Else {
	Write-Host "ISO file IS mounted";
}


#
# EXAMPLE:  Mount an iso file > get the mounted iso file's drive letter > unmount the iso file
#

If ($True) {

$ISO_Fullpath = "${HOME}\Desktop\Windows.iso";

# Determine if the iso file is already mounted
$Mounted_DriveLetter = ((Get-DiskImage -ImagePath "${ISO_FullPath}" | Get-Volume).DriveLetter);

# If iso file is not already mounted, then mount it now
If ((Get-DiskImage -ImagePath "${ISO_FullPath}" | Get-Volume) -Eq $Null) {
	Mount-DiskImage -ImagePath ("${ISO_FullPath}") | Out-Null;
}

# Get the mounted iso file's drive letter
$Mounted_DriveLetter = ((Get-DiskImage -ImagePath "${ISO_FullPath}" | Get-Volume).DriveLetter); $Mounted_DriveLetter;

If (([String]::IsNullOrEmpty("${Mounted_DriveLetter}")) -Eq $True) {

	# Error(s) mounting ISO file
	Write-Host "Error:  Unable to mount ISO file";

} Else {

	# ISO file mounted successfully
	Write-Host "Info:  Mounted_DriveLetter = [ ${Mounted_DriveLetter} ]";

	# Unmount the iso file
	Get-DiskImage -ImagePath "${ISO_FullPath}" | Dismount-DiskImage | Out-Null;

}

}


# ------------------------------------------------------------
#
# Citation(s)
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