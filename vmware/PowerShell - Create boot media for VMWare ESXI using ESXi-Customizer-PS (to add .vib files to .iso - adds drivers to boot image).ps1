<#

PowerShell
  Create boot media for VMWare ESXI using ESXi-Customizer-PS (to add .vib files to .iso - adds drivers to boot image).ps1

#>

<# PowerShell - Install the NuGet package manager #>
Install-PackageProvider -Name ("NuGet") -Force;

<# PowerShell - Install VMware PowerCLI module #>
If (!(Get-Module -ListAvailable -Name ("VMware.PowerCLI"))) {
	Install-Module -Name ("VMware.PowerCLI") -Scope ("CurrentUser") -Force;
}


<# Download and run the ESXi-Customizer #>
New-Item -Path ("${Home}\Downloads\ESXi-Customizer-PS-v2.6.0.ps1") -Value (($(New-Object Net.WebClient).DownloadString("https://vibsdepot.v-front.de/tools/ESXi-Customizer-PS-v2.6.0.ps1"))) | Out-Null;
PowerShell -NoProfile -ExecutionPolicy Bypass ("${Home}\Downloads\ESXi-Customizer-PS-v2.6.0.ps1");



# ------------------------------------------------------------
#
# Citation(s)
#
#   code.vmware.com  |  "Inject a .VIB into a ESXi .ISO using ESXi-Customizer-PS"  |  http://vibsdepot.v-front.de/tools/ESXi-Customizer-PS-v2.6.0.ps1
#
#   code.vmware.com  |  "Inject a .VIB into a ESXi .ISO using ESXi-Customizer-PS"  |  https://code.vmware.com/forums/2530/vsphere-powercli#590922
#
#   powershellgallery.com  |  "PowerShell Gallery | VMware.PowerCLI 11.5.0.14912921"  |  https://www.powershellgallery.com/packages/VMware.PowerCLI/11.5.0.14912921
#
# ------------------------------------------------------------