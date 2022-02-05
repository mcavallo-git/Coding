# ------------------------------------------------------------
#
# PowerShell - Get current device's WAN IPv4 address
#

If ($True) {

$ProgressPreference='SilentlyContinue'; <# Hide Invoke-WebRequest's progress bar #>

# IPv4 Resolvers
$URL_IPv4_RESOLVER="https://ipv4.icanhazip.com";
$URL_IPv4_RESOLVER="https://v4.ident.me";
$URL_IPv4_RESOLVER="https://ipinfo.io/ip";
$URL_IPv4_RESOLVER="https://ipecho.net/plain";

# IPv6 Resolvers
$URL_IPv6_RESOLVER="https://ipv6.icanhazip.com";
$URL_IPv6_RESOLVER="https://v6.ident.me";
$URL_IPv6_RESOLVER="https://bot.whatismyipaddress.com";
$URL_IPv6_RESOLVER="https://checkip.amazonaws.com";

# ------------------------------

$PUBLIC_IPV4=((Invoke-WebRequest -UseBasicParsing -Uri "${URL_IPv4_RESOLVER}").Content -split ([String][Char]10) | Select-Object -First 1);

Write-Host "PUBLIC_IPV4 = [${PUBLIC_IPV4}]";

}

