# ------------------------------------------------------------
#
#  "String".Substring(startIndex);         <# The substring starts at a specified character position and continues to the end of the string #>
#
#  "String".Substring(startIndex,length);  <# The substring starts at a specified character position and has a specified length #>
#
# ------------------------------------------------------------
#
# Substring(startIndex)
#  |
#  |--> https://docs.microsoft.com/en-us/dotnet/api/system.string.substring#System_String_Substring_System_Int32_
#

$StartIndex=3;  "12345678".Substring(${StartIndex});  # Returns "45678"


# ------------------------------
#
# Substring(startIndex, length)
#  |
#  |--> https://docs.microsoft.com/en-us/dotnet/api/system.string.substring#System_String_Substring_System_Int32_System_Int32_
#

$StartIndex=3;  $Length=3;  "12345678".Substring(${StartIndex}, ${Length});  # Returns "456"


# ------------------------------------------------------------
#
# Citation(s)
#
#		devblogs.microsoft.com  |  "PowerTip: Remove First Two Letters of String | Scripting Blog"  |  https://devblogs.microsoft.com/scripting/powertip-remove-first-two-letters-of-string/
#
#		docs.microsoft.com  |  "Get-Date - Gets the current date and time"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date
#
#		docs.microsoft.com  |  "String.Substring Method - Retrieves a substring from this instance"  |  https://docs.microsoft.com/en-us/dotnet/api/system.string.substring?view=netcore-3.1
#
# ------------------------------------------------------------