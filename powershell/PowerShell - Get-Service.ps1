
#
# Show Running Services
#
Get-Service -ErrorAction "SilentlyContinue" | Where-Object { $_.Status -eq "Running"}



#
# Stop Service(s) by Name
#
Get-Service -Name ("wuauserv") -ErrorAction "SilentlyContinue" | Where-Object { $_.Status -eq "Running"} | ForEach-Object {
	Write-Host "`n$($MyInvocation.MyCommand.Name) - Task: Stopping Service `"$($_.Name)`" ...  " -ForegroundColor "Gray";
	Stop-Service -Name ($_.Name) -Force -NoWait -ErrorAction "SilentlyContinue";
}


# ------------------------------------------------------------
# Citation(s)
#
#  docs.microsoft.com  |  "Get-Service - Gets the services on the computer."  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-service?view=powershell-7
#
# ------------------------------------------------------------