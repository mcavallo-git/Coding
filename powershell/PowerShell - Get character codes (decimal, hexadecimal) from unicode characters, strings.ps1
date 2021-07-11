# ------------------------------------------------------------
#
# PowerShell - Get Decimal/Hexadecimal character code for a given character
#
# ------------------------------------------------------------

If ($True) {

$Input="❖";

$Character=@{};

$Character.("Character")=${Input};

$Character.("UTF-16 Code (Decimal)")=([Int][Char]${Input});
$Character.("UTF-16 Code (Hex)")=("0x$('{0:x}' -f ([Int][Char]${Input}))");

$Character.("HTML Entity (Decimal)")=("&#$([Int][Char]${Input})");
$Character.("HTML Entity (Hex)")=("&#x$('{0:x}' -f ([Int][Char]${Input}))");

Write-Output ($Character);

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   community.idera.com  |  "Converting ASCII and Characters - Power Tips - Power Tips - IDERA Community"  |  https://community.idera.com/database-tools/powershell/powertips/b/tips/posts/converting-ascii-and-characters
#
#   www.fileformat.info  |  "Unicode Character 'BLACK DIAMOND MINUS WHITE X' (U+2756)"  |  https://www.fileformat.info/info/unicode/char/2756/index.htm
#
# ------------------------------------------------------------