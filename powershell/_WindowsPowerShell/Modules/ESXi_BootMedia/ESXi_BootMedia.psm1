#
#	PowerShell - ESXi_BootMedia
#		|
#		|--> Description:  Create boot media for VMWare ESXI using "ESXi-Customizer-PS" PowerShell script to add .vib files to ESXi.iso (adds drivers to ESXi boot image)
#		|
#		|--> Example:     PowerShell -Command ("ESXi_BootMedia -Create -AllDrivers;")
#
Function ESXi_BootMedia() {
	Param(
		[Switch]$AllDrivers,
		[Switch]$Create,
		[Switch]$Pull,
		[Switch]$Quiet
	)
	
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

		$CreateMedia = $False;
		If ($PSBoundParameters.ContainsKey('Create')) {
			$CreateMedia = $True;
		}

		If ($CreateMedia -Eq $False) {
			Write-Host "Please call with  [ -Create ]  argument to create bootable .iso media";

		} Else {
				
			$StartTimestamp = (Get-Date -UFormat "%Y%m%d_%H%M%S");

			# Setup the working directory as a timestamped directory on the current user's Desktop & change directory to it
			$WorkingDir = "${Home}\Desktop\ESXi_BootMedia_${StartTimestamp}";
			New-Item -ItemType ("Directory") -Path ("${WorkingDir}");
			Set-Location -Path ("${WorkingDir}");

			# PowerShell - Install VMware PowerCLI module
			If (!(Get-Module -ListAvailable -Name ("VMware.PowerCLI"))) {	
				# Install-PackageProvider -Name ("NuGet") -Force;  <# PowerShell - Install the NuGet package manager #>
				Install-Module -Name ("VMware.PowerCLI") -Scope ("CurrentUser") -Force;  <# Call  [ Get-DeployCommand ]  to inspect service(s) #>
			}
			Set-PowerCLIConfiguration -Scope ("User") -ParticipateInCEIP ($False);

			# Download the latest ESXi-Customizer-PS PowerShell script-file
			Set-Location -Path ("${WorkingDir}");
			New-Item -Path .\ESXi-Customizer-PS-v2.6.0.ps1 -Value ($(New-Object Net.WebClient).DownloadString("https://vibsdepot.v-front.de/tools/ESXi-Customizer-PS-v2.6.0.ps1")) -Force | Out-Null;
			
			$Array_VibDepos = @();
			$Array_VibDepos += ("https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml"); 	<# VMware Depot #>

			# ------------------------------------------------------------
			If ($PSBoundParameters.ContainsKey('AllDrivers')) {
				# Search the package (.vibs) depots for available ESXi hardware drivers
				Write-Host "`n`n";
				Write-Host "------------------------------------------------------------";

				Write-Host "";
				Write-Host "Fetching available ESXi .vib drivers from DepotUrl: `"$($Array_VibDepos[0])`"";
				Add-EsxSoftwareDepot ($Array_VibDepos[0]);  <# Adds an ESX software depot or offline depot ZIP file to the current PowerCLI session #>

				$Array_VibDepos += ("https://vibsdepot.v-front.de/index.xml");  <# V-Front Depot #>
				Write-Host "";
				Write-Host "Fetching available ESXi .vib drivers from DepotUrl: `"$($Array_VibDepos[1])`"";
				Add-EsxSoftwareDepot ($Array_VibDepos[1]);  <# Adds an ESX software depot or offline depot ZIP file to the current PowerCLI session #>

				Write-Host "";
				Write-Host "Searching available ESXi software packages (as .vib extensioned drivers)";
				$Vibs = (Get-EsxSoftwarePackage);  <# Returns a list of SoftwarePackage (VIB) objects from all the connected depots #>

				$ValidExtraVibs = @(); `
				$InvalidExtraVibs = @(); `
				$ESXiVersion = "6.5"; `
				$ESXiVersionDecimal = [Decimal]((($ESXiVersion -Split '^([\d\.]+)').Split('.') | Select-Object -Skip 1 -First 2) -Join "."); `
				$Array_ESXiBaseDrivers = @("esx-base","esx-update","esx-version","vsan");
				$Array_AcceptanceLevels = @("VMwareCertified","VMwareAccepted","PartnerSupported","CommunitySupported");
				ForEach ($EachVib in $Vibs) {
					$ValidVib = $True;
					If ($EachVib.AcceptanceLevel -NE "VMwareCertified") {
						$ValidVib = $False;
					} Else {
						ForEach ($Depends in $EachVib.Depends) {
							$ValidDependency = $True;
							$PackageName = $Depends.PackageName;
							$Relation = $Depends.Relation;
							$Version = $Depends.Version;
							If (($Version -NE $Null) -And ($Version.GetType().Name -Eq "String") -And ($Array_ESXiBaseDrivers.Contains($PackageName))) {
								$ValidDependency = $False; <# Assume guilty until proven innocent #>
								If ($Version.Split.Count -Eq 1) {
									$MinorVersionSpecified = $False;
								} Else {
									$MinorVersionSpecified = $True;
								}
								$EachVersionDecimal = [Decimal]((($Version -Split '^([\d\.]+)').Split('.') | Select-Object -Skip 1 -First 2) -Join "."); `
								If (($Relation -Eq ">") -Or ($Relation -Eq ">>")) {
									<# Greater-Than Version #>
									If (($MinorVersionSpecified -Eq $True) -And ($ESXiVersionDecimal -GT $EachVersionDecimal)) {
										$ValidDependency = $True;
									} ElseIf (($MinorVersionSpecified -Eq $False) -And (([Int]$ESXiVersionDecimal) -GT ([Int]$EachVersionDecimal))) {
										$ValidDependency = $True;
									}
								} ElseIf ($Relation -Eq ">=") {
									<# Greater-Than / Equal-To Version #>
									If (($MinorVersionSpecified -Eq $True) -And ($ESXiVersionDecimal -GE $EachVersionDecimal)) {
										$ValidDependency = $True;
									} ElseIf (($MinorVersionSpecified -Eq $False) -And (([Int]$ESXiVersionDecimal) -GE ([Int]$EachVersionDecimal))) {
										$ValidDependency = $True;
									}
								} ElseIf ($Relation -Eq "=") {
									<# Equals Version #>
									If (($MinorVersionSpecified -Eq $True) -And ($ESXiVersionDecimal -Eq $EachVersionDecimal)) {
										$ValidDependency = $True;
									} ElseIf (($MinorVersionSpecified -Eq $False) -And (([Int]$ESXiVersionDecimal) -Eq ([Int]$EachVersionDecimal))) {
										$ValidDependency = $True;
									}
								} ElseIf ($Relation -Eq "<=") {
									<# Less-Than / Equal-To Version #>
									If (($MinorVersionSpecified -Eq $True) -And ($ESXiVersionDecimal -LE $EachVersionDecimal)) {
										$ValidDependency = $True;
									} ElseIf (($MinorVersionSpecified -Eq $False) -And (([Int]$ESXiVersionDecimal) -LE ([Int]$EachVersionDecimal))) {
										$ValidDependency = $True;
									}
								} ElseIf (($Relation -Eq "<") -Or ($Relation -Eq "<<")) {
									<# Less-Than Version #>
									If (($MinorVersionSpecified -Eq $True) -And ($ESXiVersionDecimal -LT $EachVersionDecimal)) {
										$ValidDependency = $True;
									} ElseIf (($MinorVersionSpecified -Eq $False) -And (([Int]$ESXiVersionDecimal) -LT ([Int]$EachVersionDecimal))) {
										$ValidDependency = $True;
									}
								} ElseIf ($Depends.Relation -NE $Null) {
									Write-Host "Unhandled .vib dependency-relation: "; $Relation; <# Output Un-handled Relations #>
								}
							}
							If ($ValidDependency -Eq $False) {
								$ValidVib = $False;
							}
						}
					}
					If ($ValidVib -Eq $True) {
						$ValidExtraVibs += $EachVib;
					} Else {
						$InvalidExtraVibs += $EachVib;
					}
				};

				$VibNames_Valid = ($ValidExtraVibs | Select-Object -Property "Name" -Unique | Sort-Object -Property "Name").Name;
				$VibNames_Valid > "${Home}\Desktop\VibNames_Valid.log";
				$ValidExtraVibs | Sort-Object -Property Name,Version | Format-List > "${Home}\Desktop\Verbose-ValidExtraVibs.log";

				$VibNames_Invalid = ($InvalidExtraVibs | Select-Object -Property "Name" -Unique | Sort-Object -Property "Name").Name;
				$VibNames_Invalid > "${Home}\Desktop\VibNames_Invalid.log";
				$InvalidExtraVibs | Sort-Object -Property Name,Version | Format-List > "${Home}\Desktop\Verbose-ValidExtraVibs.log";

			}

			# Set a default, or 'common'. configuration by-through which drivers are applied
			$FallbackVibNames_Valid=@("net-e1000e","net51-r8169","net55-r8168","esx-ui","sata-xahci","net51-sky2","esxcli-shell");

			# ------------------------------------------------------------
			# Create the latest ESXi 6.5 ISO
			#    -v65 : Create the latest ESXi 6.5 ISO
			#    -vft : connect the V-Front Online depot
			#    -load : load additional packages from connected depots or Offline bundles
			Write-Host "------------------------------------------------------------";
			Write-Host "";
			Write-Host "Calling  [ Set-Location -Path (`"${WorkingDir}`"); ]  ...";
			Set-Location -Path ("${WorkingDir}");

			Write-Host "";
			Write-Host "Calling  [ .\ESXi-Customizer-PS-v2.6.0.ps1 -v65 -vft -dpt $(([String]$Array_VibDepos).Replace(' ',',')) -load $(([String]$FallbackVibNames_Valid).Replace(' ',',')) -outDir .; ]  ...";
			.\ESXi-Customizer-PS-v2.6.0.ps1 -v65 -vft -load ${FallbackVibNames_Valid} -outDir .;
			# .\ESXi-Customizer-PS-v2.6.0.ps1 -v65 -vft -dpt ${Array_VibDepos} -load ${FallbackVibNames_Valid} -outDir .;

			Write-Host "";
			Write-Host "Calling  [ .\ESXi-Customizer-PS-v2.6.0.ps1 -v65 -vft -dpt $(([String]$Array_VibDepos).Replace(' ',',')) -load $(([String]$VibNames_Valid).Replace(' ',',')) -outDir .; ]  ...";
			.\ESXi-Customizer-PS-v2.6.0.ps1 -v65 -vft -load $VibNames_Valid -outDir .;
			# .\ESXi-Customizer-PS-v2.6.0.ps1 -v65 -vft -dpt ${Array_VibDepos} -load $VibNames_Valid -outDir .;


			# Open the destination which the output .iso was saved-at
			Set-Location -Path ("${WorkingDir}");
			Explorer .;


			# ------------------------------------------------------------
			#	### "Press any key to continue..."
			Write-Host -NoNewLine "`n`n$($MyInvocation.MyCommand.Name) - Press any key to continue...  `n`n" -ForegroundColor "Yellow" -BackgroundColor "Black";
			$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

			Return;

		}

	}

}
Export-ModuleMember -Function "ESXi_BootMedia";
# Install-Module -Name "ESXi_BootMedia"


# ------------------------------------------------------------
#
### Check installed VIBs (on an ESXi host via SSH)
#
#   mkdir -p /root; chmod 0700 /root; esxcli software vib list > "/root/esxcli-software-vib-list.$(hostname).$(date +'%Y%m%d_%H%M%S').log";
#
#
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