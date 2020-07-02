
Connect-VIServer
	-AllLinked ${AllLinked} `
	-Credential ${Credential} `
	-Force ${Force} `
	-Menu ${Menu} `
	-NotDefault ${NotDefault} `
	-Password ${Password} `
	-Port ${Port} `
	-Protocol ${Protocol} `
	-SaveCredentials ${SaveCredentials} `
	-Server ${Server} `
	-Session ${Session} `
	-User ${User} `
;


# ------------------------------------------------------------
#
# Example using Connect-VIServer...
#

$vSphere_ConnectionStream = Connect-VIServer -Server ($(Read-Host 'Enter FQDN/IP of vSphere Server')) -Port "443" -Protocol "https";
If ($vSphere_ConnectionStream -NE $Null) {
	# Do some action with the now-connected vSphere Hypervisor (ESXi Server) 
	Get-VMHost | Format-List;
	Get-VM | Format-List;
}
Disconnect-VIServer "*" -Confirm:$False;


# ------------------------------------------------------------
#
# Citation(s)
#
#
#   powercli-core.readthedocs.io  |  "Connect-VIServer"  |  https://powercli-core.readthedocs.io/en/latest/cmd_connect.html#connect-viserver
#
#   powercli-core.readthedocs.io  |  "Disconnect-VIServer"  |  https://powercli-core.readthedocs.io/en/latest/cmd_disconnect.html#disconnect-viserver
#
# ------------------------------------------------------------