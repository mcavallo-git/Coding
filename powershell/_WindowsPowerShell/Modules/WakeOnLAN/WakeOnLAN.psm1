#
#	PowerShell - WakeOnLAN
#		|
#		|--> Description:  Sends a Wake-on-LAN Magic Packet to a MAC Address which is specified by the user at runtime
#		|
#		|--> Example:     PowerShell -Command ("Show `$MyInvocation -Methods")
#
Function WakeOnLAN() {
	Param(
		[Parameter(Position=0, ValueFromRemainingArguments)]$MAC # Address of the network card (MAC address)
	)

	# Validate the Syntax of the user-defined MAC Address
	If (!(($MAC -Like "*:*:*:*:*:*") -Or ($MAC -Like "*-*-*-*-*-*"))){
		Write-Error "Error:  Invalid syntax for call to MAC address not in correct format";
		Start-Sleep 10;

	} Else {
		# Build Magic Packet http://en.wikipedia.org/wiki/Wake-on-LAN#Magic_packet
		$string=@($MAC.Split(":""-") | ForEach {$_.Insert(0,"0x")});
		$target = [Byte[]]($string[0], $string[1], $string[2], $string[3], $string[4], $string[5]);

		# The Magic Packet is a broadcast frame containing anywhere within its payload 6 bytes of all 255 (FF FF FF FF FF FF in hexadecimal) ...
		$packet = [Byte[]](,0xFF * 102);

		# ... Followed by sixteen repetitions of the target computer's 48-bit MAC address, for a total of 102 bytes.
		6..101 |% { $packet[$_] = $target[($_%6)]};

		# .NET framework lib para sockets
		$UDPclient = New-Object System.Net.Sockets.UdpClient;
		$UDPclient.Connect(([System.Net.IPAddress]::Broadcast),4000);
		$UDPclient.Send($packet, $packet.Length) | Out-Null;

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