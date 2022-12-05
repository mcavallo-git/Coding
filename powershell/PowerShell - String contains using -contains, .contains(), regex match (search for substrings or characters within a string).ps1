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
# Matching operators
#

<string[]> -like    <wildcard-expression>

<string[]> -notlike <wildcard-expression>

<string[]> -match    <regular-expression>

<string[]> -notmatch <regular-expression>


# ------------------------------------------------------------
#
# Citation(s)
#
#   devblogs.microsoft.com  |  "PowerTip: Finding Letters in Strings with PowerShell | Scripting Blog"  |  https://devblogs.microsoft.com/scripting/powertip-finding-letters-in-strings-with-powershell/
#
#   learn.microsoft.com  |  "about Comparison Operators - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-7.3#matching-operators
#
# ------------------------------------------------------------