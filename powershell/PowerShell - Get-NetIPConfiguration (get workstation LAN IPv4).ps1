
$ThisIPv4_LAN = (
	Get-NetIPConfiguration |
	Where-Object {
		$_.IPv4DefaultGateway -ne $null -and
		$_.NetAdapter.Status -ne "Disconnected"
	}
).IPv4Address.IPAddress;

$ThisIPv4_LAN;

#
#	Citation(s)
#
#		Thanks to StackOverflow user [ Lucas ] on forum [ https://stackoverflow.com/questions/27277701 ]
#
