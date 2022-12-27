# ------------------------------------------------------------
# PowerShell - Write-Host (output to terminal)
# ------------------------------------------------------------


# Write a newline to the terminal
Write-Host "";


# Write text to the terminal with/without a newline afterwards
Write-Host "-WITH newline-"; Write-Host "-WITH newline-"; `
Write-Host -NoNewLine "-withOUT newline-"; Write-Host -NoNewLine "-withOUT newline-";


# Write colored output to the terminal
Write-Host "Warning!" -BackgroundColor "Black" -ForegroundColor "Yellow";;




# ------------------------------------------------------------
#
# Citation(s)
#
#   learn.microsoft.com  |  "Write-Host (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-host
#
# ------------------------------------------------------------