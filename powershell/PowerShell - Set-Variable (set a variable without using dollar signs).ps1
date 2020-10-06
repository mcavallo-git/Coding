
# ------------------------------------------------------------
# Set-Variable
#  |
#  |--> Ex) Set the variable [ $IsLinux ]

If ((Test-Path "/bin") -And (-Not (Test-Path "/Library"))) {
	Set-Variable -Name "IsLinux" -Scope "Global" -Visibility "Public" -Option "ReadOnly, AllScope" -Value (1);
} Else {
	Set-Variable -Name "IsLinux" -Scope "Global" -Visibility "Public" -Option "ReadOnly, AllScope" -Value (0);
};


# ------------------------------------------------------------
# Get-Variable
#  |
#  |--> Ex) Get the value held by variable [ $IsLinux ]

(Get-Variable -Name "IsLinux").Value;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-Variable (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-variable?view=powershell-5.1
#
#   docs.microsoft.com  |  "Set-Variable (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/set-variable?view=powershell-5.1
#
# ------------------------------------------------------------