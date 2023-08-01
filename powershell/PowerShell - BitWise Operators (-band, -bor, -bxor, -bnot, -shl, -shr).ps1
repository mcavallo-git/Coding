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
#
# Citation(s)
#
#   learn.microsoft.com  |  "about Arithmetic Operators - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arithmetic_operators?view=powershell-7.3#bitwise-operators
#
# ------------------------------------------------------------