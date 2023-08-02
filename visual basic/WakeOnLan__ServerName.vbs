' ⚠️ Note:  In the arguments section (below), replace "___MAC_HERE___" with the MAC address of the device to send the magic packet (e.g. Wake on LAN packet) to using the format "XX:XX:XX:XX:XX:XX"

'=============================================================
' Open 'Task Scheduler' > 'Create Task' (top right)
'=============================================================
'
'   General:
'
'     Task Name:  WakeOnLan__[ServerName]   <-- Replace 'ServerName' with the server to Wake
'
'     Run as user:  SYSTEM
'
'     ✔️ Run whether user is logged on or not (CHECKED)
'
'     ❌️ Run with highest privileges (UN-CHECKED)
'
'=============================================================
'
'   Trigger:
'
'     At 04:04:04 every day  (no delay, no repeat)
'
'=============================================================
'
'   Action:
'
'     Program/script:
'       C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
'
'     Add arguments:
'       -Command "Start-Process -Filepath ((gcm powershell).Source) -ArgumentList ('-Command sv mac (write ___MAC_HERE___); sv split_mac (@(((gv mac).Value).split((write :)) | foreach {((gv _).Value).insert(0,(write 0x))})); sv mac_byte_array ([Byte[]](((gv split_mac).Value)[0],((gv split_mac).Value)[1],((gv split_mac).Value)[2],((gv split_mac).Value)[3],((gv split_mac).Value)[4],((gv split_mac).Value)[5])); sv magic_packet ([Byte[]](,0xFF * 102)); 6..101 | ForEach-Object { ((gv magic_packet).Value)[((gv _).Value)] = ((gv mac_byte_array).Value)[(((gv _).Value)%6)]}; sv UDPclient (New-Object System.Net.Sockets.UdpClient); ((gv UDPclient).Value).Connect(([System.Net.IPAddress]::Broadcast),4000); ((gv UDPclient).Value).Send(((gv magic_packet).Value), ((gv magic_packet).Value).Length) | Out-Null;') -Wait -PassThru | Out-Null;"
'
'=============================================================
'
'   Conditions:
'
'     ❌️ Start the task only if the computer is on AC power (UN-CHECKED)
'
'       ❌️ Stop if the computer switches to battery power (UN-CHECKED)
'
'=============================================================
'
'   Settings:
'
'     ❌️ Run the task as soon as possible after a scheduled start is missed (UN-CHECKED)
'
'     ✔️ Stop the task if it runs longer than:  [ 1 minute ]
'
'     ✔️ If the running task does not end when requested, force it to stop (CHECKED)
'
'=============================================================