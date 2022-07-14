# ------------------------------------------------------------
#
# VMware PowerCLI - Connect to a target vSphere Hypervisor (ESXi Server) & create a VM via CLI
#

If ($True) {

# Install [ NuGet ] PowerShell Module-Repo (if not found locally)
$PackageProvider = "NuGet";
If ($null -eq (Get-PackageProvider -Name "${PackageProvider}" -ErrorAction "SilentlyContinue")) {
	$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol;
	[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12;
		Install-PackageProvider -Name ("${PackageProvider}") -Force -Confirm:$False; $InstallPackageProvider_ReturnCode = If($?){0}Else{1};  # Install-PackageProvider fails on default windows installs without at least TLS 1.1 as of 20200501T041624
	[System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
}

# Install [ VMware PowerCLI ] Module (if not found locally)
If ($null -eq (Get-Module -ListAvailable -Name ("VMware.PowerCLI") -ErrorAction "SilentlyContinue")) {
Install-Module -Name ("VMware.PowerCLI") -Scope CurrentUser -Force;
}

# Ignore invalid certs (for LAN servers, etc.)
Set-PowerCLIConfiguration -InvalidCertificateAction "Ignore";

$vSphere_Server=(Read-Host 'Enter FQDN/IP of vSphere Server');  # DNS name (Fully Qualified Domain Name) or IP address of the vCenter Server system which will have the new VM host added to it
$VM_Name=(Read-Host "Enter Name for the new VM");  # Sets the VM Title/Name and Datastore directory name

If ($vSphere_ConnectionStream -NE $Null) {
Disconnect-VIServer -Server ${vSphere_ConnectionStream} -Force;
$vSphere_ConnectionStream = $Null;
}

$vSphere_ConnectionStream = Connect-VIServer -Server "${vSphere_Server}" -Port "443" -Protocol "https";

If ($vSphere_ConnectionStream -NE $Null) {
$vSphere_User = (Read-Host "Enter vSphere Login-Username");
$vSphere_Pass = ([System.Runtime.InteropServices.Marshal]::PtrToStringUni([System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($(Read-Host -AsSecureString "Enter vSphere Login-Password"))));
}

$vSphere_ConnectionStream = Connect-VIServer -Server "${vSphere_Server}" -Port "443" -Protocol "https";

If ($vSphere_ConnectionStream -NE $Null) {

$vSphere_Datastore = Get-Datastore;
Write-Host ""; For ($i = 0; $i -lt $vSphere_Datastore.Count; $i++) { Write-Host " [  $i  ]  $(${vSphere_Datastore}[$i].Name)"; }; Write-Host ""; 
$DatastoreIdx=(Read-Host "Enter the index corresponding to the desired Datastore for this VM");
$Datastore = ($vSphere_Datastore[${DatastoreIdx}]);

If (${Datastore} -NE $Null) {

Add-VMHost -Server ${vSphere_ConnectionStream} -Name ${VM_Name} -Location ${Datastore} -User ${vSphere_User} -Password ${vSphere_Pass};
Clear-Variable -Name "vSphere_Pass" -Force;
Clear-Variable -Name "vSphere_User" -Force;

}

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