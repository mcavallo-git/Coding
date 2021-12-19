
$Arr = @();
$Arr += "AAA";
$Arr += "222";
$Arr += "!!!";

Write-Host ($Arr); <# Normal array view (not imploded #>

Write-Host ($Arr -join '`n`n'); <# Implode the array into a string using the delimiter specified after '-join' #>

# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "How do I convert an array object to a string in PowerShell? - Stack Overflow"  |  https://stackoverflow.com/a/7723859
#
# ------------------------------------------------------------