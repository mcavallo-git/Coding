# ------------------------------------------------------------
#
#   Windows Server 2016 - Enable Remote Desktop (Incoming)
#
# ------------------------------------------------------------

If ($False) { # Download this script from GitHub, Run it, then Clean-up/Remove the temporary downloaded script-file

Set-ExecutionPolicy -ExecutionPolicy "Bypass" -Scope "CurrentUser" -Force; $SyncTemp="${Env:TEMP}\Enable-IIS-FTP-Features.$($(Date).Ticks).ps1"; New-Item -ItemType "File" -Path ("${SyncTemp}") -Value (($(New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/PowerShell%20-%Enable-Remote-Desktop.ps1?t=$((Date).Ticks)"))) | Out-Null; . "${SyncTemp}"; Remove-Item "${SyncTemp}";


}


Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\' -Name "fDenyTSConnections" -Value 0; # Enable Remote Desktop connections

Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\' -Name "UserAuthentication" -Value 1; # Enable Network Level Authentication

Enable-NetFirewallRule -DisplayGroup "Remote Desktop"; # Enable the [ Inbound rule for the Remote Desktop service to allow RDP traffic ]


# Get-NetFirewallRule -DisplayGroup "Remote Desktop"; # Get the status of the [ Inbound rule for the Remote Desktop service to allow RDP traffic ]

# Add-LocalGroupMember -Group "Remote Desktop Users" -Member "foo"; # Grant RDP access a non-admin user


# ------------------------------------------------------------
# Citation(s)
#
#   docs.microsoft.com  |  "Disable-NetFirewallRule - Disables a firewall rule"  |  https://docs.microsoft.com/en-us/powershell/module/netsecurity/disable-netfirewallrule
#
#   docs.microsoft.com  |  "Enable-NetFirewallRule - Enables a previously disabled firewall rule"  |  https://docs.microsoft.com/en-us/powershell/module/netsecurity/enable-netfirewallrule
#
#   docs.microsoft.com  |  "Get-NetFirewallRule - Retrieves firewall rules from the target computer"  |  https://docs.microsoft.com/en-us/powershell/module/netsecurity/get-netfirewallrule
#
#   exchangepedia.com  |  "Enable remote desktop (RDP) connections for admins on Windows Server 2016"  |  https://exchangepedia.com/2016/10/enable-remote-desktop-rdp-connections-for-admins-on-windows-server-2016.html
#
# ------------------------------------------------------------