
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

	$ConstrainInterface = (Test-NetConnection -ComputerName ("google.com") -ConstrainInterface ($_.InterfaceIndex) -DiagnoseRouting -InformationLevel "Detailed");
	$ConstrainInterface | Format-List;

	Write-Host "";

	
	$TraceRoute = (Test-NetConnection -ComputerName ("google.com") -TraceRoute -InformationLevel "Detailed");
	$TraceRoute | Format-List;
	
	Write-Host "";

	$TraceRoute.TraceRoute | Foreach-Object {

		# Lookup the hostname of each traceroute hop
		$ErrorActionPrefBackup = $ErrorActionPreference;
		$ErrorActionPreference = ("SilentlyContinue");
		$DnsLookupHostname = ([System.Net.Dns]::GetHostByAddress($_)); $DnsLookupSuccess = $?;
		$ErrorActionPreference = ("${ErrorActionPrefBackup}");

		Write-Host "Hostname Resolution" -NoNewLine;
		Write-Host " | " -NoNewLine;
		Write-Host "IPv4 `"$_`"" -NoNewLine;
		Write-Host " | " -NoNewLine;
		If ($DnsLookupSuccess -Eq $False) {
			Write-Host "Unable to resolve hostname" -ForeGroundColor ("Red");
		} Else {
			Write-Host ($DnsLookupHostname.HostName) -ForeGroundColor ("Green");
			# $DnsLookupHostname.GetType();
		}
	}
	Write-Host "";

};



#
#	Citation(s)
#
#			docs.microsoft.com, "Test-NetConnection", https://docs.microsoft.com/en-us/powershell/module/nettcpip/test-netconnection
#			docs.microsoft.com, "Get-NetIPConfiguration", https://docs.microsoft.com/en-us/powershell/module/nettcpip/get-netipconfiguration
