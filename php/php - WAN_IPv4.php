<?php

$IP_RESOLVERS = @();

# IPv4 Resolvers
$IP_RESOLVERS += "https://ipv4.icanhazip.com";
$IP_RESOLVERS += "https://v4.ident.me";
$IP_RESOLVERS += "https://ipinfo.io/ip";
$IP_RESOLVERS += "https://ipecho.net/plain";

# IPv6 Resolvers
$IP_RESOLVERS += "https://ipv6.icanhazip.com";
$IP_RESOLVERS += "https://v6.ident.me";
$IP_RESOLVERS += "https://bot.whatismyipaddress.com";
$IP_RESOLVERS += "https://checkip.amazonaws.com"

$WAN_IPv4 = '';
foreach ($IP_RESOLVERS as $EACH_RESOLVER) {
	if (empty($WAN_IPv4)) {
		$RESOLVED_IPv4 = trim(file_get_contents($EACH_RESOLVER));
		if (!empty($RESOLVED_IPv4)) {
			$WAN_IPv4 = $RESOLVED_IPv4;
			break;
		}
	}
}

echo "WAN_IPv4=[$WAN_IPv4]";

?>