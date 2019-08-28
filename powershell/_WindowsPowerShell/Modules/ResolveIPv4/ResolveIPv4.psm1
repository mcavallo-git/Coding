
function ResolveIP {
	Param(

		[ValidateSet('WAN','LAN',IgnoreCase=$false)]
		[String]$NetworkAreaScope = "WAN",

		[ValidateSet('IPv4','CIDR')]
		[String]$OutputNotation="IPv4",

		[String]$Url,

		[Switch]$Localhost

		[Switch]$4,
		[Switch]$v4,

		[Switch]$6,
		[Switch]$v6

	)

	$ReturnedValue = "";

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
	$IPv4_Resolvers += "https://ipecho.net/plain";
	$IPv4_Resolvers += "https://v4.ident.me";

	$IPv6_Resolvers = @();
	$IPv6_Resolvers += "https://ipv6.icanhazip.com";
	$IPv6_Resolvers += "https://v6.ident.me";
	$IPv6_Resolvers += "https://bot.whatismyipaddress.com";
	$IPv6_Resolvers += "https://checkip.amazonaws.com";

	$WAN_JSON_TestServer_1 = @{};
	$WAN_JSON_TestServer_1.url = "https://ipinfo.io/json";
	$WAN_JSON_TestServer_1.prop = "ip";

	If ($ResolveLocalhost -Eq $True) {
		# Resolve Current Workstation's WAN IPv4 Address

		If ($NetworkAreaScope -eq "WAN") {

			ForEach ($Each_Resolver In ($IPv4_Resolvers + $IPv6_Resolvers)) {
				Try {
					If ($ReturnedValue -Eq "") {
						$ReturnedValue = ((Invoke-WebRequest -UseBasicParsing -Uri ($Each_Resolver)).Content).Trim();
					}
					# $Test_URL = Invoke-WebRequest -Uri $URI -Method "Post" -Body $RequestBody -ContentType $ContentType
				} Catch [System.Net.WebException] {
					$ReturnedValue = "";
					# $DatException = $_.Exception; Write-Host "Exception caught: $DatException";
					# $DatExceptionMessage = ($_.Exception.Message).ToString().Trim(); Write-Output $DatExceptionMessage;
				}
			}
			# $Get_WAN_IPv4_Using_JSON = (Invoke-RestMethod ($WAN_JSON_TestServer_1.url) | Select -exp ($WAN_JSON_TestServer_1.prop));

		} Else {
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
	
	If ($OutputNotation -eq "CIDR") {
		$ReturnedValue = (($ReturnedValue)+("/32"));
	}

	Return ($ReturnedValue);

}

Export-ModuleMember -Function "ResolveIP";