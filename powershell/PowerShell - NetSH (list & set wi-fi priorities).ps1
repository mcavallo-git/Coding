
# IN-PROGRESS AS-OF 2019-08-08_17-22-25
# IN-PROGRESS AS-OF 2019-08-12_15-46-39

$NIC_Connections = @();
$WLAN_Connections = @();

# Show all network interfaces
$Interfaces_NIC = (netsh.exe int ipv4 show interfaces);

$RegexPattern_NIC = '';
$RegexPattern_NIC = $RegexPattern_NIC + '^'; # Start Regex Pattern
$RegexPattern_NIC = $RegexPattern_NIC + '\s+([0-9]+)'; # Capture the col-1 (Idx)
$RegexPattern_NIC = $RegexPattern_NIC + '\s+([0-9]+)'; # Capture the col-2 (Met)
$RegexPattern_NIC = $RegexPattern_NIC + '\s+([0-9]+)'; # Capture the col-3 (MTU)
$RegexPattern_NIC = $RegexPattern_NIC + '\s+(\S+)'; # Capture the col-4 (State)
$RegexPattern_NIC = $RegexPattern_NIC + '\s+(.+)'; # Capture col-5 (Name - the remainder at the end of the table, including spaces)
$RegexPattern_NIC = $RegexPattern_NIC + '$'; # End Regex Pattern


# Show WLAN (Wi-Fi) network interfaces
$Interfaces_WLAN = (netsh.exe wlan show interfaces);
$Profiles_WLAN = (netsh.exe wlan show profiles);

$RegexPattern_WLAN_Description = '^\s*Description\s+:\s+(.+)$';
$RegexPattern_WLAN_Name = '^\s*Name\s+:\s+(.+)$';
$RegexPattern_WLAN_MAC = '^\s*Physical address\s+:\s+(.+)$';
$RegexPattern_WLAN_State = '^\s*State\s+:\s+(.+)$';

$Interfaces_NIC | ForEach {
	$Matches_NIC = [Regex]::Match($_, $RegexPattern_NIC);
	If ($Matches_NIC.Success -Ne $False) {
		$Idx_NIC = $Matches_NIC.Groups[1].Value;
		$State_NIC = $Matches_NIC.Groups[4].Value;
		$Name_NIC = $Matches_NIC.Groups[5].Value;
		If ($State_NIC -Eq "connected") {
			$Each_NIC = @{};
			$Each_NIC.Idx = $Idx_NIC;
			$Each_NIC.State = $State_NIC;
			$Each_NIC.Name = $Name_NIC;

			$Interfaces_WLAN | ForEach {
				$Matches_WLAN_Description = [Regex]::Match($_, $RegexPattern_WLAN_Description);
				$Matches_WLAN_Name = [Regex]::Match($_, $RegexPattern_WLAN_Name);
				$Matches_WLAN_MAC = [Regex]::Match($_, $RegexPattern_WLAN_MAC);
				$Matches_WLAN_State = [Regex]::Match($_, $RegexPattern_WLAN_State);
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

					$WLAN_Connections += $Each_NIC;
				}
			}
		}
	}

}


# Show WLAN (Wi-Fi) adapters
Write-Output "------------------------------------------------------------";
Write-Output "WLAN_Connections:";
$WLAN_Connections | Format-List;
Write-Output "============================================================";


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