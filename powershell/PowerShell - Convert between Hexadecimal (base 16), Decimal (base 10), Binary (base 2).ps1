# ------------------------------------------------------------
#
#   Decimal (base 10)  -->  Hexadecimal (base 16)
#


# DEC TO HEX
$Value_Base10 = (Get-Date ((Get-Date).ToUniversalTime()) -UFormat "%y%m%d%H%M%S");
$Value_Base16 = (("0x")+([Convert]::ToString($Value_Base10, 16)));
Write-Host "`n`n Value in Base-10: $Value_Base10 `n`n Value in Base-16: $Value_Base16 `n`n";


# ------------------------------------------------------------
#
#   Hexadecimal (base 16)  -->  Decimal (base 10)
#


# HEX TO DEC
$Value_Base16 = "0x061000";
$Value_Base10 = [Convert]::ToString($Value_Base16, 10);
Write-Host "`n`n Value in Base-16: $Value_Base16 `n`n Value in Base-10: $Value_Base10 `n`n";


# ------------------------------------------------------------
#
#   Decimal (base 10)  -->  Binary (base 2)
#


# DEC TO BIN
[Convert]::ToString(129, 2);


# ------------------------------------------------------------
#
# Citation(s)
#
#   soykablog.wordpress.com  |  "Convert decimal to hex and binary in Powershell | Soyka's Blog"  |  https://soykablog.wordpress.com/2012/08/22/three-ways-to-convert-decimal-to-hex-in-powershell/
#
# ------------------------------------------------------------