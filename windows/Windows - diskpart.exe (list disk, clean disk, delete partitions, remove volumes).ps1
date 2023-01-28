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
# Wipe disk completely using diskpart
#

> LIST DISK

> SELECT DISK [X]

> DETAIL DISK

> LIST PARTITION

> CLEAN


# ------------------------------------------------------------
#
# Citation(s)
#
#   learn.microsoft.com  |  "diskpart | Microsoft Learn"  |  https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/diskpart
#
#   www.easeus.com  |  "Tutorial: Use DiskPart Delete All Partitions | Everything You Need to Know - EaseUS"  |  https://www.easeus.com/partition-master/diskpart-delete-all-partitions.html
#
#   www.seagate.com  |  "How to Diskpart Erase/Clean a Drive Through the Command Prompt | Support Seagate US"  |  https://www.seagate.com/support/kb/how-to-diskpart-eraseclean-a-drive-through-the-command-prompt-005929en/
#
# ------------------------------------------------------------