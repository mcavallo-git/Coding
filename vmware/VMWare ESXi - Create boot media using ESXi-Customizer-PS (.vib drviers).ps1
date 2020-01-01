# ------------------------------------------------------------
#
# VMware ESXI - Create boot media for VMWare ESXI using "ESXi-Customizer-PS" PowerShell script to add .vib files to ESXi.iso (adds drivers to ESXi boot image)
#
# ------------------------------------------------------------
If ($False) { # RUN THIS SCRIPT:


. "${Home}\Documents\GitHub\Coding\vmware\VMWare ESXi - Create boot media using ESXi-Customizer-PS (.vib drviers).ps1";


}
# ------------------------------------------------------------


# PowerShell - Install the NuGet package manager
Install-PackageProvider -Name ("NuGet") -Force;


# PowerShell - Install VMware PowerCLI module
If (!(Get-Module -ListAvailable -Name ("VMware.PowerCLI"))) {
	Install-Module -Name ("VMware.PowerCLI") -Scope ("CurrentUser") -Force;
}


# Set the current user's Desktop as the working directory
Set-Location "${Home}\Desktop";


# Download and run the ESXi-Customizer
New-Item -Path ("${Home}\Desktop\ESXi-Customizer-PS-v2.6.0.ps1") -Value (($(New-Object Net.WebClient).DownloadString("https://vibsdepot.v-front.de/tools/ESXi-Customizer-PS-v2.6.0.ps1"))) | Out-Null;


# Create the latest ESXi 6.5 ISO
#    -v65 : Create the latest ESXi 6.5 ISO
#    -sip : select an image profile from the list
#    -vft : connect the V-Front Online depot
#    -load : load additional packages from connected depots or Offline bundles
.\ESXi-Customizer-PS-v2.6.0.ps1 -v65 -sip -vft -load net-e1000e,net51-r8169,net55-r8168,esx-ui,sata-xahci,net51-sky2,esxcli-shell -outDir ${Home}\Desktop


# Open the destination which the output .iso was saved-at
explorer "${Home}\Desktop";



# ------------------------------------------------------------
#
# Citation(s)
#
#   code.vmware.com  |  "Inject a .VIB into a ESXi .ISO using ESXi-Customizer-PS"  |  https://code.vmware.com/forums/2530/vsphere-powercli#590922
#
#   powershellgallery.com  |  "PowerShell Gallery | VMware.PowerCLI 11.5.0.14912921"  |  https://www.powershellgallery.com/packages/VMware.PowerCLI/11.5.0.14912921
#
#   vibsdepot.v-front.de  |  "ESXi-Customizer-PS"  |  https://www.v-front.de/p/esxi-customizer-ps.html
#
#   woshub.com  |  "Adding Third-Party Drivers into VMWare ESXi 6.7 ISO Image"  |  http://woshub.com/add-drivers-vmware-esxi-iso-image/#h2_3
#
# ------------------------------------------------------------