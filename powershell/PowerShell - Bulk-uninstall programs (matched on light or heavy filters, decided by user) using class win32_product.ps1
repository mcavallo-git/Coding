# ------------------------------------------------------------
#
# Example: Uninstall all ASUS products installed locally
#

Get-WmiObject -Class win32_product -Filter "Vendor like '%ASUS%'" | ForEach-Object { Write-Host "Uninstalling `"$($_.Name)`"" -ForegroundColor "Yellow" -BackgroundColor "Black"; $_.Uninstall(); }


# ------------------------------------------------------------
#
# Citation(s)
#
#   chinnychukwudozie.com  |  "Uninstalling Software with Powershell. | Chinny Chukwudozie, Cloud Solutions."  |  https://chinnychukwudozie.com/2014/06/09/uninstalling-software-with-powershell/
#
# ------------------------------------------------------------