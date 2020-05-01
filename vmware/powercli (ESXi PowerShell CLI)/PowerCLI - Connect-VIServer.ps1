# ------------------------------------------------------------
#
# VMware PowerCLI - Install NuGet Repo & VMware PowerCLI PowerShell Module, then connect to a target vSphere (ESXi) Server & create a VM
#

If ($True) {

# Install [ NuGet ] PowerShell Module-Repo (if not found locally)
$PackageProvider = "NuGet";
If ((Get-PackageProvider -Name "${PackageProvider}" -ErrorAction "SilentlyContinue") -Eq $Null) {
	$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol;
	[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]'Tls11,Tls12';
		Install-PackageProvider -Name ("${PackageProvider}") -Force -Confirm:$False; $InstallPackageProvider_ReturnCode = If($?){0}Else{1};  # Install-PackageProvider fails on default windows installs without at least TLS 1.1 as of 20200501T041624
	[System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
}

# Install [ VMware PowerCLI ] Module (if not found locally)
If ((Get-Module -ListAvailable -Name ("VMware.PowerCLI") -ErrorAction "SilentlyContinue") -Eq $Null) {
Install-Module -Name ("VMware.PowerCLI") -Scope CurrentUser -Force;
}

# Ignore Invalid HTTPS Certs (for LAN servers, etc.)
Set-PowerCLIConfiguration -InvalidCertificateAction "Ignore" -Confirm:$False;

$vSphere_ConnectionStream = Connect-VIServer -Server ($(Read-Host 'Enter FQDN/IP of vSphere Server')) -Port "443" -Protocol "https";

If ($vSphere_ConnectionStream -NE $Null) {

# Do some action with the now-connected vSphere Hypervisor (ESXi Server) 
Get-Datastore | Format-List;

}

Disconnect-VIServer "*" -Confirm:$False;

}


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