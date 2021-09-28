# ------------------------------------------------------------
#
# PowerShell - Get-Alias
#
# ------------------------------------------------------------


$AliasLookup="Get-ChildItem"; `
Get-Alias | Where-Object {($_.ResolvedCommandName -Like "*${AliasLookup}*") -Or ($_.ResolvedCommand -Like "*${AliasLookup}*") -Or ($_.ReferencedCommand -Like "*${AliasLookup}*") -Or ($_.Definition -Like "*${AliasLookup}*") -Or ($_.Name -Like "*${AliasLookup}*");};


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-Alias (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-alias?view=powershell-7.1
#
# ------------------------------------------------------------