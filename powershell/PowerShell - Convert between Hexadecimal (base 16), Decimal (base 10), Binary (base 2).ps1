# ------------------------------------------------------------
#
#   Convert to:   Decimal (integer) (base 10)
#


#   HEX to DEC
0x000064;  # Method 1 - integers starting in [ 0x ] are converted from hex to dec, by default
[Convert]::ToInt32('0x000064',16);  # Method 2 (hex as a string instead of as an int32)
[Int]([Convert]::ToString(0x000064, 10));  # Method 3
[Int]([String]::Format('{0:d}', 0x000064));  # Method 4
[Int]('{0:d}' -f 0x000064);  # Method 5


# BIN to DEC
[Convert]::ToInt32('1100100',2);


# ------------------------------------------------------------
#
#   Convert to:   Hexadecimal (base 16)
#


# DEC to HEX
'{0:x}' -f 100;  # Method 1
[String]::Format('{0:x}', 100);  # Method 2
[Convert]::ToString(100, 16);  # Method 3


# BIN to HEX
[Convert]::ToString([Convert]::ToInt32('1100100',2), 16);  # Method 1
'{0:x}' -f [Convert]::ToInt32('1100100',2);  # Method 2
[String]::Format('{0:x}', [Convert]::ToInt32('1100100',2));  # Method 3


# ------------------------------------------------------------
#
#   Convert to:   Binary (base 2)
#


# DEC TO BIN
[Convert]::ToString(100, 2);


# HEX TO BIN
[Convert]::ToString(0x000064, 2);


# ------------------------------------------------------------
#
# Citation(s)
#
#   community.idera.com  |  "Converting Binary String to Integer - Power Tips - Power Tips - IDERA Community"  |  https://community.idera.com/database-tools/powershell/powertips/b/tips/posts/converting-binary-string-to-integer
#
#   docs.microsoft.com  |  "Convert.ToInt32 Method (System) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.convert.toint32
#
#   docs.microsoft.com  |  "Convert.ToString Method (System) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.convert.tostring
#
#   docs.microsoft.com  |  "about Numeric Literals - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_numeric_literals#numeric-type-accelerators
#
#   soykablog.wordpress.com  |  "Convert decimal to hex and binary in Powershell | Soyka's Blog"  |  https://soykablog.wordpress.com/2012/08/22/three-ways-to-convert-decimal-to-hex-in-powershell/
#
# ------------------------------------------------------------