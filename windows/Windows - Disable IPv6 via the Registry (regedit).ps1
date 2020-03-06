# ------------------------------------------------------------
#
# Windows - Disable IPv6 via the Registry
#
# ------------------------------------------------------------

Break #In case you paste this in to PowerShell ISE and press run script:)

# Check if IPv4 IP address is preferred
Ping $env:COMPUTERNAME;

# If the reply is IPv6 address, run following registry setting to just prefer ipv4 and reboot
New-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\" -Name "DisabledComponents" -Value 0x20 -PropertyType "DWord";

# If DisabledComponents exists, use the set cmdlet
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\" -Name "DisabledComponents" -Value 0x20;

Write-Host "You need to reboot the computer in order for the changes to take effect";
# Restart-Computer


# ------------------------------------------------------------
#
# Citation(s)
#
#   msunified.net  |  "How to set IPv4 as preferred IP on Windows Server using PowerShell – msunified.net"  |  https://msunified.net/2016/05/25/how-to-set-ipv4-as-preferred-ip-on-windows-server-using-powershell/
#
# ------------------------------------------------------------