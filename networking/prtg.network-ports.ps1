# ------------------------------------------------------------
#
# PRTG Network Monitor - Network Port Used
#  |
#  |--> FULL LIST OF SERVICE PORTS  @  https://kb.paessler.com/en/topic/61462-which-ports-does-prtg-use-on-my-system
#
# ------------------------------------------------------------

If ($True) {
	<# HTTP requests vs the firewall #>  New-NetFirewallRule -DisplayName "Web Servers - HTTP (TCP 80)" -Description "HTTP - Allow Inbound TCP Traffic on Port 80" -Direction ("Inbound") -Action ("Allow") -EdgeTraversalPolicy ("Allow") -Protocol ("TCP") -LocalPort (80) -Profile ("Private,Domain") -Enabled ("False");
	<# HTTPS requests vs the firewall #> New-NetFirewallRule -DisplayName "Web Servers - HTTPS (TCP 443)" -Description "HTTPS - Allow Inbound TCP Traffic on Port 443" -Direction ("Inbound") -Action ("Allow") -EdgeTraversalPolicy ("Allow") -Protocol ("TCP") -LocalPort (443) -Profile ("Private,Domain") -Enabled ("True");
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "New-NetFirewallRule - Creates a new inbound or outbound firewall rule and adds the rule to the target computer"  |  https://docs.microsoft.com/en-us/powershell/module/netsecurity/new-netfirewallrule
#
#   kb.paessler.com  |  "Which ports does PRTG use on my system?"  |  https://kb.paessler.com/en/topic/61462-which-ports-does-prtg-use-on-my-system
#
# ------------------------------------------------------------