<?php

$IP_RESOLVERS = array();
$IP_RESOLVERS[] = "https://icanhazip.com";
$IP_RESOLVERS[] = "https://ipecho.net/plain";
$IP_RESOLVERS[] = "https://ident.me";
$IP_RESOLVERS[] = "https://bot.whatismyipaddress.com";

$WAN_IPv4 = '';
foreach ($IP_RESOLVERS as $EACH_RESOLVER) {
	if (empty($WAN_IPv4)) {
		$RESOLVED_IPv4 = file_get_contents($EACH_RESOLVER);
		if (!empty($RESOLVED_IPv4)) {
			$WAN_IPv4 = $RESOLVED_IPv4;
			break;
		}
	}
}

echo "WAN_IPv4=[$WAN_IPv4]"

?>