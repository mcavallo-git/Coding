#
# Configure Windows to prefer IPv4 over IPv6
#

Write-Host "------------------------------------------------------------";

# Ping localhost (IPv4)
Write-Host "ping 127.0.0.1";
ping 127.0.0.1

Write-Host "------------------------------------------------------------";

# Ping localhost (static hostname)
Write-Host "ping localhost";
ping localhost

Write-Host "------------------------------------------------------------";

# Ping localhost (hostname)
Write-Host "ping `"${env:COMPUTERNAME}`"";
ping "${env:COMPUTERNAME}"

Write-Host "------------------------------------------------------------";

# Use netsh to set policies to prefer IPv4 addresses over IPv6
Write-Host " Configuring Windows to prefer IPv4 over IPv6";

Write-Host "netsh interface ipv6 show prefixpolicies";
netsh interface ipv6 show prefixpolicies

Write-Host "netsh interface ipv6 set prefixpolicy ::ffff:0:0/96 50 0";
netsh interface ipv6 set prefixpolicy ::ffff:0:0/96 50 0

Write-Host "netsh interface ipv6 set prefixpolicy ::1/128 40 1";
netsh interface ipv6 set prefixpolicy ::1/128 40 1

Write-Host "netsh interface ipv6 set prefixpolicy ::/0 30 2";
netsh interface ipv6 set prefixpolicy ::/0 30 2

Write-Host "netsh interface ipv6 set prefixpolicy 2002::/16 20 3";
netsh interface ipv6 set prefixpolicy 2002::/16 20 3

Write-Host "netsh interface ipv6 set prefixpolicy 2001::/32 5 5";
netsh interface ipv6 set prefixpolicy 2001::/32 5 5

Write-Host "netsh interface ipv6 set prefixpolicy fc00::/7 3 13";
netsh interface ipv6 set prefixpolicy fc00::/7 3 13

Write-Host "netsh interface ipv6 set prefixpolicy fec0::/10 1 11";
netsh interface ipv6 set prefixpolicy fec0::/10 1 11

Write-Host "netsh interface ipv6 set prefixpolicy 3ffe::/16 1 12";
netsh interface ipv6 set prefixpolicy 3ffe::/16 1 12

Write-Host "netsh interface ipv6 set prefixpolicy ::/96 1 4";
netsh interface ipv6 set prefixpolicy ::/96 1 4

Write-Host "netsh interface ipv6 show prefixpolicies";
netsh interface ipv6 show prefixpolicies

Write-Host "------------------------------------------------------------";

# Ping localhost (IPv4)
Write-Host "ping 127.0.0.1";
ping 127.0.0.1

Write-Host "------------------------------------------------------------";

# Ping localhost (static hostname)
Write-Host "ping localhost";
ping localhost

Write-Host "------------------------------------------------------------";

# Ping localhost (hostname)
Write-Host "ping `"${env:COMPUTERNAME}`"";
ping "${env:COMPUTERNAME}"

Write-Host "------------------------------------------------------------";


# ------------------------------------------------------------
#
# Citation(s)
#
#   kb.firedaemon.com  |  "How to prioritise IPv4 over IPv6 on Windows 10 and 11"  |  https://kb.firedaemon.com/support/solutions/articles/4000160803-prioritising-ipv4-over-ipv6-on-windows-10-and-11
#
# ------------------------------------------------------------