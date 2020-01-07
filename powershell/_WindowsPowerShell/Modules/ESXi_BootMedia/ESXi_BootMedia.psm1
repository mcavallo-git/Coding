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
		[String]$ESXiVersion="6.5",
		[Switch]$FallbackIso,
		[Switch]$Pull,
		[Switch]$Quiet
	)
	
	$SupportedVersions = $("6.7","6.5","6.0","5.5","5.1","5.0");
	If (($SupportedVersions.Contains($ESXiVersion)) -Eq $False) {
		Write-Host "Error:  ESXi Version `"${ESXiVersion}`" not supported - Please choose a version from array: of @( ${SupportedVersions} )";
		Exit 1;

	} Else {

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
				$ExtraVibFilesDir = "${WorkingDir}\pkgDir";
				$LogFilesDir = "${WorkingDir}\logs";
				$FallbackDir = "${WorkingDir}\iso.fallback";

				# PowerShell - Install VMware PowerCLI module
				If (!(Get-Module -ListAvailable -Name ("VMware.PowerCLI"))) {	
					# Install-PackageProvider -Name ("NuGet") -Force;  <# PowerShell - Install the NuGet package manager #>
					Install-Module -Name ("VMware.PowerCLI") -Scope ("CurrentUser") -Force;  <# Call  [ Get-DeployCommand ]  to inspect service(s) #>
				}

				Set-PowerCLIConfiguration -Scope ("User") -ParticipateInCEIP ($False);

				New-Item -ItemType ("Directory") -Path ("${WorkingDir}") | Out-Null;
				Set-Location -Path ("${WorkingDir}");

				# Download the latest ESXi-Customizer-PS PowerShell script-file
				Set-Location -Path ("${WorkingDir}");
				New-Item -Path .\ESXi-Customizer-PS-v2.6.0.ps1 -Value ($(New-Object Net.WebClient).DownloadString("https://vibsdepot.v-front.de/tools/ESXi-Customizer-PS-v2.6.0.ps1")) -Force | Out-Null;
				New-Item -ItemType ("Directory") -Path ("${LogFilesDir}") | Out-Null;

				# ------------------------------------------------------------
				### OUTPUT FROM  [ ${Home}\Desktop\ESXi-Customizer-PS-v2.6.0.ps1 -help ]
				#
				# This is ESXi-Customizer-PS Version 2.6.0 (visit https://ESXi-Customizer-PS.v-front.de for more information!)
				#
				# Usage:
				#    ESXi-Customizer-PS [-help] | [-izip <bundle> [-update]] [-sip] [-v67|-v65|-v60|-v55|-v51|-v50]
				#                                 [-ozip] [-pkgDir <dir>] [-outDir <dir>] [-vft] [-dpt depot1[,...]]
				#                                 [-load vib1[,...]] [-remove vib1[,...]] [-log <file>] [-ipname <name>]
				#                                 [-ipdesc <desc>] [-ipvendor <vendor>] [-nsc] [-test]
				#
				# Optional parameters:
				#    -help              : display this help
				#    -izip <bundle>     : use the VMware Offline bundle <bundle> as input instead of the Online depot
				#    -update            : only with -izip, updates a local bundle with an ESXi patch from the VMware Online depot,
				#                         combine this with the matching ESXi version selection switch
				#    -pkgDir <dir>      : local directory of Offline bundles and/or VIB files to add (if any, no default)
				#    -ozip              : output an Offline bundle instead of an installation ISO
				#    -outDir <dir>      : directory to store the customized ISO or Offline bundle (the default is the
				#                         script directory. If specified the log file will also be moved here.)
				#    -vft               : connect the V-Front Online depot
				#    -dpt depot1[,...]  : connect additional Online depots by URL or local Offline bundles by file name
				#    -load vib1[,...]   : load additional packages from connected depots or Offline bundles
				#    -remove vib1[,...] : remove named VIB packages from the custom Imageprofile
				#    -sip               : select an Imageprofile from the current list
				#                         (default = auto-select latest available standard profile)
				#    -v67 | -v65 | -v60 |
				#    -v55 | -v51 | -v50 : Use only ESXi 6.7/6.5/6.0/5.5/5.1/5.0 Imageprofiles as input, ignore other versions
				#    -nsc               : use -NoSignatureCheck with export
				#    -log <file>        : Use custom log file <file>
				#    -ipname <name>
				#    -ipdesc <desc>
				#    -ipvendor <vendor> : provide a name, description and/or vendor for the customized
				#                         Imageprofile (the default is derived from the cloned input Imageprofile)
				#    -test              : skip package download and image build (for testing)
				#

				Set-Location -Path ("${WorkingDir}");
				.\ESXi-Customizer-PS-v2.6.0.ps1 -help 1>"${LogFilesDir}\ESXi-Customizer-PS-v2.6.0.ps1 -help.log" 2>&1 3>&1 4>&1 5>&1 6>&1;

				# ------------------------------------------------------------

				$Array_VibDepos = @();
				$Array_VibDepos += ("https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml"); 	<# VMware Depot #>

				# ------------------------------------------------------------
				If ($PSBoundParameters.ContainsKey('AllDrivers')) {
					# Search the .vib package depot(s) for available ESXi hardware drivers
					Write-Host "`n`n";
					Write-Host "------------------------------------------------------------";

					New-Item -ItemType ("Directory") -Path ("${ExtraVibFilesDir}") | Out-Null;

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
					$IgnoredExtraVibs = @(); `
					$ESXiVersionDecimal = [Decimal]((($ESXiVersion -Split '^([\d\.]+)').Split('.') | Select-Object -Skip 1 -First 2) -Join "."); `
					$Array_ESXiBaseDrivers = @("esx-base","esx-dvfilter-generic-fastpath","esx-tboot","esx-tools-for-esxi","esx-update","esx-version","esx-xlibs","esx-xserver","tools-light");
					$Array_ESXiSkipDrivers = @("esx-tools-for-esxi");
					$Array_AcceptanceLevels = @("VMwareCertified","VMwareAccepted","PartnerSupported","CommunitySupported");
					ForEach ($EachVib in $Vibs) {
						$ValidVib = $True;
						If ($Array_ESXiBaseDrivers.Contains($EachVib.Name)) {
							$ValidVib = $False;
							$PackageName = $EachVib.Name;
							$Version = $EachVib.Version;
							If (($Version -NE $Null) -And ($Version.GetType().Name -Eq "String")) {
								If (($Version.Split(".")).Count -Eq 1) {
									$MinorVersionSpecified = $False;
								} Else {
									$MinorVersionSpecified = $True;
								}
								$EachVersionDecimal = [Decimal]((($Version -Split '^([\d\.]+)').Split('.') | Select-Object -Skip 1 -First 2) -Join ".");
								<# Equal Version #>
								If (($MinorVersionSpecified -Eq $True) -And ($ESXiVersionDecimal -Eq $EachVersionDecimal)) {
									$ValidVib = $True;
								} ElseIf (($MinorVersionSpecified -Eq $False) -And (([Int]$ESXiVersionDecimal) -Eq ([Int]$EachVersionDecimal))) {
									$ValidVib = $True;
								}
							}
						}
						If ($ValidVib -Eq $True) {
							If ($EachVib.AcceptanceLevel -NE "VMwareCertified") {
								$ValidVib = $False;
							} ElseIf ($Array_ESXiSkipDrivers.Contains($EachVib.Name)) {
								$ValidVib = $False;
							} Else {
								ForEach ($Depends in $EachVib.Depends) {
									$ValidDependency = $True;
									$PackageName = $Depends.PackageName;
									$Relation = $Depends.Relation;
									$Version = $Depends.Version;
									If (($Version -NE $Null) -And ($Version.GetType().Name -Eq "String") -And ($Array_ESXiBaseDrivers.Contains($PackageName))) {
										$ValidDependency = $False; <# Assume guilty until proven innocent #>
										If (($Version.Split(".")).Count -Eq 1) {
											$MinorVersionSpecified = $False;
										} Else {
											$MinorVersionSpecified = $True;
										}
										$EachVersionDecimal = [Decimal]((($Version -Split '^([\d\.]+)').Split('.') | Select-Object -Skip 1 -First 2) -Join "."); `
										If (($Relation -Eq ">") -Or ($Relation -Eq ">>")) {
											<# Greater-Than Version #>
											If (($MinorVersionSpecified -Eq $True) -And ($ESXiVersionDecimal -GT $EachVersionDecimal)) {
												$ValidDependency = $True;
											} ElseIf (($Array_ESXiBaseDrivers.Contains($EachVib.Name)) -And ($MinorVersionSpecified -Eq $True) -And ($ESXiVersionDecimal -GE $EachVersionDecimal)) {
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
											} ElseIf (($Array_ESXiBaseDrivers.Contains($EachVib.Name)) -And ($MinorVersionSpecified -Eq $True) -And ($ESXiVersionDecimal -LE $EachVersionDecimal)) {
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
						}
						If ($ValidVib -Eq $True) {
							$ValidExtraVibs += $EachVib;
						} Else {
							$IgnoredExtraVibs += $EachVib;
						}
					};

					$VibNames_Valid = ($ValidExtraVibs | Sort-Object -Property Name -Unique).Name;
					$VibNames_Valid > "${LogFilesDir}\VibNames_Valid.log";
					$ValidExtraVibs | Sort-Object -Property Name,@{Expression={$_.Version}; Ascending=$False} | Format-List > "${LogFilesDir}\Verbose-ValidExtraVibs.log";

					$VibNames_Ignored = ($IgnoredExtraVibs | Sort-Object -Property Name -Unique).Name;
					$VibNames_Ignored > "${LogFilesDir}\VibNames_Ignored.log";
					$IgnoredExtraVibs | Sort-Object -Property Name,@{Expression={$_.Version}; Ascending=$False} | Format-List > "${LogFilesDir}\Verbose-IgnoredExtraVibs.log";

				}

				# Set a default, or 'common'. configuration by-through which drivers are applied
				$FallbackVibNames_Valid = @("esxcli-shell","esx-ui","net51-r8169","net51-sky2","net55-r8168","net-e1000e","sata-xahci");

				### Create the latest ESXi 6.5 ISO

				Write-Host "------------------------------------------------------------";
				Write-Host "";
				Write-Host "PS $(Get-Location)>  Calling  [ Set-Location -Path (`"${WorkingDir}`"); ]  ...";
				Set-Location -Path ("${WorkingDir}");
				New-Item -ItemType ("Directory") -Path ("${FallbackDir}") | Out-Null;

				If ($ESXiVersion -Eq "5.0") { 
					$VersionArg = "-v50";
				} ElseIf ($ESXiVersion -Eq "5.1") {
					$VersionArg = "-v51";
				} ElseIf ($ESXiVersion -Eq "5.5") {
					$VersionArg = "-v55";
				} ElseIf ($ESXiVersion -Eq "6.0") {
					$VersionArg = "-v60";
				} ElseIf ($ESXiVersion -Eq "6.5") {
					$VersionArg = "-v65";
				} ElseIf ($ESXiVersion -Eq "6.7") {
					$VersionArg = "-v67";
				}
					
				If ((($PSBoundParameters.ContainsKey('AllDrivers')) -Eq $False) -Or ($PSBoundParameters.ContainsKey('FallbackIso'))) {
					Write-Host "";
					Write-Host "PS $(Get-Location)>  Calling  [ .\ESXi-Customizer-PS-v2.6.0.ps1 ${$VersionArg} -vft -load $(([String]$FallbackVibNames_Valid).Replace(' ',',')) -outDir (`"${FallbackDir}\.`"); ]  ...";
					.\ESXi-Customizer-PS-v2.6.0.ps1 ${$VersionArg} -vft -load ${FallbackVibNames_Valid} -outDir ("${FallbackDir}\.");
					# Write-Host "PS $(Get-Location)>  Calling  [ .\ESXi-Customizer-PS-v2.6.0.ps1 ${$VersionArg} -vft -dpt $(([String]$Array_VibDepos).Replace(' ',',')) -load $(([String]$FallbackVibNames_Valid).Replace(' ',',')) outDir (`"${FallbackDir}\.`"); ]  ...";
					# .\ESXi-Customizer-PS-v2.6.0.ps1 ${$VersionArg} -vft -dpt ${Array_VibDepos} -load ${FallbackVibNames_Valid} outDir ("${FallbackDir}\.");
				}

				If ($VibNames_Valid -NE $Null) {
					If ((Test-Path -Path "${ExtraVibFilesDir}") -Eq $True) {
						<# Download any .vib files found to be valid #>
						$ValidExtraVibs | Sort-Object -Property Name -Unique | Sort-Object -Property Name,@{Expression={$_.Version}; Ascending=$False} | ForEach-Object {
							$SourceUrl = [String](($_.SourceUrls)[0]);
							If ($SourceUrl -NE $Null) {
								$SourceUrl_Basename = (Split-Path ${SourceUrl} -Leaf);
								$SourceUrl_LocalPath = "${ExtraVibFilesDir}\${SourceUrl_Basename}";
								Write-Host "";
								Write-Host "Setting download-path for .vib package @ url `"${SourceUrl}`"";
								New-Item -Path "${SourceUrl_LocalPath}" -Value ("${SourceUrl}") -Force | Out-Null;
								# New-Item -Path "${SourceUrl_LocalPath}" -Value ($(New-Object Net.WebClient).DownloadString($SourceUrl)) -Force | Out-Null;
							}
						}
						<# Fix .vib attachments in customizer #>
						$regex = 'Get-EsxSoftwarePackage -PackageUrl \$vibFile -ErrorAction SilentlyContinue';
						$replacement = "Get-EsxSoftwarePackage -PackageUrl `$(Get-Content `$vibFile) -ErrorAction SilentlyContinue";
						(Get-Content "${WorkingDir}\ESXi-Customizer-PS-v2.6.0.ps1") -Replace $regex, $replacement | Set-Content "${WorkingDir}\ESXi-Customizer-PS-v2.6.0.ps1";

						Set-Location -Path ("${WorkingDir}");
						Write-Host "";
						Write-Host "PS $(Get-Location)>  Calling  [ .\ESXi-Customizer-PS-v2.6.0.ps1 ${$VersionArg} -vft -pkgDir `"${ExtraVibFilesDir}`" -outDir (`".`"); ]  ...";
						.\ESXi-Customizer-PS-v2.6.0.ps1 ${$VersionArg} -vft -pkgDir "${ExtraVibFilesDir}" -outDir (".");
					} Else {
						Set-Location -Path ("${WorkingDir}");
						Write-Host "";
						Write-Host "PS $(Get-Location)>  Calling  [ .\ESXi-Customizer-PS-v2.6.0.ps1 ${$VersionArg} -vft -load $(([String]$VibNames_Valid).Replace(' ',',')) -outDir (`".`"); ]  ...";
						.\ESXi-Customizer-PS-v2.6.0.ps1 ${$VersionArg} -vft -load $VibNames_Valid -outDir (".");
						# Write-Host "PS $(Get-Location)>  Calling  [ .\ESXi-Customizer-PS-v2.6.0.ps1 ${$VersionArg} -vft -dpt $(([String]$Array_VibDepos).Replace(' ',',')) -load $(([String]$VibNames_Valid).Replace(' ',',')) -outDir (`".`"); ]  ...";
						# .\ESXi-Customizer-PS-v2.6.0.ps1 ${$VersionArg} -vft -dpt ${Array_VibDepos} -load $VibNames_Valid -outDir (".");
					}
				}

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
#   esxi-patches.v-front.de  |  "VMware ESXi Patch Tracker"  |  https://esxi-patches.v-front.de/ESXi-6.5.0.html
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