#
# PowerShell - WakeOnLAN
#   |
#   |--> Description:  Sends a Wake-on-LAN Magic Packet to a MAC Address which is specified by the user at runtime
#   |
#   |--> Example:     WakeOnLAN 'A1:B2:C3:D4:E5:F6';
#
Function WakeOnLAN() {
  Param(
    <# Address of the network card (MAC address) #>
    [Parameter(Position=0, ValueFromRemainingArguments)]$mac
  )
  # ------------------------------------------------------------
  If ($False) { # RUN THIS SCRIPT:

    $ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/WakeOnLAN/WakeOnLAN.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'WakeOnLAN' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\WakeOnLAN\WakeOnLAN.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
    WakeOnLAN 'A1:B2:C3:D4:E5:F6';

  }
  # ------------------------------------------------------------
  # Validate the Syntax of the user-defined MAC Address
  If (!(($mac -Like "*:*:*:*:*:*") -Or ($mac -Like "*-*-*-*-*-*"))) {
    $Example_MAC="A1:B2:C3:D4:E5:F6";
    Write-Error "Error:  Invalid syntax used for method `"$($MyInvocation.MyCommand.Name)`" - Please call using syntax similar to:  [ `"$($MyInvocation.MyCommand.Name)`" `"${Example_MAC}`"; ]  <# replacing `"${Example_MAC}`" with the MAC address of your device to wake #>";
    Start-Sleep 10;

  } Else {
    Write-Output "Attempting to Wake MAC Address `"${mac}`"";

    # Build Magic Packet http://en.wikipedia.org/wiki/Wake-on-LAN#Magic_packet
    $split_mac=@($mac.split($(If ($mac -Like "*:*:*:*:*:*") { ":" } Else { "-" })) | foreach {$_.insert(0,"0x")});
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

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
  Export-ModuleMember -Function "WakeOnLAN";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   community.spiceworks.com  |  "WOL from command line not working"  |  https://community.spiceworks.com/topic/538390-wol-from-command-line-not-working?page=1#entry-3540406
#
# ------------------------------------------------------------