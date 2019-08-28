
function ResolveIPv4 {
	Param(

		[ValidateSet('WAN','LAN',IgnoreCase=$false)]
		[String]$NetworkAreaScope = "WAN",

		[ValidateSet('IPv4','CIDR')]
		[String]$OutputNotation="IPv4",

		[String]$Url,

		[Switch]$GetLoopbackAddress,
		[Switch]$ResolveOutgoingIPv4

	)

	$ReturnedValue = $null;

	$ResolveOutgoingIPv4 = $False;
	$ResolveOutgoingIPv4 = If ($PSBoundParameters.ContainsKey('GetLoopbackAddress') -Eq $True) { $True } Else ( $ResolveOutgoingIPv4 );
	$ResolveOutgoingIPv4 = If ($PSBoundParameters.ContainsKey('ResolveOutgoingIPv4') -Eq $True) { $True } Else ( $ResolveOutgoingIPv4 );
	$ResolveOutgoingIPv4 = If ($PSBoundParameters.ContainsKey('Url') -Eq $False) { $True } Else ( $ResolveOutgoingIPv4 );

	$WAN_TestServer_1 = "https://icanhazip.com";
	$WAN_TestServer_2 = "https://ipecho.net/plain";
	$WAN_TestServer_3 = "https://ident.me";
	$WAN_TestServer_4 = "https://bot.whatismyipaddress.com";

	$WAN_JSON_TestServer_1 = @{};
	$WAN_JSON_TestServer_1.url = "https://ipinfo.io/json";
	$WAN_JSON_TestServer_1.prop = "ip";

	If ($ResolveOutgoingIPv4 -Eq $True) {
		# Resolve Current Workstation's WAN IPv4 Address

		If ($NetworkAreaScope -eq "WAN") {

			$This_WAN_IPv4_1 = ((Invoke-WebRequest -UseBasicParsing -Uri ($WAN_TestServer_1)).Content).Trim();

			$This_WAN_IPv4_2 = ((Invoke-WebRequest -UseBasicParsing -Uri ($WAN_TestServer_2)).Content).Trim();

			$This_WAN_IPv4_3 = ((Invoke-WebRequest -UseBasicParsing -Uri ($WAN_TestServer_3)).Content).Trim();

			$This_WAN_IPv4_4 = ((Invoke-WebRequest -UseBasicParsing -Uri ($WAN_TestServer_4)).Content).Trim();

			$This_WAN_JSON_IPv4_1 = (Invoke-RestMethod ($WAN_JSON_TestServer_1.url) | Select -exp ($WAN_JSON_TestServer_1.prop));

			$ReturnedValue = ($This_WAN_IPv4_1);

		} Else {
			Write-Host "No LAN Implementation currently available (Under Construction)";

		}

	} ElseIf ($PSBoundParameters.ContainsKey('Url')) {

		# Resolve Url-to-Hostname-to-IPv4
		$ReturnedValue = ([System.Net.Dns]::GetHostAddresses(([System.Uri]$Url).Host)).IpAddressToString;

		$ReturnedValue = ($ReturnedValue -split '\n')[0];

		### The long-way (for error checking)
		#
		# Resolve Url-to-Hostname
		# If ([System.Uri]$Url.Host -eq $null) {
		# 	Write-Host (("Fail - Module [ ResolveIPv4 ] was unable to determine hostname from Url [")+($Url)+("]"));
		# 	Start-Sleep 600;
		# 	Exit 1;
		# } Else {
		# 	$UrlHostname = [System.Uri]$Url.Host;
		#
		# 	# Resolve Hostname-to-IPv4
		# 	$UrlIPv4 = [System.Net.Dns]::GetHostAddresses($UrlHostname).IpAddressToString;
		# 	$last_exit_code = If($?){0}Else{1};
		# 	If ($last_exit_code -eq 1) {
		# 		Write-Host (("Fail - Module [ ResolveIPv4 ] was unable to determine IPv4 for Hostname [")+($UrlHostname)+("]"));
		# 		Start-Sleep 600;
		# 		Exit 1;
		# 	} Else {
		# 		$ReturnedValue = $UrlIPv4;
		#
		# 	}
		# }

	} Else {
		
		Write-Host ("Fail - Module [ ResolveIPv4 ] called with invalid parameters");
		Start-Sleep 600;
		Exit 1;

	}
	
	If ($OutputNotation -eq "CIDR") {
		$ReturnedValue = (($ReturnedValue)+("/32"));
	}

	Return ($ReturnedValue);

}

Export-ModuleMember -Function "ResolveIPv4";