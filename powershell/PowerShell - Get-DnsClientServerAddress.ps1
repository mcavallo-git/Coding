# ------------------------------------------------------------
# PowerShell - Get-DnsClientServerAddress
# ------------------------------------------------------------
#
# Get first set of non-null DNS servers from local network connections
#

Get-DnsClientServerAddress | Where-Object { ${_}.Address -NE $Null; } | Where-Object { ${_}.ElementName -NotLike '*Loopback*'; } | Select-Object -First 1 -ExpandProperty 'Address' | ForEach-Object { Write-Host (('DNS Server Address:  [ ')+(${_})+(' ]')); };


# ------------------------------------------------------------
#
# WSL - Get the Windows host's primary DNS server
#

WINDOWS_DNS_SERVER="$(PowerShell -Command 'Get-DnsClientServerAddress | Where-Object { ${_}.Address -NE $Null; } | Where-Object { ${_}.ElementName -NotLike "*Loopback*"; } | Select-Object -First 1 -ExpandProperty "Address" | Select-Object -First 1;' | sed -e "/^\s*$/d" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//';)"; echo "[${WINDOWS_DNS_SERVER}]";


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-DnsClientServerAddress (DnsClient) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/dnsclient/get-dnsclientserveraddress
#
# ------------------------------------------------------------