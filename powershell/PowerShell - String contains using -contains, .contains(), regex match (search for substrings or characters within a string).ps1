# ------------------------------------------------------------
#
# PowerTip: Finding Letters in Strings with PowerShell
#
# ------------------------------------------------------------
#
# Summary: Learn 4 ways to use Windows PowerShell to find letters in strings
#


"A".contains("a");   <# Returns False   (case SENSITIVE) #>


"A" -contains "a";   <# Returns True    (case IN-sensitive) #>


(([regex]::match("SOME LONG STRING","long")).success);   <# Returns False   (case SENSITIVE) #>


# ------------------------------------------------------------
#
# Citation(s)
#
#   devblogs.microsoft.com  |  "PowerTip: Finding Letters in Strings with PowerShell | Scripting Blog"  |  https://devblogs.microsoft.com/scripting/powertip-finding-letters-in-strings-with-powershell/
#
# ------------------------------------------------------------