# ------------------------------------------------------------
#
# PowerShell
# 	|
# 	|--> String replace via .Replace()   !!!  CASE SENSITIVE  !!!
# 	|
# 	|--> String replace via -Replace     !!!  CASE IN-SENSITIVE  !!!  (uses regex-matching)
#
# ------------------------------------------------------------


"Hello City!".Replace("City","World");   <# Returns "Hello World!" #>

"Hello City!" -Replace "city","World");  <# Returns "Hello World!" #>


'00:00:00' -replace "^([-+]?)(\d+):(\d+):(\d+)$",'[$1] [$2] [$3] [$4]';   <# Returns "[] [00] [00] [00]" #>

'-05:00:00' -replace "^([-+]?)(\d+):(\d+):(\d+)$",'[$1] [$2] [$3] [$4]';   <# Returns "[-] [05] [00] [00]" #>

'+13:45:00' -replace "^([-+]?)(\d+):(\d+):(\d+)$",'[$1] [$2] [$3] [$4]';   <# Returns "[+] [13] [45] [00]" #>

$TZ_MinutesOffset=$(([String](Get-TimeZone).BaseUtcOffset) -replace "^([-+]?)(\d+):(\d+):(\d+)$",':$3'); <# Returns ":00" (minutes offset for current system's timezone) #>


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "about_Comparison_Operators - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-5.1#replacement-operator
#
#   powershell.org  |  "Regular Expressions are a -replace's best friend – PowerShell.org"  |  https://powershell.org/2013/08/regular-expressions-are-a-replaces-best-friend/
#
# ------------------------------------------------------------