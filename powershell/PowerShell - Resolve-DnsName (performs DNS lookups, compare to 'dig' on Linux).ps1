
# Perform a basic DNS query on multiple records, passed as a hash-table

$DNS_RESOLVER = "8.8.8.8";
$RECORD_TYPE = "A";

$DDNS_UIDS  = @();
$DDNS_UIDS += @{ Name="Facebook"; Host="www.facebook.com"; };
$DDNS_UIDS += @{ Name="Google"; Host="www.google.com"; };

$DDNS_UIDS | ForEach {
	$NsgRuleName = (("programmer_ddns_")+($_.Name));
	$HostToLookup = ($_.Host);
	$DnsRecord_A = (
		Resolve-DnsName `
			-Name ${HostToLookup} `
			-Type ${RECORD_TYPE} `
			-Server ${DNS_RESOLVER} `
			-QuickTimeout `
			-NoHostsFile `
	);
	$_.IPv4 = If ($DnsRecord_A.IPAddress -ne $null) { $DnsRecord_A.IPAddress } Else { "" };
	$_ | Format-Table;
};

$DDNS_UIDS
