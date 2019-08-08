
$WAN_Connections = @();
$WiFi_Connections = @();

# Show All Network adapters
netsh.exe int ipv4 show interfaces

# Show Wi-Fi (WLAN) adapters
netsh.exe wlan show interfaces

# Show Wi-Fi SSIDs along with how they're currently prioritized
netsh.exe wlan show profiles

netsh.exe wlan show interfaces | FINDSTR /R "^\s*Description\s*:\s*.+$"


netsh.exe wlan show profiles

NETSH WLAN SET profileorder name="wlan_primary" interface="Wi-Fi 2" priority=1

NETSH WLAN SET profileorder name="wlan_secondary" interface="Wi-Fi 2" priority=2



# Get-WmiObject -Class Win32_NetworkAdapter -Filter "AdapterType='Ethernet 802.3'" | ForEach { Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "Index=$($_.DeviceId) AND IPEnabled = True" | Select Description,IPConnectionMetric,IPAddress | Format-Table -AutoSize}

Get-WmiObject -Class "Win32_NetworkAdapter" -Filter "AdapterType='Ethernet 802.3'" | ForEach {
	$EachNIC_Filter = "Index=$($_.DeviceId) AND IPEnabled=True AND TcpipNetbiosOptions!=null AND TcpipNetbiosOptions!=2 AND DHCPServer!=`"255.255.255.255`"";
	$EachNIC_Description = Get-WmiObject -Class "Win32_NetworkAdapterConfiguration" -Filter "${EachNIC_Filter}" | Select Description;
	$EachNIC_InterfaceIndex = Get-WmiObject -Class "Win32_NetworkAdapterConfiguration" -Filter "${EachNIC_Filter}" | Select InterfaceIndex;


}