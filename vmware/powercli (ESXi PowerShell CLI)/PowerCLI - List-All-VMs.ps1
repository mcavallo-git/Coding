# ------------------------------------------------------------
#
# VMware PowerCLI - Install NuGet Repo & VMware PowerCLI PowerShell Module, then connect to a target vSphere (ESXi) Server & create a VM
#

If ($True) {



	If ($args -NE $Null) {
		If ($args.Contains('-All')) {
			$LatestLogOnly = $False;
		}
		If ($args.Contains('-PRTG')) {
			$PRTG_Request = $True;
			$API_Request = $True;
		}
	}

	# Pre-Reqs: Check-for (and install if not found) the VMware PowerCLI PowerShell Module
	If ((Get-Module -ListAvailable -Name ("VMware.PowerCLI") -ErrorAction "SilentlyContinue") -Eq $Null) {
		# Pre-Reqs: Check-for (and install if not found) the NuGet PowerShell Module-Repository
		$PackageProvider = "NuGet";
		If ((Get-PackageProvider -Name "${PackageProvider}" -ErrorAction "SilentlyContinue") -Eq $Null) {
			$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol;
			[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12;
				Install-PackageProvider -Name ("${PackageProvider}") -Force -Confirm:$False; $InstallPackageProvider_ReturnCode = If($?){0}Else{1};  # Install-PackageProvider fails on default windows installs without at least TLS 1.1 as of 20200501T041624
			[System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
		}
		Install-Module -Name ("VMware.PowerCLI") -Scope CurrentUser -Force;
	}

	# Ignore Invalid HTTPS Certs (for LAN servers, etc.)
	Set-PowerCLIConfiguration -InvalidCertificateAction "Ignore" -Confirm:$False;

	$vSphere_ConnectionStream = Connect-VIServer -Server ($(Read-Host 'Enter FQDN/IP of vSphere Server')) -Port "443" -Protocol "https";

	If ($vSphere_ConnectionStream -NE $Null) {

		# Do some action with the now-connected vSphere Hypervisor (ESXi Server) 

		Get-VM | Sort-Object -Property Name | Format-Table -Autosize

	}

	Disconnect-VIServer "*" -Confirm:$False;

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   powercli-core.readthedocs.io  |  "Connect-VIServer"  |  https://powercli-core.readthedocs.io/en/latest/cmd_connect.html#connect-viserver
#
#   powercli-core.readthedocs.io  |  "Disconnect-VIServer"  |  https://powercli-core.readthedocs.io/en/latest/cmd_disconnect.html#disconnect-viserver
#
#   pubs.vmware.com  |  "Connect-VIServer - vSphere PowerCLI Cmdlets Reference"  |  https://pubs.vmware.com/vsphere-51/index.jsp?topic=%2Fcom.vmware.powercli.cmdletref.doc%2FConnect-VIServer.html
#
#   pubs.vmware.com  |  "Disconnect-VIServer - vSphere PowerCLI Cmdlets Reference"  |  https://pubs.vmware.com/vsphere-51/index.jsp?topic=%2Fcom.vmware.powercli.cmdletref.doc%2FDisconnect-VIServer.html
#
#   pubs.vmware.com  |  "Get-VM - vSphere PowerCLI Cmdlets Reference"  |  https://pubs.vmware.com/vsphere-51/index.jsp?topic=%2Fcom.vmware.powercli.cmdletref.doc%2FGet-VM.html
#
#   pubs.vmware.com  |  "Get-VMHost - vSphere PowerCLI Cmdlets Reference"  |  https://pubs.vmware.com/vsphere-51/index.jsp?topic=%2Fcom.vmware.powercli.cmdletref.doc%2FGet-VMHost.html
#
# ------------------------------------------------------------