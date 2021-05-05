# ------------------------------------------------------------
#
# "String".Substring(START,END);
#
# ------------------------------------------------------------

$EpochDate = ([Decimal](Get-Date -UFormat ("%s"))); `
$DecimalTimestampShort = ( ([String](Get-Date -Date ("${EpochToDateTime}") -UFormat ("%Y%m%d-%H%M%S"))) + (([String]((${EpochDate}%1))).Substring(1).PadRight(6,"0")) ); `


# ------------------------------------------------------------
#
# Citation(s)
#
#		devblogs.microsoft.com  |  "PowerTip: Remove First Two Letters of String | Scripting Blog"  |  https://devblogs.microsoft.com/scripting/powertip-remove-first-two-letters-of-string/
#
#		docs.microsoft.com  |  "Get-Date - Gets the current date and time"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date
#
#		docs.microsoft.com  |  "String.Substring Method - Retrieves a substring from this instance"  |  https://docs.microsoft.com/en-us/dotnet/api/system.string.substring?view=netcore-3.1
#
# ------------------------------------------------------------