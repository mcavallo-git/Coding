# ------------------------------------------------------------
# PowerShell - Get-Disk, Get-StorageReliabilityCounter (get S.M.A.R.T. values for attached disk(s))
# ------------------------------------------------------------
#
# List all available S.M.A.R.T. values for all disks
#

Get-Disk | Get-StorageReliabilityCounter | Select-Object "*";


# ------------------------------
#
# Get temperature of primary disk
#

Get-Disk | Get-StorageReliabilityCounter | Where-Object { $_.DeviceId -Eq 0; } | Select-Object -ExpandProperty "Temperature" -EA:0;


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "powershell - How to get an object's property's value by property name? - Stack Overflow"  |  https://stackoverflow.com/a/14406385
#
#   stackoverflow.com  |  "SMART Hard Drive INFO Powershell - Stack Overflow"  |  https://stackoverflow.com/a/59675800
#
# ------------------------------------------------------------