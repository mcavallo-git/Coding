' ------------------------------------------------------------
'
' Create a Scheduled Task (which targets this script) by using the following values:
'
'   Name/Description:
'     WakeOnLan__ServerName   <-- Replace 'ServerName' with the server to Wake
'
'   Security Options:
'     When running the task, use the following user account:
'       SYSTEM
'     Run only when user is logged on (UN-CHECKED)
'     Run whether user is logged on or not (CHECKED)
'     Run with highest privileges (UN-CHECKED)
'
'   Trigger:
'     On a schedule
'       At 04:04:04 every day - Recur every 1 days
'
'   Action:
'     Program/script:   C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
'     Add arguments:    -Command "Start-Process -Filepath ((gcm powershell).Source) -ArgumentList ('-Command sv mac (write ___MAC_HERE___); sv split_mac (@(((gv mac).Value).split((write :)) | foreach {((gv _).Value).insert(0,(write 0x))})); sv mac_byte_array ([Byte[]](((gv split_mac).Value)[0],((gv split_mac).Value)[1],((gv split_mac).Value)[2],((gv split_mac).Value)[3],((gv split_mac).Value)[4],((gv split_mac).Value)[5])); sv magic_packet ([Byte[]](,0xFF * 102)); 6..101 | ForEach-Object { ((gv magic_packet).Value)[((gv _).Value)] = ((gv mac_byte_array).Value)[(((gv _).Value)%6)]}; sv UDPclient (New-Object System.Net.Sockets.UdpClient); ((gv UDPclient).Value).Connect(([System.Net.IPAddress]::Broadcast),4000); ((gv UDPclient).Value).Send(((gv magic_packet).Value), ((gv magic_packet).Value).Length) | Out-Null;') -Wait -PassThru | Out-Null;"
'
' ------------------------------
'
'   Note(s):
'     - In the arguments section, replace [ ___MAC_HERE___ ] with the MAC address of the device to wake on LAN in format [ XX:XX:XX:XX:XX:XX ]
'
' ------------------------------------------------------------