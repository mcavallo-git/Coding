
# $NameMustContain = "Dock";
$NameMustContain = "Wi-Fi";

Get-NetIPConfiguration |
Where-Object { $_.IPv4DefaultGateway -ne $null } |
Where-Object { $_.NetAdapter.Status -eq "Up" } |
Where-Object { ($_.InterfaceDescription.Contains($NameMustContain) -or $_.InterfaceAlias.Contains($NameMustContain)) } |
ForEach-Object {

	# Write-Host (
	# 	("`n	Interface #")+($_.InterfaceIndex)+("`n")+
	# 	("	  |-> InterfaceAlias `"")+($_.InterfaceAlias)+("`"`n")+
	# 	("	  |-> InterfaceDescription `"")+($_.InterfaceDescription)+("`"`n")+
	# 	("	  |-> IPv4Address `"")+($_.IPv4Address.IPAddress)+("`"`n")
	# );

	Write-Host "------------------------------------------------------------";

	Test-NetConnection -ComputerName ("google.com") -ConstrainInterface ($_.InterfaceIndex) -DiagnoseRouting -InformationLevel "Detailed";

	Write-Host "";

	Test-NetConnection -ComputerName ("google.com") -TraceRoute;
	
	Write-Host "";

};



#
#	Citation(s)
#
#			docs.microsoft.com, "Test-NetConnection", https://docs.microsoft.com/en-us/powershell/module/nettcpip/test-netconnection
#			docs.microsoft.com, "Get-NetIPConfiguration", https://docs.microsoft.com/en-us/powershell/module/nettcpip/get-netipconfiguration
