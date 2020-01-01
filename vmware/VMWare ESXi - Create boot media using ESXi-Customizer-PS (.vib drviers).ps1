# ------------------------------------------------------------
#
# VMware ESXI - Create boot media for VMWare ESXI using "ESXi-Customizer-PS" PowerShell script to add .vib files to ESXi.iso (adds drivers to ESXi boot image)
#
# ------------------------------------------------------------

<# PowerShell - Install VMware PowerCLI module #>
Install-PackageProvider -Name ("NuGet") -Force; Install-Module -Name ("VMware.PowerCLI") -Scope ("CurrentUser") -Force;


<# Download and run the ESXi-Customizer #>
New-Item -Path ("${Home}\Downloads\ESXi-Customizer-PS-v2.6.0.ps1") -Value (($(New-Object Net.WebClient).DownloadString("https://vibsdepot.v-front.de/tools/ESXi-Customizer-PS-v2.6.0.ps1"))) | Out-Null;

<# #>
"${Home}\Downloads\ESXi-Customizer-PS-v2.6.0.ps1" -



# ------------------------------------------------------------
#
# Citation(s)
#
#   vibsdepot.v-front.de  |  "ESXi-Customizer-PS"  |  https://www.v-front.de/p/esxi-customizer-ps.html
#
#   code.vmware.com  |  "Inject a .VIB into a ESXi .ISO using ESXi-Customizer-PS"  |  https://code.vmware.com/forums/2530/vsphere-powercli#590922
#
#   powershellgallery.com  |  "PowerShell Gallery | VMware.PowerCLI 11.5.0.14912921"  |  https://www.powershellgallery.com/packages/VMware.PowerCLI/11.5.0.14912921
#
# ------------------------------------------------------------