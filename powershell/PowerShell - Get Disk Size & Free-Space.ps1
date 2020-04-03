# ------------------------------------------------------------
#
#   PowerShell - Get Disk Size & Free-Space
#
# ------------------------------------------------------------

# Method 1
Get-PSDrive "${Env:SystemDrive}"[0]


# Method 2
Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" | Foreach-Object {$_.Size,$_.FreeSpace};


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-PSDrive - Gets drives in the current session"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-psdrive?view=powershell-5.1
#
#   stackoverflow.com  |  "powershell - How to get disk capacity and free space of remote computer - Stack Overflow"  |  https://stackoverflow.com/a/12159479
#
# ------------------------------------------------------------