# ------------------------------
#	PowerShell - String.Trim()
# ------------------------------

Write-Output "   123   ";  # Returns "   123   "

Write-Output "   123   ".Trim();  # Returns "123"

Write-Output "   123   ".Trim(" ");  # Returns "123"

Write-Output "   123   ".Trim(" ","1");  # Returns "23"

Write-Output "   123   ".Trim(" ","1","3");  # Returns "2"

Write-Output "   123   ".Trim(" ","1","2");  # Returns "3"


# ------------------------------------------------------------
#
# Citation(s)
#
#   learn.microsoft.com  |  "String.Trim Method (System) | Microsoft Learn"  |  https://learn.microsoft.com/en-us/dotnet/api/system.string.trim?view=netframework-4.5
#
# ------------------------------------------------------------