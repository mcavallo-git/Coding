# ------------------------------------------------------------
#
# PowerShell - Get Decimal/Hexadecimal character code for a given character
#
# ------------------------------------------------------------

If ($True) {

$Input="👍🏽";
# $Input="👍";
# $Input="❖";
# $Input=[Char](10);  # LF (NL line feed, new line)
# $Input=[Char](13);  # CR (carriage return)
# $Input = Read-Host -Prompt 'Enter string/character to get character codes for';

# Check if we need to add a prerequisite assembly (e.g. a Microsoft .NET class) to this PowerShell session
$Assembly=@{ Class="System.Net.WebUtility"; Namespace="System.Web"; Method="HtmlEncode"; };
$Local_Assemblies=([System.AppDomain]::CurrentDomain.GetAssemblies() | ForEach-Object { ${_}.GetTypes(); });
$Class_ExistsLocally=(${Local_Assemblies} | Where-Object { ${_}.FullName -Eq "$(${Assembly}.Class)"; });
If (-Not (${Class_ExistsLocally})) {
	Write-Host "Info:  Calling [ Add-Type `"$(${Assembly}.Namespace)`" ]  ( required to use method [$(${Assembly}.Class)]::$(${Assembly}.Method)(...) )...";
	Add-Type -AssemblyName ("$(${Assembly}.Namespace)");
}

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
#   docs.microsoft.com  |  "Add-Type (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/add-type?view=powershell-5.1
#
#   docs.microsoft.com  |  "WebUtility Class (System.Net) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.net.webutility?view=net-5.0
#
#   stackoverflow.com  |  "PowerShell - Check if .NET class exists - Stack Overflow"  |  https://stackoverflow.com/a/43648202
#
#   stackoverflow.com  |  "What is the best way to escape HTML-specific characters in a string (PowerShell)? - Stack Overflow"  |  https://stackoverflow.com/a/48762484
#
#   www.fileformat.info  |  "Unicode Character 'BLACK DIAMOND MINUS WHITE X' (U+2756)"  |  https://www.fileformat.info/info/unicode/char/2756/index.htm
#
# ------------------------------------------------------------