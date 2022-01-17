# ------------------------------------------------------------
# PowerShell - Get-DnsClientServerAddress
# ------------------------------------------------------------

Get-DnsClientServerAddress | Where-Object { ${_}.Address -NE $Null; } | Where-Object { ${_}.ElementName -NotLike '*Loopback*'; } | Select-Object -First 1 -ExpandProperty 'Address' | ForEach-Object { Write-Host (('DNS Server Address:  [ ')+(${_})+(' ]')); };


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-DnsClientServerAddress (DnsClient) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/dnsclient/get-dnsclientserveraddress
#
# ------------------------------------------------------------