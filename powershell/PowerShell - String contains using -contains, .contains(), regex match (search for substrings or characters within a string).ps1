# ------------------------------------------------------------
#
# PowerTip: Finding Letters in Strings with PowerShell
#
# ------------------------------------------------------------
#
# Summary: Learn 4 ways to use Windows PowerShell to find letters in strings
#


"A".contains("a");   <# False (case SENSITIVE) #>


"A" -contains "a";   <# True  (case IN-sensitive) #>


"A" -like "*a*";     <# True  #>


(([regex]::match("SOME LONG STRING","long")).success);   <# False (case SENSITIVE) #>


# ------------------------------------------------------------
#
# Matching operators  -  like/notlike
#

# Syntax:
#    <string[]> -like <wildcard-expression>
#    <string[]> -notlike <wildcard-expression>


# Ex (-like):
"Example" -like "Ex";   <# False #>
"Example" -like "Ex*";  <# True  #>


# Ex (-notlike):
"Example" -notlike "Ex";   <# True  #>
"Example" -notlike "Ex*";  <# False #>


# ------------------------------------------------------------
#
# Matching operators  -  match/notmatch
#


# Syntax:
#    <string[]> -match    <regular-expression>
#    <string[]> -notmatch <regular-expression>


# Ex (-match):
"Example" -match "Ex";   <# True  #>
"Example" -match "^Ex";  <# True  #>
"Example" -match "Ex$";  <# False #>

# Ex (-notmatch):
"Example" -notmatch "Ex";   <# False #>
"Example" -notmatch "^Ex";  <# False #>
"Example" -notmatch "Ex$";  <# True  #>


# ------------------------------------------------------------
#
# Citation(s)
#
#   devblogs.microsoft.com  |  "PowerTip: Finding Letters in Strings with PowerShell | Scripting Blog"  |  https://devblogs.microsoft.com/scripting/powertip-finding-letters-in-strings-with-powershell/
#
#   learn.microsoft.com  |  "about Comparison Operators - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-7.3#matching-operators
#
# ------------------------------------------------------------