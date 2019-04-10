# --------------------------------------------------------------------------------------------------------------------------------------
#
# Decimal --> Hexadecimal

$Value_Base10 = (Get-Date ((Get-Date).ToUniversalTime()) -UFormat "%y%m%d%H%M%S");
$Value_Base16 = [Convert]::ToString($Value_Base10, 16);
Write-Host "`n`n Value in Base-10: $Value_Base10 `n`n Value in Base-16: $Value_Base16 `n`n";



# --------------------------------------------------------------------------------------------------------------------------------------
#
# Hexadecimal --> Decimal

$Value_Base16 = "0x061000";
$Value_Base10 = [Convert]::ToString($Value_Base16, 10);
Write-Host "`n`n Value in Base-16: $Value_Base16 `n`n Value in Base-10: $Value_Base10 `n`n";



# --------------------------------------------------------------------------------------------------------------------------------------
#
#		Citation(s)
#			"Convert decimal to hex and binary in Powershell"
#			https://soykablog.wordpress.com/2012/08/22/three-ways-to-convert-decimal-to-hex-in-powershell/
#		
# --------------------------------------------------------------------------------------------------------------------------------------
