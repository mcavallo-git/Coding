# ------------------------------------------------------------
#
# Windows - Disable IPv6 via the Registry
#
# ------------------------------------------------------------

Break #In case you paste this in to PowerShell ISE and press run script:)

# Check if IPv4 IP address is preferred
Ping $Env:COMPUTERNAME;

# If the previous ping command responds with an IPv6 address (such as ::1), run following registry setting to disable IPv6 via the Registry --> reboot to apply the change
New-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\" -Name "DisabledComponents" -Value 0x20 -PropertyType "DWord";

# If DisabledComponents exists, use the set cmdlet
Set-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\" -Name "DisabledComponents" -Value 0x20;

# Write-Host "You need to reboot the computer in order for the changes to take effect";
# Restart-Computer
$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "ByPass" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/CheckPendingRestart/CheckPendingRestart.psm1')); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
CheckPendingRestart;


# ------------------------------------------------------------
#
# Citation(s)
#
#   msunified.net  |  "How to set IPv4 as preferred IP on Windows Server using PowerShell – msunified.net"  |  https://msunified.net/2016/05/25/how-to-set-ipv4-as-preferred-ip-on-windows-server-using-powershell/
#
# ------------------------------------------------------------