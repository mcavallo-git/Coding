# ------------------------------------------------------------
#
# PowerShell - Get Decimal/Hexadecimal character code for a given character
#
# ------------------------------------------------------------


$UnicodeChar="❖";
Write-Host "Character [ ${UnicodeChar} ]"
$DecimalCode=([Int][Char]${UnicodeChar});
'{0:x}' -f ([Int][Char]${UnicodeChar});


# ------------------------------------------------------------
#
# Citation(s)
#
#   community.idera.com  |  "Converting ASCII and Characters - Power Tips - Power Tips - IDERA Community"  |  https://community.idera.com/database-tools/powershell/powertips/b/tips/posts/converting-ascii-and-characters
#
# ------------------------------------------------------------