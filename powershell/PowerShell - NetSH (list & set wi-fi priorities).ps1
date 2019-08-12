
# IN-PROGRESS AS-OF 2019-08-08_17-22-25
# IN-PROGRESS AS-OF 2019-08-12_15-46-39

$Connections_NIC_NETSH = @();
$Connections_NIC_WMIC = @();
$Connections_WLAN_NETSH = @();
$Connections_WLAN_WMIC = @();

# ------------------------------------------------------------

# Show all network interfaces
$Interfaces_NIC_NETSH = (netsh.exe int ipv4 show interfaces);

$Interfaces_NIC_WMIC = (wmic nicconfig get * /format:list);

$RegexPattern_NIC_NETSH = '';
$RegexPattern_NIC_NETSH = $RegexPattern_NIC_NETSH + '^'; # Start Regex Pattern
$RegexPattern_NIC_NETSH = $RegexPattern_NIC_NETSH + '\s+([0-9]+)'; # Capture the col-1 (Idx)
$RegexPattern_NIC_NETSH = $RegexPattern_NIC_NETSH + '\s+([0-9]+)'; # Capture the col-2 (Met)
$RegexPattern_NIC_NETSH = $RegexPattern_NIC_NETSH + '\s+([0-9]+)'; # Capture the col-3 (MTU)
$RegexPattern_NIC_NETSH = $RegexPattern_NIC_NETSH + '\s+(\S+)'; # Capture the col-4 (State)
$RegexPattern_NIC_NETSH = $RegexPattern_NIC_NETSH + '\s+(.+)'; # Capture col-5 (Name - the remainder at the end of the table, including spaces)
$RegexPattern_NIC_NETSH = $RegexPattern_NIC_NETSH + '$'; # End Regex Pattern

# ------------------------------------------------------------

# Show WLAN (Wi-Fi) network interfaces
$Interfaces_WLAN_NETSH = (netsh.exe wlan show interfaces);

