# ------------------------------------------------------------
#
# PowerShell - Get (list) service(s) by name 
#


# Get (list) services matching a given Name (Unique-ID) or DisplayName (shown under the "Name" column in services.msc, ridiculously enough)
Get-Service -ErrorAction "SilentlyContinue" `
| Where-Object { `
	(($_.Name -Like "ASUS*") -Or ($_.DisplayName -Like "ASUS*")) `
	-Or (($_.Name -Like "ROG Live*") -Or ($_.DisplayName -Like "ROG Live*")) `
	-Or (($_.Name -Like "ARMOURY CRATE*") -Or ($_.DisplayName -Like "ARMOURY CRATE*")) `
} `
| Select-Object -Property DisplayName `
| Sort-Object -Property DisplayName `
;


# Get (list) services which have the "Running" status
Get-Service -ErrorAction "SilentlyContinue" `
| Where-Object { `
	($_.Status -eq "Running") `
} `
;


# ------------------------------------------------------------
#
# Citation(s)
#
#  docs.microsoft.com  |  "Get-Service (Microsoft.PowerShell.Management) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-service
#
# ------------------------------------------------------------