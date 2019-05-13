
### FOR ACQUIRING LAN IPv4 - USE POWERSHELL METHOD "Test-Connection", INSTEAD

$LAN_NetworkConfig = (
	Get-NetIPConfiguration |
	Where-Object {
		$_.IPv4DefaultGateway -ne $null -and
		$_.NetAdapter.Status -ne "Disconnected"
	}
).IPv4Address.IPAddress;

$LAN_NetworkConfig;

#
#	Citation(s)
#
#		Documentation
#			docs.microsoft.com, "Get-NetIPConfiguration", https://docs.microsoft.com/en-us/powershell/module/nettcpip/get-netipconfiguration
#
#		Solution
#			Thanks to StackOverflow user [ Lucas ] on forum [ https://stackoverflow.com/questions/27277701 ]
#
