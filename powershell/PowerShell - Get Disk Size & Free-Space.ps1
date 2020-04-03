# ------------------------------------------------------------
#
#   PowerShell - Get Disk Size & Free-Space
#
# ------------------------------------------------------------

# Method 1
$LocalDiskSpace = Get-PSDrive C | Select-Object Used,Free


# Method 2
$LocalDiskSpace = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" | Foreach-Object {$_.Size,$_.FreeSpace}


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "powershell - How to get disk capacity and free space of remote computer - Stack Overflow"  |  https://stackoverflow.com/a/12159479
#
# ------------------------------------------------------------