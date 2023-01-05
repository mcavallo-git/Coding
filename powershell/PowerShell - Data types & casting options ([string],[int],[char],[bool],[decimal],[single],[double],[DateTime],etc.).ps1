# ------------------------------------------------------------
#
# PowerShell - Data types & casting options ([string],[int],[char],[bool],[decimal],[single],[double],[DateTime],etc.)
#  |
#  |--> For insight into numeric precision for applications without being wasteful regarding system resources)
#
# ------------------------------------------------------------
#
#   [string]    Fixed-length string of Unicode characters
#   [char]      A Unicode 16-bit character
#   [byte]      An 8-bit unsigned character
#
#   [int]       32-bit signed integer
#   [long]      64-bit signed integer
#   [bool]      Boolean True/False value
#
#   [decimal]   A 128-bit decimal value
#   [single]    Single-precision 32-bit floating point number
#   [double]    Double-precision 64-bit floating point number
#   [DateTime]  Date and Time
#
# ------------------------------
#
#  Integer data types (determine bounds)
#

Write-Host "[short]:`nMin=[$([short]::MinValue)],`nMax=[$([short]::MaxValue)]`n";
Write-Host "[int16]:`nMin=[$([int16]::MinValue)],`nMax=[$([int16]::MaxValue)]`n";


Write-Host "[ushort]:`nMin=[$([ushort]::MinValue)],`nMax=[$([ushort]::MaxValue)]`n";
Write-Host "[uint16]:`nMin=[$([uint16]::MinValue)],`nMax=[$([uint16]::MaxValue)]`n";


Write-Host "[int]:`nMin=[$([int]::MinValue)],`nMax=[$([int]::MaxValue)]`n";
Write-Host "[int32]:`nMin=[$([int32]::MinValue)],`nMax=[$([int32]::MaxValue)]`n";


Write-Host "[uint]:`nMin=[$([uint]::MinValue)],`nMax=[$([uint]::MaxValue)]`n";
Write-Host "[uint32]:`nMin=[$([uint32]::MinValue)],`nMax=[$([uint32]::MaxValue)]`n";


Write-Host "[long]:`nMin=[$([long]::MinValue)],`nMax=[$([long]::MaxValue)]`n";
Write-Host "[int64]:`nMin=[$([int64]::MinValue)],`nMax=[$([int64]::MaxValue)]`n";


Write-Host "[ulong]:`nMin=[$([ulong]::MinValue)],`nMax=[$([ulong]::MaxValue)]`n";
Write-Host "[uint64]:`nMin=[$([uint64]::MinValue)],`nMax=[$([uint64]::MaxValue)]`n";


# ------------------------------
#
#  Decimal data types (determine bounds)
#

Write-Host "[decimal]:`nMin=[$([decimal]::MinValue)],`nMax=[$([decimal]::MaxValue)]`n";


Write-Host "[single]:`nMin=[$([single]::MinValue)],`nMax=[$([single]::MaxValue)]`n";
Write-Host "[float]:`nMin=[$([float]::MinValue)],`nMax=[$([float]::MaxValue)]`n";


Write-Host "[double]:`nMin=[$([double]::MinValue)],`nMax=[$([double]::MaxValue)]`n";


# ------------------------------------------------------------
#
# Citation(s)
#
#   devblogs.microsoft.com  |  "Understanding Numbers in PowerShell - Scripting Blog"  |  https://devblogs.microsoft.com/scripting/understanding-numbers-in-powershell/
#
#   docs.microsoft.com  |  "Get-Date - Gets the current date and time."  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date
#
#   docs.microsoft.com  |  "Math.Floor Method (System) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.math.floor
#
#   docs.microsoft.com  |  "Types - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/scripting/lang-spec/chapter-04?view=powershell-7.2
#
#   stackoverflow.com  |  "Powershell Data Types - PowerShell - SS64.com"  |  https://ss64.com/ps/syntax-datatypes.html
#
#   stackoverflow.com  |  "Midnight last Monday in Powershell"  |  https://stackoverflow.com/a/42578179
#
#   stackoverflow.com  |  "Powershell - Round down to nearest whole number - Stack Overflow"  |  https://stackoverflow.com/a/5864061
#
# ------------------------------------------------------------