$Interfaces_WLAN_WMIC = (wmic nicconfig where "IPEnabled=True AND TcpipNetbiosOptions!=null AND TcpipNetbiosOptions!=2 AND DHCPServer!=`"255.255.255.255`"" get Description,InterfaceIndex,IPAddress,DefaultIPGateway,IPSubnet,DNSServerSearchOrder,DHCPServer /format:list);

$Profiles_WLAN = (netsh.exe wlan show profiles);

$RegexPattern_WLAN_NETSH_Description = '^\s*Description\s+:\s+(.+)$';
$RegexPattern_WLAN_NETSH_Name = '^\s*Name\s+:\s+(.+)$';
$RegexPattern_WLAN_NETSH_MAC = '^\s*Physical address\s+:\s+(.+)$';
$RegexPattern_WLAN_NETSH_State = '^\s*State\s+:\s+(.+)$';

# ------------------------------------------------------------

$RegexPattern_NIC_WMIC = '^([a-zA-Z]+)=(.*)$';

$Each_NIC_WMIC = @{};

$Interfaces_NIC_WMIC | ForEach {
	$Matches_NIC_WMIC = [Regex]::Match($_, $RegexPattern_NIC_WMIC);
	If ($Matches_NIC_WMIC.Success -Ne $False) {
		$EachKey = $Matches_NIC_WMIC.Groups[1].Value;
		$EachVal = $Matches_NIC_WMIC.Groups[2].Value;
		$Each_NIC_WMIC.($EachKey) = $EachVal;
		If ($EachKey -Eq "WINSSecondaryServer") {
			$Connections_NIC_WMIC += $Each_NIC_WMIC;
			$Each_NIC_WMIC = @{};
		}
	}
}
# WINSSecondaryServer   <- LAST KEY

$Interfaces_NIC_NETSH | ForEach {
	$Matches_NIC_NETSH = [Regex]::Match($_, $RegexPattern_NIC_NETSH);
	If ($Matches_NIC_NETSH.Success -Ne $False) {
		$Idx_NIC = $Matches_NIC_NETSH.Groups[1].Value;
		$State_NIC = $Matches_NIC_NETSH.Groups[4].Value;
		$Name_NIC = $Matches_NIC_NETSH.Groups[5].Value;
		If ($State_NIC -Eq "connected") {
			$Each_NIC = @{};
			$Each_NIC.Idx = $Idx_NIC;
			$Each_NIC.State = $State_NIC;
			$Each_NIC.Name = $Name_NIC;

			$Interfaces_WLAN_NETSH | ForEach {
				$Matches_WLAN_Description = [Regex]::Match($_, $RegexPattern_WLAN_NETSH_Description);
				$Matches_WLAN_Name = [Regex]::Match($_, $RegexPattern_WLAN_NETSH_Name);
				$Matches_WLAN_MAC = [Regex]::Match($_, $RegexPattern_WLAN_NETSH_MAC);
				$Matches_WLAN_State = [Regex]::Match($_, $RegexPattern_WLAN_NETSH_State);
				If ($Matches_WLAN_Description.Success -Ne $False) {
					$Description_WLAN = $Matches_WLAN_Description.Groups[1].Value;
				} ElseIf ($Matches_WLAN_Name.Success -Ne $False) {
					$Name_WLAN = $Matches_WLAN_Name.Groups[1].Value;
				} ElseIf ($Matches_WLAN_MAC.Success -Ne $False) {
					$MAC_WLAN = $Matches_WLAN_MAC.Groups[1].Value;
				} ElseIf ($Matches_WLAN_State.Success -Ne $False) {
					$State_WLAN = $Matches_WLAN_State.Groups[1].Value;
				} 
			}

			If ($Each_NIC.Name -Eq $Name_WLAN) {
				If ($Each_NIC.State -Eq $State_WLAN) {
					$Each_NIC.MAC = $MAC_WLAN;
					$Each_NIC.Description = $Description_WLAN;
					$Connections_WLAN_NETSH += $Each_NIC;
				}
			}
		}
	}

}


# ------------------------------------------------------------

Write-Output "------------------------------------------------------------";
Write-Output "Connections_WLAN_NETSH:";
$Connections_WLAN_NETSH | Format-List;
Write-Output "============================================================";

# ------------------------------------------------------------

Write-Output "------------------------------------------------------------";
Write-Output "Profiles_WLAN:";
$Profiles_WLAN;
Write-Output "============================================================";

# ------------------------------------------------------------

Write-Output "Connections_NIC_WMIC:";
$Connections_NIC_WMIC | ForEach {
	Write-Output "------------------------------------------------------------";
	$_ | Sort-Object "Name" | Format-Table;
	Write-Output "============================================================";
}
$Connections_NIC_WMIC.Length;

# Show Wi-Fi (WLAN) adapters
# netsh.exe wlan show interfaces;

# Show Wi-Fi SSIDs along with how they're currently prioritized
# netsh.exe wlan show profiles;

# netsh.exe wlan show interfaces | FINDSTR /R "^\s*Description\s*:\s*(.+)\n";
#    Description            : Intel(R) Wireless-AC 1234 123MHz

# netsh.exe wlan show profiles;

# NETSH WLAN SET profileorder name="wlan_primary" interface="Wi-Fi 2" priority=1

# NETSH WLAN SET profileorder name="wlan_secondary" interface="Wi-Fi 2" priority=2



# Get-WmiObject -Class Win32_NetworkAdapter -Filter "AdapterType='Ethernet 802.3'" | ForEach { Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "Index=$($_.DeviceId) AND IPEnabled = True" | Select Description,IPConnectionMetric,IPAddress | Format-Table -AutoSize}

# Get-WmiObject -Class "Win32_NetworkAdapter" -Filter "AdapterType='Ethernet 802.3'" | ForEach {
# 	$EachNIC_Filter = "Index=$($_.DeviceId) AND IPEnabled=True AND TcpipNetbiosOptions!=null AND TcpipNetbiosOptions!=2 AND DHCPServer!=`"255.255.255.255`"";
# 	$EachNIC_Description = Get-WmiObject -Class "Win32_NetworkAdapterConfiguration" -Filter "${EachNIC_Filter}" | Select Description;
# 	$EachNIC_InterfaceIndex = Get-WmiObject -Class "Win32_NetworkAdapterConfiguration" -Filter "${EachNIC_Filter}" | Select InterfaceIndex;


# }