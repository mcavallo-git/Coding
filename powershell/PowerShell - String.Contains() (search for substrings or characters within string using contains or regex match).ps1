# ------------------------------------------------------------
#
# PowerTip: Finding Letters in Strings with PowerShell
#
# ------------------------------------------------------------
#
# Summary: Learn 4 ways to use Windows PowerShell to find letters in strings
#
 
$a="northern hairy-nosed wombat";
 
[string]$a.contains("m");
$a.contains("m");
[regex]::match($a,"m");
([regex]::match($a,"m")).success;


# ------------------------------------------------------------
#
# Citation(s)
#
#   devblogs.microsoft.com  |  "PowerTip: Finding Letters in Strings with PowerShell | Scripting Blog"  |  https://devblogs.microsoft.com/scripting/powertip-finding-letters-in-strings-with-powershell/
#
# ------------------------------------------------------------