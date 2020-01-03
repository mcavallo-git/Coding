# ------------------------------------------------------------
#
# VMware ESXI - Create boot media for VMWare ESXI using "ESXi-Customizer-PS" PowerShell script to add .vib files to ESXi.iso (adds drivers to ESXi boot image)
#
# ------------------------------------------------------------
If ($False) { # RUN THIS SCRIPT:

# Create ESXi boot media on the fly
New-Item -Path ("${Env:TEMP}\esxi-create-bootmedia.ps1") -Value (($(New-Object Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/master/vmware/VMWare%20ESXi%20-%20Create%20boot%20media%20using%20ESXi-Customizer-PS%20(.vib%20drviers).ps1"))) -Force | Out-Null; PowerShell -NoProfile -ExecutionPolicy Bypass ("${Env:TEMP}\esxi-create-bootmedia.ps1"); Remove-Item -Path ("${Env:TEMP}\esxi-create-bootmedia.ps1");

}


# ------------------------------------------------------------
#
# Script must run as admin
#
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Write-Host "`nError - Admin PowerShell terminal required`n" -ForegroundColor "Red";
	exit 1;

} Else {

	# PowerShell - Install the NuGet package manager
	Install-PackageProvider -Name ("NuGet") -Force;

	# PowerShell - Install VMware PowerCLI module
	If (!(Get-Module -ListAvailable -Name ("VMware.PowerCLI"))) {
		Install-Module -Name ("VMware.PowerCLI") -Scope ("CurrentUser") -Force;
	}

	# Set the current user's Desktop as the working directory
	Set-Location "${Home}\Desktop";

	# Download and run the ESXi-Customizer
	New-Item -Path .\ESXi-Customizer-PS-v2.6.0.ps1 -Value ($(New-Object Net.WebClient).DownloadString("https://vibsdepot.v-front.de/tools/ESXi-Customizer-PS-v2.6.0.ps1")) -Force | Out-Null;

	# Create the latest ESXi 6.5 ISO
	#    -v65 : Create the latest ESXi 6.5 ISO
	#    -vft : connect the V-Front Online depot
	#    -load : load additional packages from connected depots or Offline bundles
	.\ESXi-Customizer-PS-v2.6.0.ps1 -v65 -vft -load net-e1000e,net51-r8169,net55-r8168,esx-ui,sata-xahci,net51-sky2,esxcli-shell -outDir .

	# Open the destination which the output .iso was saved-at
	Explorer .;

	Exit 0;
}


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