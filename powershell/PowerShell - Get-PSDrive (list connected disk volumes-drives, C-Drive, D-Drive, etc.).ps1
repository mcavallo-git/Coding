# ------------------------------------------------------------
#
# PowerShell - Get-PSDrive (list connected disk volumes-drives, C-Drive, D-Drive, etc.)
#
# ------------------------------------------------------------

# Get all Filesystem drives in the current session
Get-PSDrive -PSProvider "FileSystem" | Select-Object -Property "Root";


# Get all Filesystem drives matching syntax "A:\" (for all letters) in the current session
Get-PSDrive -PSProvider "FileSystem" | Where-Object { [Regex]::Match(${_}.Root,'^[a-zA-Z]:\\$').Success -Eq $True; } | Select-Object -Property "Root";



# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-PSDrive (Microsoft.PowerShell.Management) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-psdrive
#
# ------------------------------------------------------------