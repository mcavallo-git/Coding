@ECHO OFF
REM Show current Wi-Fi connections, by-priority ( found at the top of the table which netsh returns) 
REM  |--> Windows attempts to connect to the most-prioritized connection while searching for bandwidth via Wi-Fi, in-order from top to bottom (of the output from netsh)

REM Show All Networks which are currently-connected and aren't loopback adapters (e.g. ignore virtual loopback NICs)
wmic nicconfig where "IPEnabled=True AND TcpipNetbiosOptions!=null AND TcpipNetbiosOptions!=2 AND DHCPServer!=`"255.255.255.255`"" get Description,InterfaceIndex,IPAddress,DefaultIPGateway,IPSubnet,DNSServerSearchOrder,DHCPServer /format:list

REM Show All Network adapters
NETSH INT IPV4 SHOW INTERFACES

REM Show Wi-Fi (WLAN) adapters
NETSH WLAN SHOW INTERFACES

REM Show Wi-Fi SSIDs along with how they're currently prioritized
NETSH WLAN SHOW PROFILES

REM Configure network profile(s)

NETSH WLAN SET profileorder name="wlan_primary" interface="Intel(R) Wireless" priority=1

NETSH WLAN SET profileorder name="wlan_secondary" interface="Intel(R) Wireless" priority=2

REM ------------------------------------------------------------
REM
REM	Citation(s)
REM
REM		ss64.com  |  "WMIC.exe"  |  https://ss64.com/nt/wmic.html
REM
REM ------------------------------------------------------------