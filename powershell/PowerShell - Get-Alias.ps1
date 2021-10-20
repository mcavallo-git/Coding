# ------------------------------------------------------------
#
# PowerShell - Get-Alias
#
# ------------------------------------------------------------


$AliasLookup="Get-Command";  <# Lookup Aliases #>  Get-Alias | Where-Object {($_.ResolvedCommandName -Like "*${AliasLookup}*") -Or ($_.ResolvedCommand -Like "*${AliasLookup}*") -Or ($_.ReferencedCommand -Like "*${AliasLookup}*") -Or ($_.Definition -Like "*${AliasLookup}*") -Or ($_.Name -Like "*${AliasLookup}*");};


$AliasLookup="Get-ChildItem";  <# Lookup Aliases #>  Get-Alias | Where-Object {($_.ResolvedCommandName -Like "*${AliasLookup}*") -Or ($_.ResolvedCommand -Like "*${AliasLookup}*") -Or ($_.ReferencedCommand -Like "*${AliasLookup}*") -Or ($_.Definition -Like "*${AliasLookup}*") -Or ($_.Name -Like "*${AliasLookup}*");};


$AliasLookup="Write-Output";  <# Lookup Aliases #>  Get-Alias | Where-Object {($_.ResolvedCommandName -Like "*${AliasLookup}*") -Or ($_.ResolvedCommand -Like "*${AliasLookup}*") -Or ($_.ReferencedCommand -Like "*${AliasLookup}*") -Or ($_.Definition -Like "*${AliasLookup}*") -Or ($_.Name -Like "*${AliasLookup}*");};



$AliasLookup="Select-Object";  <# Lookup Aliases #>  Get-Alias | Where-Object {($_.ResolvedCommandName -Like "*${AliasLookup}*") -Or ($_.ResolvedCommand -Like "*${AliasLookup}*") -Or ($_.ReferencedCommand -Like "*${AliasLookup}*") -Or ($_.Definition -Like "*${AliasLookup}*") -Or ($_.Name -Like "*${AliasLookup}*");};


$AliasLookup="Where-Object";  <# Lookup Aliases #>  Get-Alias | Where-Object {($_.ResolvedCommandName -Like "*${AliasLookup}*") -Or ($_.ResolvedCommand -Like "*${AliasLookup}*") -Or ($_.ReferencedCommand -Like "*${AliasLookup}*") -Or ($_.Definition -Like "*${AliasLookup}*") -Or ($_.Name -Like "*${AliasLookup}*");};


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-Alias (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-alias?view=powershell-7.1
#
# ------------------------------------------------------------