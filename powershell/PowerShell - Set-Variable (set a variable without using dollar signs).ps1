
<# Example - Set the variable [ $IsLinux ] #>

$SetVal = If($IsLinux -ne $null){$IsLinux} ElseIf((Test-Path "/bin") -And (-Not (Test-Path "/Library"))){$true} Else{$false};

Set-Variable -Name "IsLinux" -Scope "Global" -Visibility "Public" -Option "ReadOnly, AllScope" -Value $SetVal;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Set-Variable (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/set-variable?view=powershell-5.1
#
# ------------------------------------------------------------