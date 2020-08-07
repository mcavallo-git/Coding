# ------------------------------------------------------------
#
# PRTG Network Monitor - Network Port Used
#  |
#  |--> FULL LIST OF SERVICE PORTS  @  https://kb.paessler.com/en/topic/61462-which-ports-does-prtg-use-on-my-system
#
# ------------------------------------------------------------

If ($True) {
	<# Create a rule to allow 80/443 through the firewall#> New-NetFirewallRule -DisplayName "HTTP,HTTPS Web Server Whitelisting (TCP 80,443)" -Description "HTTP,HTTPS - Allow Inbound TCP Traffic on Port(s) 80,443" -Direction ("Inbound") -Action ("Allow") -EdgeTraversalPolicy ("Allow") -Protocol ("TCP") -LocalPort (80,443) -Profile ("Private,Domain");
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