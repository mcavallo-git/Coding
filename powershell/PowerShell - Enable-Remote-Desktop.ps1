# ------------------------------------------------------------
#
#   Windows Server 2016 - Enable Remote Desktop (Incoming)
#
# ------------------------------------------------------------

If ($False) { # Download this script from GitHub, Run it, then Clean-up/Remove the temporary downloaded script-file

Set-ExecutionPolicy -ExecutionPolicy "Bypass" -Scope "CurrentUser" -Force; $SyncTemp="${Env:TEMP}\Enable-IIS-FTP-Features.$($(Date).Ticks).ps1"; New-Item -ItemType "File" -Path ("${SyncTemp}") -Value (($(New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/PowerShell%20-%Enable-Remote-Desktop.ps1?t=$((Date).Ticks)"))) | Out-Null; . "${SyncTemp}"; Remove-Item "${SyncTemp}";


}


# Enable Remote Desktop connections
Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\' -Name "fDenyTSConnections" -Value 0;

# Enable Network Level Authentication
Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\' -Name "UserAuthentication" -Value 1;

# Enable Windows firewall rules to allow incoming RDP
Enable-NetFirewallRule -DisplayGroup "Remote Desktop";

# Allow a given, non-admin user access to remote desktop (administrators are granted access by default)
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "foo";


# ------------------------------------------------------------
# Citation(s)
#
#   exchangepedia.com  |  "Enable remote desktop (RDP) connections for admins on Windows Server 2016"  |  https://exchangepedia.com/2016/10/enable-remote-desktop-rdp-connections-for-admins-on-windows-server-2016.html
#
# ------------------------------------------------------------