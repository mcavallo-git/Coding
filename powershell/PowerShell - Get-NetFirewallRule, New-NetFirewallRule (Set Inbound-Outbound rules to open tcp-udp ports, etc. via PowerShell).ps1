# ------------------------------------------------------------
#
# PowerShell - Get-NetFirewallRule, New-NetFirewallRule (Set Inbound-Outbound rules to open tcp-udp ports, etc. via PowerShell)
#
# ------------------------------------------------------------


Get-NetFirewallRule -All;


<# Create a new firewall rule to allow 9000 (Minio) service through #>
New-NetFirewallRule -DisplayName "MinIO - Allow Inbound TCP Traffic on Port(s) 9000" -Direction Inbound -Action Allow -EdgeTraversalPolicy Allow -Protocol TCP -LocalPort 9000;

<# Create a firewall rule to allow 21 (FTP) through #> 
New-NetFirewallRule -DisplayName "FTP - Allow Inbound TCP Traffic on Port(s) 21" -Direction Inbound -Action Allow -EdgeTraversalPolicy Allow -Protocol TCP -LocalPort 21;

<# Create a firewall rule to allow 80 & 443 (HTTP, HTTPS) through #> 
New-NetFirewallRule -DisplayName "HTTP,HTTPS - Allow Inbound TCP Traffic on Port(s) 80,443" -Direction Inbound -Action Allow -EdgeTraversalPolicy Allow -Protocol TCP -LocalPort 80,443;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "New-NetFirewallRule - Creates a new inbound or outbound firewall rule and adds the rule to the target computer"  |  https://docs.microsoft.com/en-us/powershell/module/netsecurity/new-netfirewallrule?view=win10-ps
#
#   docs.microsoft.com  |  "Get-NetFirewallRule - Retrieves firewall rules from the target computer"  |  https://docs.microsoft.com/en-us/powershell/module/netsecurity/new-netfirewallrule?view=win10-ps
#
# ------------------------------------------------------------