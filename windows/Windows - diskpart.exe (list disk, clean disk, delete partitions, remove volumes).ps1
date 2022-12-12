# ------------------------------------------------------------
#  Windows - diskpart.exe (list disk, clean disk, delete partitions, remove volumes)
# ------------------------------------------------------------
#
# Wipe partitions from a disk using diskpart
#  |--> Open "diskpart.exe" --> Run the following commands (replacing "[X]" with your desired disk number):
#

> LIST DISK

> SELECT DISK [X]

> DETAIL DISK

> LIST PARTITION

> SELECT PARTITION [X]

> DELETE PARTITION OVERRIDE

# Note: Adding "OVERRIDE" is required to overcome "Cannot delete a protected partition without the force protected parameter set."


# ------------------------------------------------------------
#
# Citation(s)
#
#   learn.microsoft.com  |  "diskpart | Microsoft Learn"  |  https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/diskpart
#
#   www.easeus.com  |  "Tutorial: Use DiskPart Delete All Partitions | Everything You Need to Know - EaseUS"  |  https://www.easeus.com/partition-master/diskpart-delete-all-partitions.html
#
# ------------------------------------------------------------