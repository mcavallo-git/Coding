# ------------------------------------------------------------
#
#	PowerShell - Where-Object { ... }   (shorthand syntax "? {...}")

# ------------------------------------------------------------


# Regular Syntax using [ ... | Where-Object {... ]
Get-Service | Where-Object { $_.Status -eq "Running" };


# Shorthand Syntax using [ ... | ? {... ]
Get-Service | ? { $_.Status -eq "Running" };


# ------------------------------------------------------------
#
#		Example
#			|--> Filtering a set of result hashtables, arrays, etc. using 'like' or 'notlike' matching)
#

Get-Process `
| Where-Object { $_.ProcessName -Like "*PowerShell*" } `
| Foreach-Object { Write-Host ('-'*60); $_ | Format-List; Write-Host ('='*60); } `
;


# ------------------------------------------------------------
#
#		Example
#			|--> Determine if WSL is enabled (or not)
#
$WSL_State = ((Get-WindowsOptionalFeature -Online | Where-Object { $_.FeatureName -Like "*Linux*" }).State); Write-Output "`$WSL_State = [ $WSL_State ]";


# ------------------------------------------------------------
#
#	Citation(s)
#
#		docs.microsoft.com  |  "Get-Process"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-process?view=powershell-6#notes
#
# ------------------------------------------------------------
