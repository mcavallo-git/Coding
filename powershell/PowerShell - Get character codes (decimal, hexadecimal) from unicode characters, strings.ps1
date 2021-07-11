# ------------------------------------------------------------
#
# PowerShell - Get Decimal/Hexadecimal character code for a given character
#
# ------------------------------------------------------------

If ($True) {

# $Input="❖";
$Input="👍";
# $Input="👍🏽";
# $Input = Read-Host -Prompt 'Enter string/character to get character codes for';

Add-Type -AssemblyName ("System.Web");  # Adds [System.Net.WebUtility] Class

$Character=@{};

$Character.("Characters")=("${Input}".ToCharArray());
$Character.("HTML Entity (Decimal)")=@();
$Character.("HTML Entity (Hex)")=@();
$Character.("HtmlEncode")=([System.Net.WebUtility]::HtmlEncode("${Input}"));
$Character.("UTF-16 Code (Decimal)")=@();
$Character.("UTF-16 Code (Hex)")=@();

("${Input}".ToCharArray()) | ForEach-Object {
	$EachChar="${_}";
	$Character.("HTML Entity (Decimal)") += ("&#$([Int][Char]${EachChar})");
	$Character.("HTML Entity (Hex)") += ("&#x$('{0:x}' -f ([Int][Char]${EachChar}))");
	$Character.("UTF-16 Code (Decimal)") += ([Int][Char]${EachChar});
	$Character.("UTF-16 Code (Hex)") += ("0x$('{0:x}' -f ([Int][Char]${EachChar}))");
}

Write-Output ($Character);

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   community.idera.com  |  "Converting ASCII and Characters - Power Tips - Power Tips - IDERA Community"  |  https://community.idera.com/database-tools/powershell/powertips/b/tips/posts/converting-ascii-and-characters
#
#   docs.microsoft.com  |  "WebUtility Class (System.Net) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.net.webutility?view=net-5.0
#
#   stackoverflow.com  |  "What is the best way to escape HTML-specific characters in a string (PowerShell)? - Stack Overflow"  |  https://stackoverflow.com/a/48762484
#
#   www.fileformat.info  |  "Unicode Character 'BLACK DIAMOND MINUS WHITE X' (U+2756)"  |  https://www.fileformat.info/info/unicode/char/2756/index.htm
#
# ------------------------------------------------------------