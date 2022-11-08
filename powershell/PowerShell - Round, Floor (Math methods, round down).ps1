# ------------------------------------------------------------
# 
# PowerShell - Using the "[Math]::Floor(...)" method
# 
# ------------------------------------------------------------


[Int32](Get-Date -UFormat "%s"); <# Rounds up if decimal component is above 0.5 #>

[Math]::Round((Get-Date -UFormat "%s"),3);  <# Rounds to nearest millisecond #>

[Math]::Floor((Get-Date -UFormat "%s")); <# Rounds up if decimal component is above 0.5 #>


# ------------------------------------------------------------
#
# PowerShell Numeric Data-Types
#  |--> For insight into numeric precision for applications without being wasteful regarding system resources)
#
#
#   [int]       32-bit signed integer
#   [long]      64-bit signed integer
#   [decimal]   A 128-bit decimal value
#   [single]    Single-precision 32-bit floating point number
#   [double]    Double-precision 64-bit floating point number
#
#
# ------------------------------------------------------------
#
# Citation(s)
#
#		docs.microsoft.com  |  "Get-Date - Gets the current date and time."  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date
#
#		docs.microsoft.com  |  "Math.Floor Method (System) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.math.floor
#
#		stackoverflow.com  |  "Powershell Data Types - PowerShell - SS64.com"  |  https://ss64.com/ps/syntax-datatypes.html
#
#		stackoverflow.com  |  "Midnight last Monday in Powershell"  |  https://stackoverflow.com/a/42578179
#
#		stackoverflow.com  |  "Powershell - Round down to nearest whole number - Stack Overflow"  |  https://stackoverflow.com/a/5864061
#
# ------------------------------------------------------------