
# az network nsg
#		"Manage Azure Network Security Groups (NSGs)"
#		 https://docs.microsoft.com/en-us/cli/azure/network/nsg

# az network nsg rule
#		"Manage network security group rules"
#		 https://docs.microsoft.com/en-us/cli/azure/network/nsg/rule


$Az = (JsonDecoder -InputObject (Get-Content "${HOME}\.ddns\azure_nsg.json"));

$DDNS_UIDS = (JsonDecoder -InputObject (Get-Content "${HOME}\.ddns\cidr_ddns.json"));

$ReturnedVal = '';

$ResolvedIPv4s = @();

$DDNS_UIDS | ForEach {
	# Perform a DNS query to reverse-lookup the IPv4 for each hostname
	$DnsRecord_A = (
		Resolve-DnsName `
			-Name ($_.Host) `
			-Type A `
			-Server "8.8.8.8" `
			-QuickTimeout `
			-NoHostsFile `
	);
	If ($DnsRecord_A.IPAddress -eq $null) {
		Write-Host (("Error - Unable to resolve hostname: ")+($_.Host)) -BackgroundColor Black -ForegroundColor Yellow;
	} ElseIf (!$ResolvedIPv4s.Contains((($DnsRecord_A.IPAddress)+("/32")))) {
		$ResolvedIPv4s += @((($DnsRecord_A.IPAddress)+("/32")));
	}

};

if ($ResolvedIPv4s.Length -eq 0)  {

	$ReturnedVal = "No results returned valid IPv4 data (DDNS_UIDS.IPv4.Length===0)";
	
} else {

	$NsgShowRuleDDNS = `
		JsonDecoder -InputObject (
			az network nsg rule show `
			--subscription ($Az.Subscription) `
			--resource-group ($Az.ResourceGroup) `
			--nsg-name ($Az.NsgParentName) `
			--name ($Az.NsgRuleName) `
		);
		
	# $NsgShowRuleDDNS;

	if (($NsgShowRuleDDNS) -eq $null) {
		
		$NsgRuleCreate = `
			JsonDecoder -InputObject ( `
				az network nsg rule create `
					--subscription ($Az.Subscription) `
					--resource-group ($Az.ResourceGroup) `
					--nsg-name ($Az.NsgParentName) `
					--name ($Az.NsgRuleName) `
					--priority ($Az.NsgRulePriority) `
					--access ("Allow") `
					--description ($Az.NsgRuleName) `
					--destination-address-prefixes ("VirtualNetwork") `
					--destination-port-ranges ("*") `
					--direction ("Inbound") `
					--protocol ("*") `
					--source-address-prefixes ($ResolvedIPv4s) `
					--source-port-ranges ("*") `
		);
		
		$ReturnedVal = $NsgRuleCreate;
		
	} else {

		$NsgRuleUpdate = `
			JsonDecoder -InputObject ( `
				az network nsg rule update `
					--subscription ($Az.Subscription) `
					--resource-group ($Az.ResourceGroup) `
					--nsg-name ($Az.NsgParentName) `
					--name ($Az.NsgRuleName) `
					--priority ($Az.NsgRulePriority) `
					--access ("Allow") `
					--description ($Az.NsgRuleName) `
					--destination-address-prefixes ("VirtualNetwork") `
					--destination-port-ranges ("*") `
					--direction ("Inbound") `
					--protocol ("*") `
					--source-address-prefixes ($ResolvedIPv4s) `
					--source-port-ranges ("*") `
			);
		$ReturnedVal = $NsgRuleUpdate;
	}

}

$Output_Filepath = ("C:\ISO\DDNS\Logs\Azure-DDNS-Updater.$(Get-Date -UFormat '%Y-%m-%d (%a)').log");

Get-Date -UFormat '%Y-%m-%d %H:%M:%S' | Out-File -Append -FilePath ("$Output_Filepath");
$ReturnedVal | Out-File -Append -FilePath ("$Output_Filepath");
