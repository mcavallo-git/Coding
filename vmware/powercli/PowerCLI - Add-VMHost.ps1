# ------------------------------------------------------------
#
# VMware PowerCLI - Install NuGet Repo & PowerCLI PowerShell Module, then connect to a target vSphere (ESXi) Server & create a VM
#

If ($True) {

If ((Get-PackageProvider -Name "NuGet" -ErrorAction "SilentlyContinue") -Eq $Null) {
Install-PackageProvider -Name ("NuGet") -Force;
}

If ((Get-Module -ListAvailable -Name ("VMware.PowerCLI") -ErrorAction "SilentlyContinue") -Eq $Null) {
Install-Module -Name ("VMware.PowerCLI") -Scope CurrentUser -Force;
}

$vSphere_Server=(Read-Host "Enter FQDN/IP of vSphere Server");  # DNS name (Fully Qualified Domain Name) or IP address of the vCenter Server system which will have the new VM host added to it
$VM_Name=(Read-Host "Enter Name for the new VM");  # Sets the VM Title/Name and Datastore directory name

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

Disconnect-VIServer -Server ${vSphere_ConnectionStream} -Force;

}

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