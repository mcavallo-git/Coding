
### FOR ACQUIRING LAN IPv4 - USE POWERSHELL METHOD "Test-Connection", INSTEAD

$NameMustContain = "Intel";

$NetworkConnections = (
	Get-NetIPConfiguration |
	Where-Object {
		$_.IPv4DefaultGateway -ne $null -and
		$_.NetAdapter.Status -ne "Disconnected" -and
		($_.InterfaceDescription.Contains($NameMustContain) -or $_.InterfaceAlias.Contains($NameMustContain))
	}
);
# $NetworkConnections = Get-NetIPConfiguration;
$NetworkConnections | ForEach {
	Write-Host "----------------------";
	# $_ | Format-List;
	$_.InterfaceAlias;
	$_.IPv4Address.IPAddress;
	Write-Host "======================";
};

#
#	Citation(s)
#
#		Documentation
#			docs.microsoft.com, "Get-NetIPConfiguration", https://docs.microsoft.com/en-us/powershell/module/nettcpip/get-netipconfiguration
#
#		Solution
#			Thanks to StackOverflow user [ Lucas ] on forum [ https://stackoverflow.com/questions/27277701 ]
#
