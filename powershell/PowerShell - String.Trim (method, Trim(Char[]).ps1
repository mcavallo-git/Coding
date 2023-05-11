# ------------------------------
#	PowerShell - String.Trim()
# ------------------------------

#
# String.Trim()  -  Spaces
#

Write-Output "   123   ";  # Returns "   123   "

Write-Output "   123   ".Trim();  # Returns "123"

Write-Output "   123   ".Trim(" ");  # Returns "123"


#
# String.Trim()  -  Specific Character(s)
#

Write-Output "   123   ".Trim(" ","1");  # Returns "23"

Write-Output "   123   ".Trim(" ","1","3");  # Returns "2"

Write-Output "   123   ".Trim(" ","1","2");  # Returns "3"


#
# Note:  String.Trim() will ONLY strip characters that are found on the left and/or right sides of the string
#         |--> e.g. Trim will NOT trim chars in the middle of a string (unless all chars to the left or right are also trimmed)
#

Write-Output "   123   ".Trim("1","2","3");  # Returns "   123   "


# ------------------------------------------------------------
#
# Citation(s)
#
#   learn.microsoft.com  |  "String.Trim Method (System) | Microsoft Learn"  |  https://learn.microsoft.com/en-us/dotnet/api/system.string.trim?view=netframework-4.5
#
# ------------------------------------------------------------