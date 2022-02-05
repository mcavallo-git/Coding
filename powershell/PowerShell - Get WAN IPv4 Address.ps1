# ------------------------------------------------------------
#
# PowerShell - Get current device's WAN IPv4 address
#

If ($True) {

$ProgressPreference='SilentlyContinue'; <# Hide Invoke-WebRequest's progress bar #>

$PUBLIC_IPV4=((Invoke-WebRequest -UseBasicParsing -Uri "https://icanhazip.com").Content -split ([String][Char]10) | Select-Object -First 1);

Write-Host "PUBLIC_IPV4 = [${PUBLIC_IPV4}]";

}

