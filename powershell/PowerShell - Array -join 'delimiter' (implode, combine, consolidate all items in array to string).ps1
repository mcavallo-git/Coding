
$Arr = @();
$Arr += "AAA";
$Arr += "222";
$Arr += "!!!";

Write-Host ($Arr); <# Normal array view (not imploded #>

Write-Host ($Arr -join ';'); <# Imploded array (string of string which are delimited by the delimiter given as the argument to the right-of "-join" #>


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "How do I convert an array object to a string in PowerShell? - Stack Overflow"  |  https://stackoverflow.com/a/7723859
#
# ------------------------------------------------------------