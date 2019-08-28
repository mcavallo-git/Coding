
function ResolveIP {
	Param(

		[ValidateSet('WAN','LAN')]
		[String]$Scope = "WAN",
		[Switch]$LAN,
		[Switch]$WAN,

		[ValidateSet('IP','CIDR')]
		[String]$Notation="IP",
		[Switch]$IP,
		[Switch]$CIDR,

		[ValidateSet('4','v4','6','v6','any','all')]
		[String]$Version="v4",

		[Switch]$v4,
		[Switch]$v6,

		[String]$Url,
		[Switch]$Localhost
	
	)

	$ReturnedValue = "";

	# ------------------------------------------------------------

	If ($PSBoundParameters.ContainsKey('v4') -Eq $True) {
		$Version="v4";
	} ElseIf ($PSBoundParameters.ContainsKey('v6') -Eq $True) {
		$Version="v6";
	}

	# ------------------------------------------------------------

	If ($PSBoundParameters.ContainsKey('IP') -Eq $True) {
		$Notation="IP";
	} ElseIf ($PSBoundParameters.ContainsKey('CIDR') -Eq $True) {
		$Notation="CIDR";
	}

	# ------------------------------------------------------------

	If ($PSBoundParameters.ContainsKey('WAN') -Eq $True) {
		$Scope="WAN";
	} ElseIf ($PSBoundParameters.ContainsKey('LAN') -Eq $True) {
		$Scope="LAN";
	}

	# ------------------------------------------------------------

	$ResolveLocalhost = $False;
	If ($PSBoundParameters.ContainsKey('Url') -Eq $False) {
		$ResolveLocalhost = $True;
	} ElseIf ($PSBoundParameters.ContainsKey('Localhost') -Eq $True) {
		$ResolveLocalhost = $True;
	} ElseIf (($Url -Eq "localhost") -Or ($Url -Eq "127.0.0.1")) {
		$ResolveLocalhost = $True;
	}
	
	# ------------------------------------------------------------

	$IPv4_Resolvers = @();
	$IPv4_Resolvers += "https://ipv4.icanhazip.com";
	$IPv4_Resolvers += "https://v4.ident.me";

	$IPv6_Resolvers = @();
	$IPv6_Resolvers += "https://ipv6.icanhazip.com";
	$IPv6_Resolvers += "https://v6.ident.me";
	
	$IPv4_Resolvers += "https://ipinfo.io/ip";
	$IPv4_Resolvers += "https://ipecho.net/plain";
	$IPv6_Resolvers += "https://bot.whatismyipaddress.com";
	$IPv6_Resolvers += "https://checkip.amazonaws.com";

	$WAN_JSON_TestServer_1 = @{};
	$WAN_JSON_TestServer_1.url = "https://ipinfo.io/json";
	$WAN_JSON_TestServer_1.prop = "ip";

	If ($ResolveLocalhost -Eq $True) {
		# Resolve Current Workstation's WAN IPv4 Address

		If ($Scope -eq "WAN") {

			$RegexPattern_IPv4 = '^(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})(\/\d{1,2})?$';
			$RegexPattern_IPv6 = '^((?:[0-9a-f]{0,4}:){2,7}[0-9a-f]{1,4})$';
			$RegexPattern_IPv4OR6 = "^((?:${RegexPattern_IPv4})|(?:${RegexPattern_IPv6}))$";

			# $VersionResolvers = $IPv4_Resolvers;
			# $VersionResolvers = $IPv6_Resolvers;
			$VersionResolvers = ($IPv4_Resolvers + $IPv6_Resolvers);

			If (($Version -Eq '4') -Or ($Version -Eq 'v4')) {
				$RegexPattern_Versioned = $RegexPattern_IPv4;
			} ElseIf (($Version -Eq '6') -Or ($Version -Eq 'v6')) {
				$RegexPattern_Versioned = $RegexPattern_IPv6;
			} ElseIf (($Version -Eq 'any') -Or ($Version -Eq 'all')) {
				$RegexPattern_Versioned = $RegexPattern_IPv4OR6;
			}
			
			ForEach ($Each_Resolver In $VersionResolvers) {
				Try {
					If ($ReturnedValue -Eq "") {
						$EachResolvedIP = ((Invoke-WebRequest -UseBasicParsing -Uri ($Each_Resolver)).Content).Trim();
						$MatchResults = [Regex]::Match($EachResolvedIP, $RegexPattern_Versioned);
						If ($MatchResults.Success -eq $True) {
							$ReturnedValue = $MatchResults.Groups[1].Value;
						}
					}
				} Catch [System.Net.WebException] {
					$ReturnedValue = "";
				}
			}
			# $Get_WAN_IPv4_Using_JSON = (Invoke-RestMethod ($WAN_JSON_TestServer_1.url) | Select -exp ($WAN_JSON_TestServer_1.prop));

		} ElseIf ($Scope -eq "LAN") {
			Write-Host "No LAN Implementation currently available (Under Construction)";

		}

	} ElseIf ($PSBoundParameters.ContainsKey('Url')) {

		# Resolve Url-to-Hostname-to-IPv4
		$ReturnedValue = ([System.Net.Dns]::GetHostAddresses(([System.Uri]$Url).Host)).IpAddressToString;
		$ReturnedValue = ($ReturnedValue -split '\n')[0];

	} Else {
		
		Write-Host ("Fail - Module [ ResolveIP ] called with invalid parameters");
		Start-Sleep 600;
		Exit 1;

	}
	
	If ($Notation -eq "CIDR") {
		$ReturnedValue = (($ReturnedValue)+("/32"));
	}

	Return ($ReturnedValue);

}

Export-ModuleMember -Function "ResolveIP";