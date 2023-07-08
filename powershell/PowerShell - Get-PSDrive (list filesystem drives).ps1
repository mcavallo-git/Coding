# ------------------------------------------------------------
#
# PowerShell - Get-PSDrive (list filesystem drives).ps1
#
# ------------------------------------------------------------

# Get all Filesystem drive roots in the current session
Get-PSDrive -PSProvider "FileSystem" | Select-Object -ExpandProperty "Root";

# Get all Filesystem drives matching syntax "A:\" (for all letters) in the current session
Get-PSDrive -PSProvider "FileSystem" | Where-Object { [Regex]::Match(${_}.Root,'^[a-zA-Z]:\\$').Success -Eq $True; } | Select-Object -Property "Root";
# ^
# ^-- !! USE [ Get-Volume ], INSTEAD!


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-PSDrive (Microsoft.PowerShell.Management) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-psdrive
#
# ------------------------------------------------------------