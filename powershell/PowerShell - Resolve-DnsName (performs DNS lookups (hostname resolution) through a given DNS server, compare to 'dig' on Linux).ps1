# ------------------------------------------------------------
# PowerShell - Resolve-DnsName (performs DNS lookups (hostname resolution) through a given DNS server, compare to 'dig' on Linux)
# ------------------------------------------------------------
#
# Basic DNS query example(s)
#

Resolve-DnsName -Name "example.com" -Server "8.8.8.8";  # Google DNS Server(s)


Resolve-DnsName -Name "example.com" -Server "1.1.1.1";  # CloudFlare DNS Server(s)


Resolve-DnsName -Name "example.com" -Server "4.4.4.4";  # INVALID (forced fail) --> Nonexistent DNS Server(s)


# ------------------------------------------------------------
#
# Intermediate DNS query example(s)
#

# Perform a DNS query on multiple records, passed as a hash-table
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
Write-Output $DDNS_UIDS;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Resolve-DnsName (DnsClient) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/dnsclient/resolve-dnsname
#
#   docs.pi-hole.net  |  "Upstream DNS Providers - Pi-hole documentation"  |  https://docs.pi-hole.net/guides/dns/upstream-dns-providers/
#
# ------------------------------------------------------------