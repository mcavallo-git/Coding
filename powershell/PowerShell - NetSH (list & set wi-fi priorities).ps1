
$WAN_Connections = @();
$WiFi_Connections = @();

# Show All Network adapters
netsh.exe int ipv4 show interfaces | 


# "Haystack", aka the string to parse (may have newlines aplenty)
$Haystack = netsh.exe wlan show interfaces;

# Regex pattern which defines the "Matches" to match while parsing the through the "Haystack"
$RegexPattern = '';
$RegexPattern = $RegexPattern + '^'; # Start Regex Pattern
$RegexPattern = $RegexPattern + '\s+([0-9]+)'; # Capture the col-1 (Idx)
$RegexPattern = $RegexPattern + '\s+([0-9]+)'; # Capture the col-2 (Met)
$RegexPattern = $RegexPattern + '\s+([0-9]+)'; # Capture the col-3 (MTU)
$RegexPattern = $RegexPattern + '\s+(\S+)'; # Capture the col-4 (State)
$RegexPattern = $RegexPattern + '\s+(.+)'; # Capture col-5 (Name - the remainder at the end of the table, including spaces)
$RegexPattern = $RegexPattern + '$'; # End Regex Pattern
Write-Output "RegexPattern:"; ${RegexPattern};

$Matches = [Regex]::Match($Haystack, $RegexPattern); # Parse through the "Haystack", looking for the "Matches"

Write-Output "Matches:"; ${Matches};

Write-Output (("`$Matches.Success = ")+($Matches.Success));

If ($Matches.Success -ne $False) {

	# $Matches.Groups[0].Value;
	$Matches.Groups[1].Value;
	$Matches.Groups[2].Value;
	$Matches.Groups[3].Value;
	$Matches.Groups[4].Value;
	$Matches.Groups[5].Value;

}


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