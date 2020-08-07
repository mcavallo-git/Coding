# ------------------------------------------------------------
#
# List all services matching a given Name (Unique-ID) or DisplayName (shown under the "Name" column in services.msc, ridiculously enough)
#

Get-Service -ErrorAction "SilentlyContinue" `
| Where-Object { `
	(($_.Name -Like "ASUS*") -Or ($_.DisplayName -Like "ASUS*")) `
	-Or (($_.Name -Like "ROG Live*") -Or ($_.DisplayName -Like "ROG Live*")) `
	-Or (($_.Name -Like "ARMOURY CRATE*") -Or ($_.DisplayName -Like "ARMOURY CRATE*")) `
} `
| Select-Object -Property DisplayName `
| Sort-Object -Property DisplayName `
;


#
# List services which are have the "Running" status
#
Get-Service -ErrorAction "SilentlyContinue" `
| Where-Object { `
	($_.Status -eq "Running") `
} `
;


# ------------------------------------------------------------
#
# STOP service(s) by Name
#

Get-Service -Name ("wuauserv") -ErrorAction "SilentlyContinue" `
| Where-Object { $_.Status -eq "Running"} `
| ForEach-Object { `
	Write-Host "`n$($MyInvocation.MyCommand.Name) - Task: Stopping Service `"$($_.Name)`" ...  " -ForegroundColor "Gray"; `
	Stop-Service -Name ($_.Name) -Force -NoWait -ErrorAction "SilentlyContinue"; `
} `
;


#
#
# STOP service(s) by Name/DisplayName
#

Get-Service -ErrorAction "SilentlyContinue" `
| Where-Object { `
	(($_.Name -Like "ASUS*") -Or ($_.DisplayName -Like "ASUS*")) `
	-Or (($_.Name -Like "ROG Live*") -Or ($_.DisplayName -Like "ROG Live*")) `
	-Or (($_.Name -Like "ARMOURY CRATE*") -Or ($_.DisplayName -Like "ARMOURY CRATE*")) `
} `
| Stop-Service `
;


# ------------------------------------------------------------
# Citation(s)
#
#  docs.microsoft.com  |  "Get-Service - Gets the services on the computer."  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-service?view=powershell-7
#
# ------------------------------------------------------------