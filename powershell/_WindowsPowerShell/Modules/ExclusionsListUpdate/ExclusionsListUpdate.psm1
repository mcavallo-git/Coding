# ------------------------------------------------------------
#
# Exclusions List for Stock Windows10 Antivirus/Antimalware
#		--> e.g. "Windows Security"
#		--> e.g. "Windows Defender"
#		--> e.g. "Antimalware Service Executable" (which causes high cpu-usage while blocking non-excluded processes)
#
# ------------------------------------------------------------
#
function ExclusionsListUpdate {
	Param(

		[ValidateSet("Add","Get","Remove")]
		[String]$Action = "Add",

		[ValidateSet("", "Windows Defender", "ESET", "Malwarebytes' Anti-Malware", "MalwareBytes' Anti-Ransomware", "MalwareBytes' Anti-Exploit")]
		# [String]$AntiVirusSoftware = "Windows Defender",
		[String]$AntiVirusSoftware,

		[String[]]$ExcludedFilepaths = @(),
		$ExcludedProcesses = @(),
		# [String[]]$ExcludedProcesses = @(),
		[String[]]$ExcludedExtensions = @(),

		[Switch]$Quiet,
		[Switch]$Verbose

	)

	$FoundFilepaths = @();
	$FoundExtensions = @();
	$FoundProcesses = @();

	# Require Escalated Privileges
	If ((RunningAsAdministrator) -eq ($False)) {
		$PSCommandArgs = @();
		$i=0;
		While ($i -lt $args.Length) {
			$PSCommandArgs += $args[$i];
			$i++;
		}
		$CommandString = "ExclusionsListUpdate -SkipExit";
		If ($PSBoundParameters.ContainsKey('AntiVirusSoftware')) { 
			$CommandString += ((" -AntiVirusSoftware ")+($AntiVirusSoftware));
		}
		If ($PSBoundParameters.ContainsKey('Quiet')) { 
			$CommandString += " -Quiet";
		} ElseIf ($PSBoundParameters.ContainsKey('Verbose')) { 
			$CommandString += " -Verbose";
		}
		PrivilegeEscalation -Command ("${CommandString}");

	} Else {

		#
		# ------------------------------------------------------------
		#
		# User/System Directories

		$LocalAppData = (${Env:LocalAppData}); # LocalAppData

		$ProgData = ((${Env:SystemDrive})+("\ProgramData")); # ProgData

		$ProgFilesX64 = ((${Env:SystemDrive})+("\Program Files")); # ProgFilesX64

		$ProgFilesX86 = ((${Env:SystemDrive})+("\Program Files (x86)")); # ProgFilesX86

		$SysDrive = (${Env:SystemDrive}); # C:\

		$SysRoot = (${Env:SystemRoot}); # C:\Windows

		$Sys32 = ((${Env:SystemRoot})+("\System32")); # C:\Windows\System32

		$UserProfile = (${Env:USERPROFILE}); # UserProfile
		
		#
		# ------------------------------------------------------------
		# -- FILEPATHS -- LocalAppData
		$ExcludedFilepaths += ((${LocalAppData})+("\Google\Google Apps Sync"));
		$ExcludedFilepaths += ((${LocalAppData})+("\GitHubDesktop"));
		$ExcludedFilepaths += ((${LocalAppData})+("\Microsoft\OneDrive"));
		$ExcludedFilepaths += ((${LocalAppData})+("\Programs\Git"));
		$ExcludedFilepaths += ((${LocalAppData})+("\Programs\Git\mingw64"));
		# -- FILEPATHS -- ProgFiles X64
		$ExcludedFilepaths += ((${ProgFilesX64})+("\7-Zip"));
		$ExcludedFilepaths += ((${ProgFilesX64})+("\AirParrot 2"));
		$ExcludedFilepaths += ((${ProgFilesX64})+("\AutoHotkey"));
		$ExcludedFilepaths += ((${ProgFilesX64})+("\Classic Shell"));
		$ExcludedFilepaths += ((${ProgFilesX64})+("\Cryptomator"));
		$ExcludedFilepaths += ((${ProgFilesX64})+("\ESET"));
		$ExcludedFilepaths += ((${ProgFilesX64})+("\FileZilla FTP Client"));
		$ExcludedFilepaths += ((${ProgFilesX64})+("\Git"));
		$ExcludedFilepaths += ((${ProgFilesX64})+("\Greenshot"));
		$ExcludedFilepaths += ((${ProgFilesX64})+("\HandBrake"));
		$ExcludedFilepaths += ((${ProgFilesX64})+("\KDiff3"));
		$ExcludedFilepaths += ((${ProgFilesX64})+("\Malwarebytes"));
		$ExcludedFilepaths += ((${ProgFilesX64})+("\Mailbird"));
		$ExcludedFilepaths += ((${ProgFilesX64})+("\Microsoft Office 15"));
		$ExcludedFilepaths += ((${ProgFilesX64})+("\Microsoft VS Code"));
		$ExcludedFilepaths += ((${ProgFilesX64})+("\nodejs"));
		$ExcludedFilepaths += ((${ProgFilesX64})+("\NVIDIA Corporation"));
		$ExcludedFilepaths += ((${ProgFilesX64})+("\paint.net"));
		$ExcludedFilepaths += ((${ProgFilesX64})+("\PowerShell"));
		# -- FILEPATHS -- ProgFiles X86
		$ExcludedFilepaths += ((${ProgFilesX86})+("\Common Files\Sage"));
		$ExcludedFilepaths += ((${ProgFilesX86})+("\Dropbox"));
		$ExcludedFilepaths += ((${ProgFilesX86})+("\efs"));
		$ExcludedFilepaths += ((${ProgFilesX86})+("\GIGABYTE"));
		$ExcludedFilepaths += ((${ProgFilesX86})+("\Intel"));
		$ExcludedFilepaths += ((${ProgFilesX86})+("\LastPass"));
		$ExcludedFilepaths += ((${ProgFilesX86})+("\Mailbird"));
		$ExcludedFilepaths += ((${ProgFilesX86})+("\Malwarebytes Anti-Exploit"));
		$ExcludedFilepaths += ((${ProgFilesX86})+("\Microsoft Office"));
		$ExcludedFilepaths += ((${ProgFilesX86})+("\Microsoft OneDrive"));
		$ExcludedFilepaths += ((${ProgFilesX86})+("\Mobatek"));
		$ExcludedFilepaths += ((${ProgFilesX86})+("\Notepad++"));
		$ExcludedFilepaths += ((${ProgFilesX86})+("\Razer"));
		$ExcludedFilepaths += ((${ProgFilesX86})+("\Razer Chroma SDK"));
		$ExcludedFilepaths += ((${ProgFilesX86})+("\Reflector 3"));
		$ExcludedFilepaths += ((${ProgFilesX86})+("\Sage Payment Solutions"));
		$ExcludedFilepaths += ((${ProgFilesX86})+("\SAP BusinessObjects"));
		$ExcludedFilepaths += ((${ProgFilesX86})+("\Splashtop"));
		$ExcludedFilepaths += ((${ProgFilesX86})+("\WinDirStat"));
		# -- FILEPATHS -- ProgData
		$ExcludedFilepaths += ((${ProgData})+("\Sage"));
		$ExcludedFilepaths += ((${ProgData})+("\Sage Software"));
		# -- FILEPATHS -- Sys32
		# -
		# -- FILEPATHS -- SysDrive
		$ExcludedFilepaths += ((${SysDrive})+("\Sage"));
		$ExcludedFilepaths += ((${SysDrive})+("\BingBackground"));
		$ExcludedFilepaths += ((${SysDrive})+("\ISO\BingBackground"));
		$ExcludedFilepaths += ((${SysDrive})+("\ISO\QuickNoteSniper"));
		# -- FILEPATHS -- SysRoot
		# -
		# -- FILEPATHS -- UserProfile
		$UserProfile=(${Env:UserProfile});
		$ExcludedFilepaths += ((${UserProfile})+("\Dropbox"));
		# -- FILEPATHS (Environment-Based) -- OneDrive Synced Dir(s)
		If (${Env:OneDrive} -ne $null) {
			$ExcludedFilepaths += ${Env:OneDrive};
			$ExcludedFilepaths += (${Env:OneDrive}).replace("OneDrive - ","");
		}
		# -- FILEPATHS (Environment-Based) -- Cloud-Synced  :::  Sharepoint Synced Dir(s) / OneDrive-Shared Synced Dir(s)
		If (${Env:OneDriveCommercial} -ne $null) {
			$ExcludedFilepaths += ${Env:OneDriveCommercial}; 
			$ExcludedFilepaths += (${Env:OneDriveCommercial}).replace("OneDrive - ","");
		}
		# ------------------------------------------------------------
		# -- EXTENSIONS   (e.g. File Types)
		$ExcludedExtensions += (".avhd");
		$ExcludedExtensions += (".avhdx");
		$ExcludedExtensions += (".iso");
		$ExcludedExtensions += (".rct");
		$ExcludedExtensions += (".vhd");
		$ExcludedExtensions += (".vhdx");
		$ExcludedExtensions += (".vmcx");
		$ExcludedExtensions += (".vmrs");
		$ExcludedExtensions += (".vsv");
		# ------------------------------------------------------------
		# -- PROCESSES -- LocalAppData
		$ExcludedProcesses += @{ Dirname=${LocalAppData}; AddDir="Dropbox"; Parent=""; Basename="Dropbox.exe"; };
		$ExcludedProcesses += @{ Dirname=${LocalAppData}; AddDir="GitHubDesktop"; Parent=""; Basename="GitHubDesktop.exe"; };
		$ExcludedProcesses += @{ Dirname=${LocalAppData}; AddDir="GitHubDesktop"; Parent=""; Basename="GitHubDesktop.exe"; };
		$ExcludedProcesses += @{ Dirname=${LocalAppData}; AddDir="GitHubDesktop"; Parent=""; Basename="git.exe"; };
		$ExcludedProcesses += @{ Dirname=${LocalAppData}; AddDir="GitHubDesktop"; Parent=""; Basename="git-bash.exe"; };
		$ExcludedProcesses += @{ Dirname=${LocalAppData}; AddDir="GitHubDesktop"; Parent=""; Basename="git-lfs.exe"; };
		# -- PROCESSES -- ProgFiles X64
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="AutoHotkey"; Parent=""; Basename="AutoHotkey.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Classic Shell"; Parent=""; Basename="ClassicStartMenu.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Cryptomator"; Parent=""; Basename="Cryptomator.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="FileZilla FTP Client"; Parent=""; Basename="filezilla.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Git"; Parent=""; Basename="git.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Git"; Parent=""; Basename="git-lfs.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Git"; Parent=""; Basename="git-bash.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Greenshot"; Parent=""; Basename="Greenshot.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Mailbird"; Parent=""; Basename="CefSharp.BrowserSubprocess.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Mailbird"; Parent=""; Basename="Mailbird.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Mailbird"; Parent=""; Basename="MailbirdUpdater.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Mailbird"; Parent=""; Basename="sqlite3.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Mailbird"; Parent=""; Basename="CefSharp.BrowserSubprocess.exe"; }; # Mailbird\x64\
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Malwarebytes"; Parent=""; Basename="mbam.exe"; }; # Malwarebytes
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Malwarebytes"; Parent=""; Basename="mbamtray.exe"; }; # Malwarebytes
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Malwarebytes"; Parent=""; Basename="mbamservice.exe"; }; # Malwarebytes
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Microsoft VS Code"; Parent=""; Basename="Code.exe"; }; # VS Code
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Microsoft VS Code"; Parent=""; Basename="rg.exe"; }; # VS Code
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="NVIDIA Corporation"; Parent=""; Basename="NVDisplay.Container.exe"; }; # NVIDIA
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="NVIDIA Corporation"; Parent=""; Basename="nvcontainer.exe"; }; # NVIDIA
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="NVIDIA Corporation"; Parent=""; Basename="nvsphelper64.exe"; }; # NVIDIA
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="NVIDIA Corporation"; Parent=""; Basename="NVIDIA GeForce Experience.exe"; }; # NVIDIA
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="NVIDIA Corporation"; Parent=""; Basename="NVIDIA Notification.exe"; }; # NVIDIA
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="NVIDIA Corporation"; Parent=""; Basename="NVIDIA Share.exe"; }; # NVIDIA
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="NVIDIA Corporation"; Parent=""; Basename="NvTelemetryContainer.exe"; }; # NVIDIA
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="TortoiseGit"; Parent=""; Basename="TGitCache.exe"; }; # TortoiseGit
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="WindowsApps"; Parent=""; Basename="XboxApp.exe"; }; # Microsoft XB1
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="WindowsApps"; Parent=""; Basename="IGCCTray.exe"; }; # Intel Graphics
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="WindowsApps"; Parent=""; Basename="IGCC.exe"; }; # Intel Graphics
		# -- PROCESSES -- ProgFiles X86
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Dropbox"; Parent=""; Basename="Dropbox.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Intel"; Parent=""; Basename="DSAService.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Intel"; Parent=""; Basename="tbtsvc.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Intel"; Parent=""; Basename="Thunderbolt.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="LastPass"; Parent=""; Basename="ie_extract.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="LastPass"; Parent=""; Basename="lastpass.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="LastPass"; Parent=""; Basename="LastPassBroker.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="LastPass"; Parent=""; Basename="nplastpass.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="LastPass"; Parent=""; Basename="WinBioStandalone.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="LastPass"; Parent=""; Basename="wlandecrypt.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft Office"; Parent=""; Basename="lync.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft Office"; Parent=""; Basename="EXCEL.EXE"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft Office"; Parent=""; Basename="lync.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft Office"; Parent=""; Basename="lync99.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft Office"; Parent=""; Basename="lynchtmlconv.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft Office"; Parent=""; Basename="MSACCESS.EXE"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft Office"; Parent=""; Basename="ONENOTE.EXE"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft Office"; Parent=""; Basename="ONENOTEM.EXE"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft Office"; Parent=""; Basename="OUTLOOK.EXE"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft Office"; Parent=""; Basename="POWERPNT.EXE"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft Office"; Parent=""; Basename="WINWORD.EXE"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Mobatek"; Parent=""; Basename="MobaXterm.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Notepad++"; Parent=""; Basename="notepad++.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="NVIDIA Corporation"; Parent=""; Basename="NVIDIA Web Helper.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Razer"; Parent=""; Basename="Razer Central.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Razer"; Parent=""; Basename="Razer Updater.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Razer"; Parent=""; Basename="RazerCentralService.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Razer"; Parent=""; Basename="GameManagerService.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Razer"; Parent=""; Basename="GameManagerServiceStartup.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Razer"; Parent=""; Basename="Razer Synapse Service.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Razer"; Parent=""; Basename="Razer Synapse Service Process.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Razer"; Parent=""; Basename="Razer Synapse 3.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Razer Chroma SDK"; Parent=""; Basename="RzChromaAppManager.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Razer Chroma SDK"; Parent=""; Basename="RzSDKClient.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Razer Chroma SDK"; Parent=""; Basename="RzSDKClientS.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Razer Chroma SDK"; Parent=""; Basename="RzSDKServer.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Razer Chroma SDK"; Parent=""; Basename="RzSDKService.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Splashtop"; Parent=""; Basename="SSUService.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Splashtop"; Parent=""; Basename="SRService.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Splashtop"; Parent=""; Basename="strwinclt.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Unigine"; Parent=""; Basename="Heaven.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="WinDirStat"; Parent=""; Basename="windirstat.exe"; };
		# -- PROCESSES -- ProgData
		# $ExcludedProcesses += ((${ProgData})+("\..."));
		# -- PROCESSES -- Sys32
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Parent=""; Basename="ApplicationFrameHost.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Parent=""; Basename="BackgroundTransferHost.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Parent=""; Basename="DbxSvc.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir="DriverStore\FileRepository"; Parent=""; Basename="igfxEM.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir="DriverStore\FileRepository"; Parent=""; Basename="IntelCpHDCPSvc.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir="DriverStore\FileRepository"; Parent=""; Basename="IntelCpHeciSvc.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir="DriverStore\FileRepository"; Parent=""; Basename="igfxEM.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Parent=""; Basename="dwm.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Parent=""; Basename="fontdrvhost.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Parent=""; Basename="lsass.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Parent=""; Basename="mmc.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Parent=""; Basename="RuntimeBroker.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Parent=""; Basename="SearchIndexer.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Parent=""; Basename="taskmgr.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir="wbem"; Parent=""; Basename="unsecapp.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir="wbem"; Parent=""; Basename="WmiPrvSE.exe"; };
		# -- PROCESSES -- SysDrive
		$ExcludedProcesses += @{ Dirname=${SysDrive}; AddDir="ProgramData\Microsoft\Windows Defender\Platform"; Parent=""; Basename="MsMpEng.exe"; };
		$ExcludedProcesses += @{ Dirname=${SysDrive}; AddDir="ProgramData\Microsoft\Windows Defender\Platform"; Parent=""; Basename="NisSrv.exe"; };
		# -- PROCESSES -- SysRoot
		$ExcludedProcesses += @{ Dirname=${SysRoot}; AddDir=""; Parent=""; Basename="explorer.exe"; };
		# -- PROCESSES -- UserProfile
		$ExcludedProcesses += @{ Dirname=${UserProfile}; AddDir="Documents\MobaXterm"; Parent=""; Basename="Motty.exe"; };
		# ------------------------------------------------------------
		#
		#		APPLY THE EXCLUSIONS
		#
		$ExcludedFilepaths | Select-Object -Unique | ForEach-Object {
			If ($_ -ne $null) {
				If (Test-Path $_) {
					$FoundFilepaths += $_;
				}
				If ($AntiVirusSoftware -eq "Windows Defender") {
					Add-MpPreference -ExclusionPath "$_";
					If ($? -eq $True) {
						If ($PSBoundParameters.ContainsKey('Verbose')) { Write-Host (("Successfully added exclusion for filepath   [ ")+($_)+(" ]")); }
					} Else {
						If (Test-Path $_) {
							If ($PSBoundParameters.ContainsKey('Verbose')) { Write-Host (("Error(s) encountered while trying to exlude filepath:   [ ")+($_)+(" ]")); }
						} Else {
							If ($PSBoundParameters.ContainsKey('Verbose')) { Write-Host (("Skipping exclusion (filepath doesn't exist)   [ ")+($_)+(" ]")); }
						}
					}
				}
			}
		}
		$ExcludedExtensions | Select-Object -Unique | ForEach-Object {
			If ($_ -ne $null) {
				$FoundExtensions += $_;
				If ($AntiVirusSoftware -eq "Windows Defender") {
					Add-MpPreference -ExclusionExtension "$_";
					If ($? -eq $True) {
						If ($PSBoundParameters.ContainsKey('Verbose')) { Write-Host (("Successfully added exclusion for extension   [ ")+($_)+(" ]")); }
					} Else {
						If ($PSBoundParameters.ContainsKey('Verbose')) { Write-Host (("Error(s) encountered while trying to exlude extension:   [ ")+($_)+(" ]")); }
					}
				}
			}
		}
		# Determine which process(es) exist locally
		$ExcludedProcesses | ForEach {
			If ($_ -ne $null) {
				$Each_Dirname = $_.Dirname;
				If ($_.AddDir -ne "") {
					$Each_Dirname = (($_.Dirname)+("\")+($_.AddDir));
				}
				$Each_Basename = $_.Basename;
				If ((Test-Path $Each_Dirname) -And ($Each_Basename -ne "")) {

					If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host "Searching `"${Each_Dirname}`" for `"${Each_Basename}`"..."; }

					Get-ChildItem -Path ("$Each_Dirname") -Filter ("$Each_Basename") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { (($Parent -Eq "") -Or ($_.Directory.Name -Eq "$Parent")) } | Foreach-Object { $FoundProcesses += $_.FullName; };
					# -Depth (${Depth_GitConfigFile}) 

					If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host "FoundProcesses:"; $FoundProcesses; }
					
					# If ($AntiVirusSoftware -eq "Windows Defender") {
					# 	Add-MpPreference -ExclusionProcess "$_";
					# 	If ($? -eq $True) {
					# 		If ($PSBoundParameters.ContainsKey('Verbose')) { Write-Host (("Successfully added exclusion for process   [ ")+($_)+(" ]")); }
					# 	} Else {
					# 		If (Test-Path $_) {
					# 			If ($PSBoundParameters.ContainsKey('Verbose')) { Write-Host (("Error(s) encountered while trying to exlude process:   [ ")+($_)+(" ]")); }
					# 		} Else {
					# 			If ($PSBoundParameters.ContainsKey('Verbose')) { Write-Host (("Skipping exclusion (process doesn't exist)   [ ")+($_)+(" ]")); }
					# 		}
					# 	}
					# }
				}
			}
		}


		# ------------------------------------------------------------
		# REMOVE AFTER DONE DEBUGGING
		Write-Host "`n`n`$FoundProcesses:`n"; $FoundProcesses; Write-Host "`n`n";
		$WaitCloseSeconds = 60;
		Write-Host "`nClosing after ${WaitCloseSeconds}s...";
		Write-Host "`n";
		Start-Sleep -Seconds ${WaitCloseSeconds};
		# ------------------------------------------------------------

		# ESET Exclusions --> Construct an Import-file which contains all exclusions
		$ImportFilepath = $null;
		If ($AntiVirusSoftware -eq "ESET") {

			$PreExportFilepath = ((${Env:USERPROFILE})+("\Desktop\eset-export.xml"));

			ESET_ExportModifier -PreExportFilepath ($PreExportFilepath) -ESET_ExcludeFilepaths ($FoundFilepaths) -ESET_ExcludeExtensions ($FoundExtensions) -ESET_ExcludeProcesses ($FoundProcesses);

		}
		#
		# ------------------------------------------------------------
		#
		#		REVIEW FINAL EXCLUSIONS-LIST
		#
		If (!($PSBoundParameters.ContainsKey('Quiet'))) { 
			If ($AntiVirusSoftware -eq "Windows Defender") {
				$LiveMpPreference = Get-MpPreference;
				Write-Host "`nExclusions - File Extensions:"; If ($LiveMpPreference.ExclusionExtension -eq $Null) { Write-Host "None"; } Else { $LiveMpPreference.ExclusionExtension; } `
				Write-Host "`nExclusions - Processes:"; If ($LiveMpPreference.ExclusionProcess -eq $Null) { Write-Host "None"; } Else { $LiveMpPreference.ExclusionProcess; } `
				Write-Host "`nExclusions - Paths:"; If ($LiveMpPreference.ExclusionPath -eq $Null) { Write-Host "None"; } Else { $LiveMpPreference.ExclusionPath; } `
			} Else {
				Write-Host "`nExclusions - Found Filepaths:"; If ($FoundFilepaths -eq $Null) { Write-Host "None"; } Else { $FoundFilepaths; } `
				Write-Host "`nExclusions - Found Extensions:"; If ($FoundExtensions -eq $Null) { Write-Host "None"; } Else { $FoundExtensions; } `
				Write-Host "`nExclusions - Found Processes:"; If ($FoundProcesses -eq $Null) { Write-Host "None"; } Else { $FoundProcesses; } `
			}
			Write-Host "`n";
			If ($ImportFilepath -ne $null) {
				Write-Host "";
				Write-Host "Exlusions output to filepath: " -ForegroundColor "Red" -BackgroundColor "Black";
				Write-Host "`n";
				Write-Host (("      ")+($ImportFilepath)+("      ")) -ForegroundColor "Yellow" -BackgroundColor "Black";
				Write-Host "`n";
				Write-Host (("Open ")+($AntiVirusSoftware)+(" and Import the exclusions file (above)")) -ForegroundColor "Red" -BackgroundColor "Black";
				Write-Host "`n`n";
			}
			$WaitCloseSeconds = 60;
			Write-Host "`nClosing after ${WaitCloseSeconds}s...";
			Write-Host "`n";
			Start-Sleep -Seconds ${WaitCloseSeconds};
		}
		#
		# ------------------------------------------------------------
		#
	}
}
Export-ModuleMember -Function "ExclusionsListUpdate";
#
#
#
# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#
#
function ESET_ExportModifier {
	Param(

		[Parameter(Mandatory=$true)]
		[String[]]$PreExportFilepath,
		
		[String[]]$ESET_ExcludeFilepaths = @(),

		[String[]]$ESET_ExcludeProcesses = @(),

		[String[]]$ESET_ExcludeExtensions = @()

	)

	If ((Test-Path -Path ("$PreExportFilepath")) -eq $False) {
		Write-Host "";
		Write-Host "  Error in function `"ESET_ExportModifier`"  " -BackgroundColor ("Black") -ForegroundColor ("Red");
		Write-Host "    File not found: `$PreExportFilepath = `"$PreExportFilepath`"    " -BackgroundColor ("Black") -ForegroundColor ("Red");
		Write-Host "";
	} Else {
		

		$Dirname_ESET_Import = ((${Env:USERPROFILE})+("\Desktop\eset-import"));
		$Basename_ESET_Import = (("eset-import_")+(Get-Date -UFormat "%Y%m%d-%H%M%S")+(".xml"));
		$Filepath_ESET_Import = (($Dirname_ESET_Import)+("\")+($Basename_ESET_Import));
		
		If ((Test-Path -Path ($Dirname_ESET_Import)) -eq $false) {
			New-Item -ItemType "Directory" -Path ($Dirname_ESET_Import) | Out-Null;
		}

		Set-Content -Path ($Filepath_ESET_Import) -Value (Get-Content -Path ("$PreExportFilepath"));

		#
		# ------------------------------------------------------------
		#
		# ESET - Process Exclusions
		#
		$RowsReplaced_Processes = "";
		$RowsStart_Processes = "";
		$RowsBetween_Processes = "";
		$RowsEnd_Processes = "";
		$FoundStart_Processes = $null;
		$FoundEnd_Processes = $null;
		$RegexStart_Processes = '^     <ITEM NAME="ExcludedProcesses" DELETE="1">$';
		$RegexEnd_Processes = '^     </ITEM>$';
		#
		# Prebuilt String - Process Exclusions
		$i_FilepathName_Base10 = 1;
		$ESET_ExcludeProcesses | Select-Object -Unique | ForEach-Object {
			$i_FilepathName_Base16 = (([Convert]::ToString($i_FilepathName_Base10, 16)).ToUpper());
			$RowsReplaced_Processes += (('      <NODE NAME="')+($i_FilepathName_Base16)+('" TYPE="string" VALUE="')+($_)+('" />')+("`n"));
			$i_FilepathName_Base10++;
		}
		#
		# ------------------------------------------------------------
		#
		# ESET - Filepath Exclusions
		#
		$RowsReplaced_Filepaths = "";
		$RowsStart_Filepaths = "";
		$RowsBetween_Filepaths = "";
		$RowsEnd_Filepaths = "";
		$FoundStart_Filepaths = $null;
		$FoundEnd_Filepaths = $null;
		$RegexStart_Filepaths = '^     <ITEM NAME="ScannerExcludes" DELETE="1">$';
		$RegexEnd_Filepaths = '^     </ITEM>$';
		#
		# Prebuilt String - Filepath Exclusions
		$i_FilepathName_Base10 = 1;
		$ESET_ExcludeFilepaths | Select-Object -Unique | ForEach-Object {
			# \*
			$i_FilepathName_Base16 = (([Convert]::ToString($i_FilepathName_Base10, 16)).ToUpper());
			$RowsReplaced_Filepaths += (('      <ITEM NAME="')+($i_FilepathName_Base16)+('">')+("`n"));
			$RowsReplaced_Filepaths += (('       <NODE NAME="ExcludeType" TYPE="number" VALUE="0" />')+("`n"));
			$RowsReplaced_Filepaths += (('       <NODE NAME="Infiltration" TYPE="string" VALUE="" />')+("`n"));		
			$RowsReplaced_Filepaths += (('       <NODE NAME="FullPath" TYPE="string" VALUE="')+($_)+('\*" />')+("`n"));
			$RowsReplaced_Filepaths += (('       <NODE NAME="Flags" TYPE="number" VALUE="0" />')+("`n"));
			$RowsReplaced_Filepaths += (('       <NODE NAME="Hash" TYPE="string" VALUE="" />')+("`n"));
			$RowsReplaced_Filepaths += (('       <NODE NAME="Description" TYPE="string" VALUE="" />')+("`n"));
			$RowsReplaced_Filepaths += (('      </ITEM>')+("`n"));
			$i_FilepathName_Base10++;
			# \*.*
			$i_FilepathName_Base16 = (([Convert]::ToString($i_FilepathName_Base10, 16)).ToUpper());
			$RowsReplaced_Filepaths += (('      <ITEM NAME="')+($i_FilepathName_Base16)+('">')+("`n"));
			$RowsReplaced_Filepaths += (('       <NODE NAME="ExcludeType" TYPE="number" VALUE="0" />')+("`n"));
			$RowsReplaced_Filepaths += (('       <NODE NAME="Infiltration" TYPE="string" VALUE="" />')+("`n"));		
			$RowsReplaced_Filepaths += (('       <NODE NAME="FullPath" TYPE="string" VALUE="')+($_)+('\*.*" />')+("`n"));
			$RowsReplaced_Filepaths += (('       <NODE NAME="Flags" TYPE="number" VALUE="0" />')+("`n"));
			$RowsReplaced_Filepaths += (('       <NODE NAME="Hash" TYPE="string" VALUE="" />')+("`n"));
			$RowsReplaced_Filepaths += (('       <NODE NAME="Description" TYPE="string" VALUE="" />')+("`n"));
			$RowsReplaced_Filepaths += (('      </ITEM>')+("`n"));
			$i_FilepathName_Base10++;
		}
		#
		# ------------------------------------------------------------
		#
		# ESET - Extension Exclusions
		#
		# $ESET_ExclExt_Content = @();
		# $ESET_ExcludeExtensions | Select-Object -Unique | ForEach-Object {
		# 	$ESET_ExclExt_Content += '        <ITEM NAME="ExcludeExtensions" DELETE="1">';
		# 	$ESET_ExclExt_Content += '         <NODE NAME="1" TYPE="string" VALUE="iso" />';
		# 	$ESET_ExclExt_Content += '         <NODE NAME="2" TYPE="string" VALUE="avhd" />';
		# 	$ESET_ExclExt_Content += '         <NODE NAME="3" TYPE="string" VALUE="avhdx" />';
		# 	$ESET_ExclExt_Content += '        </ITEM>';
		# }
		# $ReturnedStringArr += $ESET_ExclExt_Content;
		#
		# ------------------------------------------------------------
		#
		#	Parse the contents of the ESET config-file
		#		--> Process Exclusions
		#
		$i_RowNum = 0;
		Get-Content -Path ($Filepath_ESET_Import) | Select-Object | ForEach-Object {
			If ($FoundStart_Processes -eq $null) {
				$RowsStart_Processes = (($RowsStart_Processes)+("`n")+($_));
				If (([Regex]::Match($_, $RegexStart_Processes)).Success -eq $True) {
					$FoundStart_Processes = $i_RowNum;
				}
			} Else {
				If ($FoundEnd_Processes -ne $null) {
					$RowsEnd_Processes = (($RowsEnd_Processes)+("`n")+($_));
				} ElseIf (([Regex]::Match($_, $RegexEnd_Processes)).Success -eq $True) {
					$RowsEnd_Processes = (($RowsEnd_Processes)+("`n")+($_));
					$FoundEnd_Processes = $i_RowNum;
				} Else {
					$RowsBetween_Processes = (($RowsBetween_Processes)+("`n")+($_));
				}
			}
			$i_RowNum++;
		}
		$Contents_ESET_Import = (($RowsStart_Processes)+("`n")+($RowsBetween_Processes)+("`n")+($RowsEnd_Processes));
		$Contents_ESET_Import = $Contents_ESET_Import.Replace("`n`n", "`n");
			$Contents_ESET_Import = $Contents_ESET_Import.Replace("`n`n", "`n");
				$Contents_ESET_Import = $Contents_ESET_Import.Replace("`n`n", "`n");
		$Contents_ESET_Import = $Contents_ESET_Import.Trim();
		#
		#
		Set-Content -Path ($Filepath_ESET_Import) -Value ($Contents_ESET_Import);
		#
		#
		# ------------------------------------------------------------
		#
		#	Parse the contents of the ESET config-file
		#		--> Filepath Exclusions
		#
		$i_RowNum = 0;
		Get-Content -Path ($Filepath_ESET_Import) | Select-Object | ForEach-Object {
			If ($FoundStart_Filepaths -eq $null) {
				$RowsStart_Filepaths = (($RowsStart_Filepaths)+("`n")+($_));
				If (([Regex]::Match($_, $RegexStart_Filepaths)).Success -eq $True) {
					$FoundStart_Filepaths = $i_RowNum;
				}
			} Else {
				If ($FoundEnd_Filepaths -ne $null) {
					$RowsEnd_Filepaths = (($RowsEnd_Filepaths)+("`n")+($_));
				} ElseIf (([Regex]::Match($_, $RegexEnd_Filepaths)).Success -eq $True) {
					$RowsEnd_Filepaths = (($RowsEnd_Filepaths)+("`n")+($_));
					$FoundEnd_Filepaths = $i_RowNum;
				} Else {
					$RowsBetween_Filepaths = (($RowsBetween_Filepaths)+("`n")+($_));
				}
			}
			$i_RowNum++;
		}
		$Contents_ESET_Import = (($RowsStart_Filepaths)+("`n")+($RowsReplaced_Filepaths)+("`n")+($RowsEnd_Filepaths));
		$Contents_ESET_Import = $Contents_ESET_Import.Replace("`n`n", "`n");
			$Contents_ESET_Import = $Contents_ESET_Import.Replace("`n`n", "`n");
				$Contents_ESET_Import = $Contents_ESET_Import.Replace("`n`n", "`n");
		$Contents_ESET_Import = $Contents_ESET_Import.Trim();
		#
		#
		Set-Content -Path ($Filepath_ESET_Import) -Value ($Contents_ESET_Import);
		#
		#
		#
		# ------------------------------------------------------------
		#
		# 	Show the directory containing the import-file

		Explorer.exe "$Dirname_ESET_Import";

		# 
		# ------------------------------------------------------------
	}
}
Export-ModuleMember -Function "ESET_ExportModifier";



# ------------------------------------------------------------
#
# Citation(s)
#
#	------------------------------------------------------------
#
#		docs.microsoft.com
#
#			"Add-MpPreference"
#			https://docs.microsoft.com/en-us/powershell/module/defender/add-mppreference?view=win10-ps
#
#			"Configure Windows Defender Antivirus exclusions on Windows Server"
#			https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-antivirus/configure-server-exclusions-windows-defender-antivirus
#
#			"Configure and validate exclusions based on file extension and folder location"
#			https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-antivirus/configure-extension-file-exclusions-windows-defender-antivirus
#
# ------------------------------------------------------------
#
#		stackoverflow
#
#			"How to monitor Windows Defender real time protection?"
#			https://superuser.com/questions/1256548 (pulled 2019-05-29_05-57-37)
#
# ------------------------------------------------------------
