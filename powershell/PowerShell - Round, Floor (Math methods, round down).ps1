# ------------------------------------------------------------
# 
# PowerShell - Using the "[Math]::Floor(...)" method
# 
# ------------------------------------------------------------
#
# ⚠️ Note: Rounding rounds DOWN 0.5 in many instances (unless "MidpointRounding" is specified, which forces a "normal" (non-banker's) method of rounding to be used)
#

# Rounding --> Example 1

[Math]::Round(0.5);
# Returns:  0  (❌️ incorrect rounding)

[Math]::Round(0.5, [System.MidpointRounding]::AwayFromZero );
# Returns:  1  (✔️ correct rounding)


# Rounding --> Example 2

@( 6.28 , 6.16 , 6.32 , 6.06 ) | Measure-Object -Average | Select-Object -ExpandProperty "Average";
# Returns:  6.205  (unrounded average)

@( 6.28 , 6.16 , 6.32 , 6.06 ) | Measure-Object -Average | Select-Object -ExpandProperty "Average" | ForEach-Object  { [Math]::Round(${_}, 2) };
# Returns:  6.20   (❌️ incorrect rounding to 2 decimal places)

@( 6.28 , 6.16 , 6.32 , 6.06 ) | Measure-Object -Average | Select-Object -ExpandProperty "Average" | ForEach-Object  { [Math]::Round(${_}, 2, [System.MidpointRounding]::AwayFromZero ) };
# Returns:  6.21   (✔️ correct rounding to 2 decimal places)


# ⚠️ Note: The shorthand value of [ 1 ] can be used in place of [ [System.MidpointRounding]::AwayFromZero ], but then all 3 arguments must be specified as follows:

[Math]::Round(0.5, 0, 1 );
# Returns:  1  (✔️ correct rounding)


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
#   community.spiceworks.com  |  "[SOLVED] Quirky Powershell [math]::round behavior"  |  https://community.spiceworks.com/topic/2322603-quirky-powershell-math-round-behavior#entry-9205146
#
#   learn.microsoft.com  |  "Get-Date (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date
#
#   learn.microsoft.com  |  "Math.Floor Method (System) | Microsoft Learn"  |  https://learn.microsoft.com/en-us/dotnet/api/system.math.floor
#
#   learn.microsoft.com  |  "Math.Round Method (System) | Microsoft Learn"  |  https://learn.microsoft.com/en-us/dotnet/api/system.math.round
#
#   stackoverflow.com  |  "Midnight last Monday in Powershell"  |  https://stackoverflow.com/a/42578179
#
#   stackoverflow.com  |  "Powershell - Round down to nearest whole number - Stack Overflow"  |  https://stackoverflow.com/a/5864061
#
#   stackoverflow.com  |  "Powershell Data Types - PowerShell - SS64.com"  |  https://ss64.com/ps/syntax-datatypes.html
#
# ------------------------------------------------------------