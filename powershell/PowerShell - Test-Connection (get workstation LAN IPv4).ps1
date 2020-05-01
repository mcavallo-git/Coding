# ------------------------------------------------------------

$ThisIPv4_LAN = (Test-Connection -ComputerName($env:COMPUTERNAME) -Count (1)).IPV4Address.IPAddressToString;

$ThisIPv4_LAN;


# ------------------------------------------------------------

$AllIPAddresses = (Get-NetIPAddress).IPAddress;

$AllIPAddresses;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Test-Connection"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-connection
#
#
#   stackoverflow.com  |  "windows - Powershell get ipv4 address into a variable - Stack Overflow"  |  https://stackoverflow.com/a/32204521
#
# ------------------------------------------------------------