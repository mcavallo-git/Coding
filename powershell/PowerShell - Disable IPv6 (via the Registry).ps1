# ------------------------------------------------------------
#
# Windows - Disable IPv6 via the Registry
#
# ------------------------------------------------------------
If ($False) { # RUN THIS SCRIPT REMOTELY


$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "ByPass" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/PowerShell%20-%20Disable%20IPv6%20(via%20the%20Registry).ps1')); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;


}
# ------------------------------------------------------------
#
# Ask user if they wish to disable IPv6 Networking for this machine
#

Write-Output "Info:  Disable IPv6 Networking to/from this Machine? (y/n)";
$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
If ($KeyPress.Character -Eq "y") {
	Write-Output "Info:  Confirmed - Disabling IPv6....";
	<# If the previous ping command responds with an IPv6 address (such as ::1), run following registry setting to disable IPv6 via the Registry --> reboot for the change to take effect #>
	Set-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" -Name "DisabledComponents"  -Type "DWord" -Value 0x20;
	<# Restore the previously-defined networking security protocol #>
	[System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
	<# Check for pending reboot #>
	$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "ByPass" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/CheckPendingRestart/CheckPendingRestart.psm1')); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
	CheckPendingRestart;
} Else {
	Write-Output "Info:  Skipped IPv6 Networking - NO CHANGES MADE";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   msunified.net  |  "How to set IPv4 as preferred IP on Windows Server using PowerShell – msunified.net"  |  https://msunified.net/2016/05/25/how-to-set-ipv4-as-preferred-ip-on-windows-server-using-powershell/
#
# ------------------------------------------------------------