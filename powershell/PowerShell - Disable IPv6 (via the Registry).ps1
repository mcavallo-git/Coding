# ------------------------------------------------------------
#
# Windows - Disable IPv6 via the Registry
#
# ------------------------------------------------------------
If ($False) { # RUN THIS SCRIPT REMOTELY


$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "ByPass" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/PowerShell%20-%20Disable%20IPv6%20(via%20the%20Registry).ps1')); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;


}
# ------------------------------------------------------------
#
# Ask user if they wish to disable IPv6 Networking for this machine
#

If ($True) {
  Write-Output "";
  Write-Output "Networking Protocols:  Select one of the following options by pressing the number key corresponding to your intended configuration:";
  Write-Output "";
  Write-Output "  1  -  Prefer IPv4 over IPv6";  <# 0x00000020 #>
  Write-Output "  2  -  Disable IPv6 on all interfaces";   <# 0x000000FF #>
  Write-Output "  3  -  Disable IPv6 on tunnel interfaces";   <# 0x00000001 #>
  Write-Output "  4  -  Disable IPv6 on nontunnel interfaces";   <# 0x00000010 #>
  Write-Output "  5  -  Disable IPv6 on nontunnel interfaces (except the loopback) and on IPv6 tunnel interface";   <# 0x00000011 #>
  # Write-Output "    Z - Prefer IPv6 over IPv4 in prefix policies";   <# 0x000000ZZ #>
  # Write-Output "    Z - Enable IPv6 on all nontunnel interfaces"; <# 0x000000ZZ #>
  # Write-Output "    Z - Enable IPv6 on all tunnel interfaces";   <# 0x000000ZZ #>
  # Write-Output "    Z - Enable IPv6 on nontunnel interfaces and on IPv6 tunnel interfaces";   <# 0x000000ZZ #>
  Write-Output "";
  $KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
  $KeyChar = $KeyPress.Character;
  If (@("1","2","3","4","5") -contains ($KeyChar)) {
    [UInt32]$DisabledComponents_HexVal = If ("${KeyChar}" -Eq "1") { 0x00000020 } ElseIf ("${KeyChar}" -Eq "2") { 0x000000FF } ElseIf ("${KeyChar}" -Eq "3") { 0x00000001 } ElseIf ("${KeyChar}" -Eq "4") { 0x00000010 } ElseIf ("${KeyChar}" -Eq "5") { 0x00000011 };
    Write-Output "Info:  Confirmed - Disabling IPv6....";
    <# If the previous ping command responds with an IPv6 address (such as ::1), run following registry setting to disable IPv6 via the Registry --> reboot for the change to take effect #>
    Set-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" -Name "DisabledComponents"  -Type "DWord" -Value (${DisabledComponents_HexVal});
    <# Restore the previously-defined networking security protocol #>
    [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
    <# Check for pending reboot #>
    $ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "ByPass" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/CheckPendingRestart/CheckPendingRestart.psm1')); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
    CheckPendingRestart;
  } Else {
    Write-Output "Info:  Skipped network changes - NO CHANGES MADE";
  }
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   msunified.net  |  "How to set IPv4 as preferred IP on Windows Server using PowerShell – msunified.net"  |  https://msunified.net/2016/05/25/how-to-set-ipv4-as-preferred-ip-on-windows-server-using-powershell/
#
#   support.microsoft.com  |  "Guidance for configuring IPv6 in Windows for advanced users"  |  https://support.microsoft.com/en-us/help/929852/guidance-for-configuring-ipv6-in-windows-for-advanced-users
#
# ------------------------------------------------------------