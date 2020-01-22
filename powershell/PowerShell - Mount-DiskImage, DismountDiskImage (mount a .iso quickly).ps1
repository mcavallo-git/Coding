

Mount-DiskImage -ImagePath ("${Home}\Desktop\Windows.iso");
## Adds the disk as a D:\ Drive on "This PC" (in Win10)


Dismount-DiskImage -ImagePath ("${Home}\Desktop\Windows.iso");
## Respectively removes the aforementioned drive





# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Dismount-DiskImage - Dismounts a disk image (virtual hard disk or ISO) so that it can no longer be accessed as a disk"  |  https://docs.microsoft.com/en-us/powershell/module/storage/dismount-diskimage?view=win10-ps
#
#   docs.microsoft.com  |  "Mount-DiskImage - Mounts a previously created disk image (virtual hard disk or ISO), making it appear as a normal disk"  |  https://docs.microsoft.com/en-us/powershell/module/storage/mount-diskimage
#
#   www.windowscentral.com  |  "How to mount or unmount ISO images on Windows 10 | Windows Central"  |  https://www.windowscentral.com/how-mount-or-unmount-iso-images-windows-10
#
# ------------------------------------------------------------