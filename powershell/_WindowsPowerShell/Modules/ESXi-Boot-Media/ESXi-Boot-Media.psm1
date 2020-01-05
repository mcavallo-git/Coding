#
#	PowerShell - ESXi-Boot-Media
#		|
#		|--> Description:  Create boot media for VMWare ESXI using "ESXi-Customizer-PS" PowerShell script to add .vib files to ESXi.iso (adds drivers to ESXi boot image)
#		|
#		|--> Example:     PowerShell -Command ("ESXi-Boot-Media")
#
Function ESXi-Boot-Media() {
	Param(
		[Switch]$Quiet,
		[Switch]$Pull
	)
	
	$CreateMedia = $True;

	# If ($False) { # RUN THIS SCRIPT:
	# Create ESXi boot media on-the-fly
	# New-Item -Path ("${Env:TEMP}\esxi-create-bootmedia.ps1") -Value (($(New-Object Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/master/vmware/VMWare%20ESXi%20-%20Create%20boot%20media%20using%20ESXi-Customizer-PS%20(.vib%20drviers).ps1"))) -Force | Out-Null; PowerShell -NoProfile -ExecutionPolicy Bypass ("${Env:TEMP}\esxi-create-bootmedia.ps1"); Remove-Item -Path ("${Env:TEMP}\esxi-create-bootmedia.ps1");
	# }

	
	# ------------------------------------------------------------
	#
	# Script must run as admin
	#
	If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
		# Script is >> NOT << running as admin  --> Attempt to open an admin terminal with the same command-line arguments as the current
		$CommandString = $MyInvocation.MyCommand.Name;
		$PSBoundParameters.Keys | ForEach-Object { $CommandString += " -$_"; If (@('String','Integer','Double').Contains($($PSBoundParameters[$_]).GetType().Name)) { $CommandString += " `"$($PSBoundParameters[$_])`""; } };
		Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -Command `"$($CommandString)`"" -Verb RunAs;


	} Else {

		$StartTimestamp = (Get-Date -UFormat "%Y%m%d_%H%M%S");

		# Setup the working directory as a timestamped directory on the current user's Desktop & change directory to it
		$WorkingDir = "${Home}\Desktop\ESXi-Boot-Media_${StartTimestamp}";
		New-Item -ItemType ("Directory") -Path ("${WorkingDir}");
		Set-Location -Path ("${WorkingDir}");

		# PowerShell - Install VMware PowerCLI module
		If (!(Get-Module -ListAvailable -Name ("VMware.PowerCLI"))) {	
			# Install-PackageProvider -Name ("NuGet") -Force;  <# PowerShell - Install the NuGet package manager #>
			Install-Module -Name ("VMware.PowerCLI") -Scope ("CurrentUser") -Force;  <# Call  [ Get-DeployCommand ]  to inspect service(s) #>
		}
		Set-PowerCLIConfiguration -Scope ("User") -ParticipateInCEIP ($False);

		# Download the latest ESXi-Customizer-PS PowerShell script-file
		New-Item -Path .\ESXi-Customizer-PS-v2.6.0.ps1 -Value ($(New-Object Net.WebClient).DownloadString("https://vibsdepot.v-front.de/tools/ESXi-Customizer-PS-v2.6.0.ps1")) -Force | Out-Null;

		# Create the latest ESXi 6.5 ISO
		#    -v65 : Create the latest ESXi 6.5 ISO
		#    -vft : connect the V-Front Online depot
		#    -load : load additional packages from connected depots or Offline bundles
		.\ESXi-Customizer-PS-v2.6.0.ps1 -v65 -vft -load net-e1000e,net51-r8169,net55-r8168,esx-ui,sata-xahci,net51-sky2,esxcli-shell -outDir .

		# Open the destination which the output .iso was saved-at
		Explorer .;

		If ($False) {
			# Inspection/Debugging: Manually search the package (.vibs) depots

			<# ------------------------------------------------------------ #> `
			<# VMware's Vibs Depot #> `
			Write-Host "`n`n"; `
			Write-Host "------------------------------------------------------------"; `
			Write-Host "Querying VMWare's available SoftwarePackages (VIBs)"; `
			$DepotOwner = "VMware"; `
			$UrlEsxDepot_VMware = "https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml"; `
			Add-EsxSoftwareDepot ("${UrlEsxDepot_VMware}");  <# Adds an ESX software depot or offline depot ZIP file to the current PowerCLI session #> `
			$LogFile = "${Home}\Desktop\ESXi.Get-EsxSoftwarePackage.${DepotOwner}_VibDepot.log"; Get-EsxSoftwarePackage | Sort-Object "Name" | Format-Table > "${LogFile}"; Notepad "${LogFile}";  <# Returns a list of SoftwarePackage (VIB) objects from connected depot(s) #> `
			$LogFile = "${Home}\Desktop\ESXi.Get-EsxSoftwarePackage.Verbose.${DepotOwner}_VibDepot.log"; Get-EsxSoftwarePackage | Sort-Object "Name" | Format-List > "${LogFile}"; Notepad "${LogFile}";  <# Returns a list of SoftwarePackage (VIB) objects from connected depot(s) #> `
			Remove-EsxSoftwareDepot ("${UrlEsxDepot_VMware}");  <# Disconnects the current PowerCLI session from the specified software depot(s) #> `
			Write-Host "`n`n"; `
			<# ------------------------------------------------------------ #> `
			<# V-Front's Vibs Depot #> `
			Write-Host "`n`n";
			Write-Host "------------------------------------------------------------";
			Write-Host "Querying V-Front's available SoftwarePackages (VIBs)";
			$DepotOwner = "V-Front";
			$UrlEsxDepot_VFront = "https://vibsdepot.v-front.de/";  <# also available in frontend list-format @  [ https://vibsdepot.v-front.de/wiki/index.php/List_of_currently_available_ESXi_packages ] #> `
			Add-EsxSoftwareDepot ("${UrlEsxDepot_VFront}");  <# Adds an ESX software depot or offline depot ZIP file to the current PowerCLI session #> `
			$LogFile = "${Home}\Desktop\ESXi.Get-EsxSoftwarePackage.${DepotOwner}_VibDepot.log"; Get-EsxSoftwarePackage | Sort-Object "Name" | Format-Table > "${LogFile}"; Notepad "${LogFile}";  <# Returns a list of SoftwarePackage (VIB) objects from connected depot(s) #> `
			$LogFile = "${Home}\Desktop\ESXi.Get-EsxSoftwarePackage.Verbose.${DepotOwner}_VibDepot.log"; Get-EsxSoftwarePackage | Sort-Object "Name" | Format-List > "${LogFile}"; Notepad "${LogFile}";  <# Returns a list of SoftwarePackage (VIB) objects from connected depot(s) #> `
			Remove-EsxSoftwareDepot ("${UrlEsxDepot_VFront}");  <# Disconnects the current PowerCLI session from the specified software depot(s) #> `
			Write-Host "`n`n"; `
			<# ------------------------------------------------------------ #>

		}


		# ------------------------------------------------------------
		#	### "Press any key to continue..."
		Write-Host -NoNewLine "`n`n$($MyInvocation.MyCommand.Name) - Press any key to continue...  `n`n" -ForegroundColor "Yellow" -BackgroundColor "Black";
		$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

		Return;

	}

}
Export-ModuleMember -Function "ESXi-Boot-Media";
# Install-Module -Name "ESXi-Boot-Media"


# ------------------------------------------------------------
#
# Citation(s)
#
#   code.vmware.com  |  "Inject a .VIB into a ESXi .ISO using ESXi-Customizer-PS"  |  https://code.vmware.com/forums/2530/vsphere-powercli#590922
#
#   nucblog.net  |  "Installing ESXi on a Bean Canyon NUC – The NUC Blog"  |  https://nucblog.net/2018/11/installing-esxi-on-a-bean-canyon-nuc/
#
#   pubs.vmware.com  |  "vSphere PowerCLI Reference - Add-EsxSoftwareDepot"  |  https://pubs.vmware.com/vsphere-50/index.jsp?topic=%2Fcom.vmware.powercli.cmdletref.doc_50%2FAdd-EsxSoftwareDepot.html
#
#   pubs.vmware.com  |  "vSphere PowerCLI Reference - Get-EsxSoftwarePackage"  |  https://pubs.vmware.com/vsphere-51/index.jsp?topic=%2Fcom.vmware.powercli.cmdletref.doc%2FGet-EsxSoftwarePackage.html
#
#   pubs.vmware.com  |  "vSphere PowerCLI Reference - Remove-EsxSoftwareDepot"  |  https://pubs.vmware.com/vsphere-50/index.jsp?topic=%2Fcom.vmware.powercli.cmdletref.doc_50%2FRemove-EsxSoftwareDepot.html
#
#   vibsdepot.v-front.de  |  "List of currently available ESXi packages - V-Front VIBSDepot Wiki"  |  https://vibsdepot.v-front.de/wiki/index.php/List_of_currently_available_ESXi_packages
#
#   woshub.com  |  "Adding Third-Party Drivers into VMWare ESXi 6.7 ISO Image"  |  http://woshub.com/add-drivers-vmware-esxi-iso-image/#h2_3
#
#   www.powershellgallery.com  |  "PowerShell Gallery | VMware.PowerCLI 11.5.0.14912921"  |  https://www.powershellgallery.com/packages/VMware.PowerCLI/11.5.0.14912921
#
#   www.v-front.de  |  "VMware Front Experience: ESXi-Customizer-PS"  |  https://www.v-front.de/p/esxi-customizer-ps.html
#
# ------------------------------------------------------------