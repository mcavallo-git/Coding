# ------------------------------------------------------------
# PowerShell - String.Substring(idx,idx) (remove, slice, split, truncate substrings using start and end char positions)
# ------------------------------------------------------------
#
# Split a string
#

# String.Substring(start);         <# The substring starts at a specified character position and continues to the end of the string
"12345678".Substring(3);  # Returns "45678" #>

# String.Substring(start,length);  <# The substring starts at a specified character position and has a specified length
"12345678".Substring(3,3);  <# Returns "456" #>


# ------------------------------------------------------------
#
# Remove a substring  (slice/trunctate)
#

"Hello World!" -replace " World","";     <# Returns "Hello!"  -  Remove substring #>

"Hello World!" -replace " World";        <# Returns "Hello!"  -  Remove substring (second arg not required for -replace to slice) #>


# ------------------------------------------------------------
#
# Citation(s)
#
#   devblogs.microsoft.com  |  "PowerTip: Remove First Two Letters of String | Scripting Blog"  |  https://devblogs.microsoft.com/scripting/powertip-remove-first-two-letters-of-string/
#
#   learn.microsoft.com  |  "Get-Date (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date
#
#   learn.microsoft.com  |  "String.Substring Method (System) | Microsoft Learn"  |  https://learn.microsoft.com/en-us/dotnet/api/system.string.substring
#
# ------------------------------------------------------------