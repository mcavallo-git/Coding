
$ThisIPv4_LAN = (Test-Connection -ComputerName($env:COMPUTERNAME) -Count (1)).IPV4Address.IPAddressToString;

$ThisIPv4_LAN;


#
#	Citation(s)
#
#		Documentation
#			docs.microsoft.com, "Test-Connection", https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-connection
#
#		Solution
#			Thanks to StackOverflow user [ Jana Sattainathan ] on forum [ https://stackoverflow.com/questions/27277701 ]
#
