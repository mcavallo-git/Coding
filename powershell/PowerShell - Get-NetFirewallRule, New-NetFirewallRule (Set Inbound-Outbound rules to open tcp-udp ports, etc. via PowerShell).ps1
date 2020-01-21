# ------------------------------------------------------------
#
# PowerShell - Get-NetFirewallRule, New-NetFirewallRule (Set Inbound-Outbound rules to open tcp-udp ports, etc. via PowerShell)
#
# ------------------------------------------------------------


Get-NetFirewallRule -All;


<# Create a firewall rule to allow 21 (FTP) through #> 
New-NetFirewallRule -DisplayName "FTP (TCP 21)" -Description "FTP - Allow Inbound TCP Traffic on Port(s) 21" -Direction Inbound -Action Allow -EdgeTraversalPolicy Allow -Protocol TCP -LocalPort 21;


<# Create a firewall rule to allow 80 & 443 (HTTP, HTTPS) through #> 
New-NetFirewallRule -DisplayName "HTTP,HTTPS (TCP 80,443)" -Description "HTTP,HTTPS - Allow Inbound TCP Traffic on Port(s) 80,443" -Direction Inbound -Action Allow -EdgeTraversalPolicy Allow -Protocol TCP -LocalPort 80,443;


<# Create a new firewall rule to allow 9000 (Minio) service through #>
New-NetFirewallRule -DisplayName "Minio (TCP 9000)" -Description "MinIO - Allow Inbound TCP Traffic on Port(s) 9000" -Direction Inbound -Action Allow -EdgeTraversalPolicy Allow -Protocol TCP -LocalPort 9000;


<# Create a new firewall rule to allow 27017 (MongoDB) service through #>
New-NetFirewallRule -DisplayName "MongoDB (TCP 27017)" -Description "MongoDB - Allow Inbound TCP Traffic on Port(s) 27017" -Direction Inbound -Action Allow -EdgeTraversalPolicy Allow -Protocol TCP -LocalPort 27017;


<# Create a new firewall rule to allow 3389 (Microsoft SQL) service through #>
New-NetFirewallRule -DisplayName "GVS Microsoft SQL (TCP 3389)" -Description "Microsoft SQL - Allow Inbound TCP Traffic on Port(s) 3389" -Direction Inbound -Action Allow -EdgeTraversalPolicy Allow -Protocol TCP -LocalPort 3389;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "New-NetFirewallRule - Creates a new inbound or outbound firewall rule and adds the rule to the target computer"  |  https://docs.microsoft.com/en-us/powershell/module/netsecurity/new-netfirewallrule?view=win10-ps
#
#   docs.microsoft.com  |  "Get-NetFirewallRule - Retrieves firewall rules from the target computer"  |  https://docs.microsoft.com/en-us/powershell/module/netsecurity/new-netfirewallrule?view=win10-ps
#
# ------------------------------------------------------------