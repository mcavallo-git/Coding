# ------------------------------------------------------------
# PowerShell - Get-FileHash (get md5 checksum for a given string, convert to GUID)
# ------------------------------------------------------------

# Get the md5 checksum for a given string

(Get-FileHash -Algorithm ("MD5") -InputStream ([System.IO.MemoryStream]::New([System.Text.Encoding]::ASCII.GetBytes("tester")))).Hash;


# ------------------------------------------------------------

# Get the md5 checksum for a given string - convert to GUID format

(Get-FileHash -Algorithm ("MD5") -InputStream ([System.IO.MemoryStream]::New([System.Text.Encoding]::ASCII.GetBytes("tester")))).Hash -replace '([0-9A-F]{8})([0-9A-F]{4})([0-9A-F]{4})([0-9A-F]{4})([0-9A-F]{12})','$1-$2-$3-$4-$5';


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-Alias (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-alias?view=powershell-7.1
#
# ------------------------------------------------------------