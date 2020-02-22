# ------------------------------------------------------------
#
# VMware PowerCLI - Install NuGet Repo & VMware PowerCLI PowerShell Module, then connect to a target vSphere (ESXi) Server & create a VM
#

If ($True) {

# Install [ NuGet ] PowerShell Module-Repo (if not found locally)
If ((Get-PackageProvider -Name "NuGet" -ErrorAction "SilentlyContinue") -Eq $Null) {
Install-PackageProvider -Name ("NuGet") -Force;
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
#   docs.microsoft.com  |  "Clear-Variable - Deletes the value of a variable"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/clear-variable
#
#   powercli-core.readthedocs.io  |  "Add-VMHost"  |  https://powercli-core.readthedocs.io/en/latest/cmd_add.html#add-vmhost
#
#   powercli-core.readthedocs.io  |  "Connect-VIServer"  |  https://powercli-core.readthedocs.io/en/latest/cmd_connect.html#connect-viserver
#
#   powercli-core.readthedocs.io  |  "Disconnect-VIServer"  |  https://powercli-core.readthedocs.io/en/latest/cmd_disconnect.html#disconnect-viserver
#
# ------------------------------------------------------------