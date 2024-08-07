# ------------------------------------------------------------
# Windows - Wake On Lan (Setup, Configuration).ps1
# ------------------------------------------------------------

#
# Enable Wake on LAN - Step 1 - UEFI/BIOS
#

UEFI/BIOS > "Advanced" (tab) > "APM Configuration" (submenu) > Set option "Power On By PCI-E" to "Enabled"


#
# Enable Wake on LAN - Step 2 - Windows
#

Open the Start Menu

 > Type "ncpa.cpl" and hit enter to open "Network Connections"

  > Right-Click your primary network adapter (should be active with a "Network" connection)

   > Click "Properties"

    > Click "Configure" (top right of "Networking" tab)

     > Select tab "Advanced" (top left)
      > Set property "Enable PME" to "Enabled"
      > Set property "Wake on Magic Packet" to "Enabled"

     > Select tab "Power Management" (top right)
      > Check option "Allow this device to wake the computer"

    > Click "OK" (bottom)


# ------------------------------
#
# Test Wake on LAN using configuration via [ a separate Windows PC ]
#

#   1) Get the MAC address of the NIC (to be awoken) - Use it to replace "A1:B2:C3:D4:E5:F6" in the below powershell oneliner

#   2) Shut down the PC, then attempt to wake it by sending a magic packet over the LAN via the following PowerShell script:

sv mac (write A1:B2:C3:D4:E5:F6); sv split_mac (@(((gv mac).Value).split((write :)) | foreach {((gv _).Value).insert(0,(write 0x))})); sv mac_byte_array ([Byte[]](((gv split_mac).Value)[0],((gv split_mac).Value)[1],((gv split_mac).Value)[2],((gv split_mac).Value)[3],((gv split_mac).Value)[4],((gv split_mac).Value)[5])); sv magic_packet ([Byte[]](,0xFF * 102)); 6..101 | ForEach-Object { ((gv magic_packet).Value)[((gv _).Value)] = ((gv mac_byte_array).Value)[(((gv _).Value)%6)]}; sv UDPclient (New-Object System.Net.Sockets.UdpClient); ((gv UDPclient).Value).Connect(([System.Net.IPAddress]::Broadcast),4000); ((gv UDPclient).Value).Send(((gv magic_packet).Value), ((gv magic_packet).Value).Length) | Out-Null;

### ^  Note that this syntax intentionally does not use quotes (double or single), and can be easily incorporated into a scheduled task

# ------------------------------
#
# Test Wake on LAN using configuration via [ a mobile device ]
#
#   1) Download a Wake on LAN app on your mobile device - A decent Wake on LAN app for iOS is "Wolow"
#
#   2) Setup a Wake on Lan device on the mobile app with the following:
#        Device Name = [ Nickname of device to wake ]
#        MAC Address = [ MAC address of the NIC to wake ]
#        IP Address = [ Broadcast address of the NIC to wake's network ]  (if in a /24 subnet, it will be x.x.x.255, such as 192.168.0.255, 172.16.0.255 or 10.0.0.255, depending on your subnet IP range)
#        IP Address = [ LAN IPv4 address of the NIC to wake ]  (ideally set this to static in router/DHCP server)
#        Wake on LAN port = [ 7 ]  (magic packet port - some devices use port 9 instead of 7)
#
#   3) Shut down the PC, then attempt to wake it by sending a magic packet over the LAN via your mobile app
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   documentation.n-able.com  |  "Wake on LAN"  |  https://documentation.n-able.com/remote-management/userguide/Content/wake_on_lan.htm
#
#   learn.microsoft.com  |  "Unwanted wake-up events when you enable WOL - Windows Client | Microsoft Learn"  |  https://learn.microsoft.com/en-us/troubleshoot/windows-client/networking/unwanted-wake-up-events
#
#   www.asus.com  |  "[Motherboard]How to set and enable WOL(Wake On Lan) function in BIOS | Official Support | ASUS Global"  |  https://www.asus.com/support/FAQ/1045950/
#
#   www.pcreview.co.uk  |  "Enable PME | PC Review"  |  https://www.pcreview.co.uk/threads/enable-pme.453170/
#
# ------------------------------------------------------------