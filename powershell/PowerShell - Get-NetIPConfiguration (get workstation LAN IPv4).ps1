
### DEPRECATED - USE POWERSHELL METHOD "Test-Connection", INSTEAD

<#
	$ThisIPv4_LAN = (
		Get-NetIPConfiguration |
		Where-Object {
			$_.IPv4DefaultGateway -ne $null -and
			$_.NetAdapter.Status -ne "Disconnected"
		}
	).IPv4Address.IPAddress;

	$ThisIPv4_LAN;
#>

#
#	Citation(s)
#
#		Documentation
#			docs.microsoft.com, "Get-NetIPConfiguration", https://docs.microsoft.com/en-us/powershell/module/nettcpip/get-netipconfiguration
#
#		Solution
#			Thanks to StackOverflow user [ Lucas ] on forum [ https://stackoverflow.com/questions/27277701 ]
#
