# ------------------------------------------------------------
#
# Test whether a PowerShell variable is set ("isset") (or not)
#

# Syntax:
If (Test-Path -Path ("Variable:\Tester")) { Write-Host "Variable `$Tester IS set" -ForegroundColor "Green"; } Else { Write-Host "Variable `$Tester is NOT set" -ForegroundColor "Yellow"; };


# Example (var IS set):
$VarName="Tester"; Set-Variable -Name "${VarName}"; If (Test-Path -Path ("Variable:\${VarName}")) { Write-Host "Variable `$${VarName} IS set" -ForegroundColor "Green"; } Else { Write-Host "Variable `$${VarName} is NOT set" -ForegroundColor "Yellow"; };


# Example (var NOT set):
$VarName="Tester"; Set-Variable -Name "${VarName}"; Remove-Variable -Name "${VarName}"; If (Test-Path -Path ("Variable:\${VarName}")) { Write-Host "Variable `$${VarName} IS set" -ForegroundColor "Green"; } Else { Write-Host "Variable `$${VarName} is NOT set" -ForegroundColor "Yellow"; };


# ------------------------------------------------------------
#
# Test whether ENVIRONMENT variables are set (or not)
#


If (Test-Path -Path ("Env:WORKSPACE") -PathType ("Leaf")) { <# Variable IS set (but may be empty) #>
	Write-Host "Environment Variable `"`${Env:WORKSPACE}`" is set with value `"${Env:WORKSPACE}`"" -ForegroundColor ("Green") -BackgroundColor ("Black");
} Else { <# Variable is NOT set #>
	Write-Host "Environment Variable `"`${Env:WORKSPACE}`" is set with value `"${Env:WORKSPACE}`"" -ForegroundColor ("Red") -BackgroundColor ("Black");
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Remove-Variable (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/remove-variable
#
#   docs.microsoft.com  |  "Set-Variable (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/set-variable
#
#   mcpmag.com  |  "How To Test Variables in PowerShell -- Microsoft Certified Professional Magazine Online"  |  https://mcpmag.com/articles/2015/12/14/test-variables-in-powershell.aspx
#
# ------------------------------------------------------------