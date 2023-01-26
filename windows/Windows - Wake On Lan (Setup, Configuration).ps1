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
# Test Wake on LAN capability using mobile device to send WoL signal
#

> Replace the the value of "A1:B2:C3:D4:E5:F6" below with the MAC address of the primary network adapter (configured above)

> Run the script in a PowerShell terminal (after string has been replaced)

sv mac (write A1:B2:C3:D4:E5:F6); sv split_mac (@(((gv mac).Value).split((write :)) | foreach {((gv _).Value).insert(0,(write 0x))})); sv mac_byte_array ([Byte[]](((gv split_mac).Value)[0],((gv split_mac).Value)[1],((gv split_mac).Value)[2],((gv split_mac).Value)[3],((gv split_mac).Value)[4],((gv split_mac).Value)[5])); sv magic_packet ([Byte[]](,0xFF * 102)); 6..101 | ForEach-Object { ((gv magic_packet).Value)[((gv _).Value)] = ((gv mac_byte_array).Value)[(((gv _).Value)%6)]}; sv UDPclient (New-Object System.Net.Sockets.UdpClient); ((gv UDPclient).Value).Connect(([System.Net.IPAddress]::Broadcast),4000); ((gv UDPclient).Value).Send(((gv magic_packet).Value), ((gv magic_packet).Value).Length) | Out-Null;

> Note that this syntax intentionally does not use quotes (double or single), and can be easily incorporated into a scheduled task


# ------------------------------
#
# Test Wake on LAN capability from another Windows computer
#

Download an app such as "Wolow" for iOS or "Wake On Lan" for Android

> Set "Name" to the hostname of the WoL device
 
> Set "MAC Address" to the MAC address of the primary network adapter (configured above)
 
> Set "Broadcast Address" to the broadcast address of the current network (if in a /24 subnet, it will be x.x.x.255, such as 192.168.1.255 or 10.0.0.255, depending on your subnet IP range)

> Set "IP Address" to the IP address of your device (ideally set as static via the router/DHCP server)

> Set "wake on LAN port" to "7"


Fire away - Shut down your computer and test the Wake on LAN (WoL) functionality by sending a magic packet and seeing if it wakes your device


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