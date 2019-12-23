#
#	PowerShell - WakeOnLAN
#		|
#		|--> Description:  Sends a Wake-on-LAN Magic Packet to a MAC Address which is specified by the user at runtime
#		|
#		|--> Example:     PowerShell -Command ("Show `$MyInvocation -Methods")
#
Function WakeOnLAN() {
	Param(
		[Parameter(Position=0, ValueFromRemainingArguments)]$mac # Address of the network card (MAC address)
	)

	# Validate the Syntax of the user-defined MAC Address
	If (!(($mac -Like "*:*:*:*:*:*") -Or ($mac -Like "*-*-*-*-*-*"))){
		$Example_MAC="A6:B5:C4:D3:E2:F1";
		Write-Error "Error:  Invalid syntax used for method `"$($MyInvocation.MyCommand.Name)`" - Please call using syntax similar to:  [ `"$($MyInvocation.MyCommand.Name)`" `"${Example_MAC}`"; ]";
		Start-Sleep 10;

	} Else {
		# Build Magic Packet http://en.wikipedia.org/wiki/Wake-on-LAN#Magic_packet
		$split_mac=@($mac.Split(":""-") | ForEach {$_.Insert(0,"0x")});
		$mac_byte_array = [Byte[]]($split_mac[0], $split_mac[1], $split_mac[2], $split_mac[3], $split_mac[4], $split_mac[5]);

		# The Magic Packet is a broadcast frame containing anywhere within its payload 6 bytes of all 255 (FF FF FF FF FF FF in hexadecimal) ...
		$magic_packet = [Byte[]](,0xFF * 102);

		# ... Followed by sixteen repetitions of the target computer's 48-bit MAC address, for a total of 102 bytes.
		6..101 |% { $magic_packet[$_] = $mac_byte_array[($_%6)]};

		# .NET framework lib para sockets
		$UDPclient = New-Object System.Net.Sockets.UdpClient;
		$UDPclient.Connect(([System.Net.IPAddress]::Broadcast),4000);
		$UDPclient.Send($magic_packet, $magic_packet.Length) | Out-Null;

	}

	Return;

}
Export-ModuleMember -Function "WakeOnLAN";
# Install-Module -Name "WakeOnLAN"


# ------------------------------------------------------------
#
# Citation(s)
#
#   community.spiceworks.com  |  "WOL from command line not working"  |  https://community.spiceworks.com/topic/538390-wol-from-command-line-not-working?page=1#entry-3540406
#
# ------------------------------------------------------------