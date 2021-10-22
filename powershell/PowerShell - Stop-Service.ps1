# ------------------------------------------------------------
#
# PowerShell - Stop service(s) by name 
#


# Stop Service(s):  wuauserv
Get-Service -Name ("wuauserv") -ErrorAction "SilentlyContinue" `
| Where-Object { $_.Status -eq "Running"} `
| ForEach-Object { `
	Write-Host "`n$($MyInvocation.MyCommand.Name) - Task: Stopping Service `"$($_.Name)`" ...  " -ForegroundColor "Gray"; `
	Stop-Service -Name ($_.Name) -Force -NoWait -ErrorAction "SilentlyContinue"; `
} `
;


# Stop Service(s):  "ASUS*" + "ROG Live*" + "ARMOURY CRATE*"
Get-Service -ErrorAction "SilentlyContinue" `
| Where-Object { `
	(($_.Name -Like "ASUS*") -Or ($_.DisplayName -Like "ASUS*")) `
	-Or (($_.Name -Like "ROG Live*") -Or ($_.DisplayName -Like "ROG Live*")) `
	-Or (($_.Name -Like "ARMOURY CRATE*") -Or ($_.DisplayName -Like "ARMOURY CRATE*")) `
} `
| Stop-Service `
;


# ------------------------------------------------------------
#
# Citation(s)
#
#  docs.microsoft.com  |  "Stop-Service - Stops one or more running services"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/stop-service?view=powershell-5.1
#
# ------------------------------------------------------------