

If ($True) {
$vSphere_Server=(Read-Host "Enter FQDN/IP of vSphere Server");  # DNS name (Fully Qualified Domain Name) or IP address of the vCenter Server system which will have the new VM host added to it
$vSphere_Datastore=(Read-Host "Enter Name of vSphere Datastore");  # Specifies a datacenter or folder where you want to place the host
$VM_Name=(Read-Host "Enter Name for the new VM");  # Sets the VM Title/Name and Datastore directory name
$vSphere_User = (Read-Host "Enter vSphere Login-Username");
$vSphere_Pass = ([System.Runtime.InteropServices.Marshal]::PtrToStringUni([System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($(Read-Host -AsSecureString "Enter vSphere Login-Password"))));
$vSphere_ConnectionStream = Connect-VIServer -Server ${vSphere_Server};
Add-VMHost -Server ${vSphere_ConnectionStream} -Name ${VM_Name} -Location ${vSphere_Datastore} -User ${vSphere_User} -Password ${vSphere_Pass};
Clear-Variable -Name "vSphere_Pass" -Force;
Clear-Variable -Name "vSphere_User" -Force;
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Clear-Variable - Deletes the value of a variable"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/clear-variable
#
#   powercli-core.readthedocs.io  |  "Connect Commands — PowerCLI Core latest documentation"  |  https://powercli-core.readthedocs.io/en/latest/cmd_connect.html#connect-viserver
#
#   powercli-core.readthedocs.io  |  "Add Commands — PowerCLI Core latest documentation"  |  https://powercli-core.readthedocs.io/en/latest/cmd_add.html#add-vmhost
#
# ------------------------------------------------------------