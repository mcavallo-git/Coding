
<# Check for pending reboot #>
$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "ByPass" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/CheckPendingRestart/CheckPendingRestart.psm1')); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
CheckPendingRestart;


# ------------------------------------------------------------
#
# Citation(s)
#
#   adamtheautomator.com  |  "How to check for a pending reboot (automated with PowerShell)"  |  https://adamtheautomator.com/pending-reboot-registry-windows/
#
# ------------------------------------------------------------