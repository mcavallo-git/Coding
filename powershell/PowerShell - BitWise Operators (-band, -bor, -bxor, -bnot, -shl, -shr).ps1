# ------------------------------------------------------------
# PowerShell - BitWise Operators (-band, -bor, -bxor, -bnot, -shl, -shr)
# ------------------------------------------------------------

<# Operator     Description                  Expression     Result    #>

<# ------------------------------------------------------------------ #>

<# -band        Bitwise AND              #>  10 -band 3   <#     2    #>

<# -bor         Bitwise OR (inclusive)   #>  10 -bor 3    <#    11    #>

<# -bxor        Bitwise OR (exclusive)   #>  10 -bxor 3   <#     9    #>

<# -bnot        Bitwise NOT              #>  -bNot 10     <#   -11    #>

<# -shl         Shift-left               #>  102 -shl 2   <#   408    #>

<# -shr         Shift-right              #>  102 -shr 1   <#    51    #>



# ------------------------------------------------------------

For ($IntVal = 0; $IntVal -LT 60; $IntVal++) {
  # Remove any potential dangling undesired bitwise values off the right side of each value (make sure no multiples of '0x4' are in any values - Used for "Capabilities" trimming to remove items from the "remove/eject device" list in Windows)
  $HexVal = ("0x$('{0:x}' -f ([Int][Char]${IntVal}))");
  $BitwiseAnd = (${IntVal} -band 0x4);  # The Bitwise AND will be zero if the value doesn't include the value to remove (0x4)
  $TrimmedVal = (${IntVal} - ${BitwiseAnd});
  $TrimmedHexVal = ("0x$('{0:x}' -f ([Int][Char]${TrimmedVal}))");
  Write-Host "`$HexVal = [ $("${HexVal}".PadLeft(4,' ')) ]    -    `$BitwiseAnd = [ $("${BitwiseAnd}".PadLeft(4,' ')) ]    -    `$Trimmed = [ $("${TrimmedHexVal}".PadLeft(4,' ')) ]";
}

# ------------------------------------------------------------
#
# Citation(s)
#
#   learn.microsoft.com  |  "about Arithmetic Operators - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arithmetic_operators?view=powershell-7.3#bitwise-operators
#
# ------------------------------------------------------------