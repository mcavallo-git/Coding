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
		[String[]]$ExcludedProcesses = @(),
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
		$ExcludedProcesses += ((${LocalAppData})+("\Dropbox\Client\Dropbox.exe"));
		$ExcludedProcesses += ((${LocalAppData})+("\GitHubDesktop\GitHubDesktop.exe"));
		$ExcludedProcesses += ((${LocalAppData})+("\GitHubDesktop\app-1.6.6\GitHubDesktop.exe"));
		$ExcludedProcesses += ((${LocalAppData})+("\GitHubDesktop\app-1.6.6\resources\app\git\mingw64\bin\git.exe"));
		$ExcludedProcesses += ((${LocalAppData})+("\GitHubDesktop\app-1.6.6\resources\app\git\mingw64\bin\git-lfs.exe"));
		# -- PROCESSES -- ProgFiles X64
		$ExcludedProcesses += ((${ProgFilesX64})+("\AutoHotkey\AutoHotkey.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\Classic Shell\ClassicStartMenu.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\Cryptomator\Cryptomator.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\FileZilla FTP Client\filezilla.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\Git\cmd\git.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\Git\git-bash.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\Git\mingw64\bin\git.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\Greenshot\Greenshot.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\Mailbird\CefSharp.BrowserSubprocess.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\Mailbird\Mailbird.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\Mailbird\MailbirdUpdater.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\Mailbird\sqlite3.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\Mailbird\x64\CefSharp.BrowserSubprocess.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\Malwarebytes\Anti-Malware\mbam.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\Malwarebytes\Anti-Malware\mbamtray.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\Malwarebytes\Anti-Malware\mbamservice.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\Microsoft VS Code\Code.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\Microsoft VS Code\resources\app\node_modules.asar.unpacked\vscode-ripgrep\bin\rg.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\NVIDIA Corporation\Display.NvContainer\NVDisplay.Container.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\NVIDIA Corporation\NvContainer\nvcontainer.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\NVIDIA Corporation\ShadowPlay\nvsphelper64.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\NVIDIA Corporation\NVIDIA GeForce Experience\NVIDIA GeForce Experience.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\NVIDIA Corporation\NVIDIA GeForce Experience\NVIDIA Notification.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\NVIDIA Corporation\NVIDIA GeForce Experience\NVIDIA Share.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\NVIDIA Corporation\NvTelemetry\NvTelemetryContainer.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\TortoiseGit\bin\TGitCache.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\WindowsApps\Microsoft.XboxApp_48.53.21003.0_x64__8wekyb3d8bbwe\XboxApp.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\WindowsApps\AppUp.IntelGraphicsExperience_1.100.1244.0_x64__8j3eq9eme6ctt\GCP.ML.BackgroundSysTray\IGCCTray.exe"));
		$ExcludedProcesses += ((${ProgFilesX64})+("\WindowsApps\AppUp.IntelGraphicsExperience_1.100.1244.0_x64__8j3eq9eme6ctt\IGCC.exe"));
		# -- PROCESSES -- ProgFiles X86
		$ExcludedProcesses += ((${ProgFilesX86})+("\Dropbox\Client\Dropbox.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Intel\Driver and Support Assistant\DSAService.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Intel\Thunderbolt Software\tbtsvc.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Intel\Thunderbolt Software\Thunderbolt.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\LastPass\ie_extract.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\LastPass\lastpass.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\LastPass\LastPassBroker.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\LastPass\nplastpass.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\LastPass\WinBioStandalone.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\LastPass\wlandecrypt.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Microsoft Office\root\Office16\lync.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Microsoft Office\root\Office16\EXCEL.EXE"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Microsoft Office\root\Office16\lync.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Microsoft Office\root\Office16\lync99.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Microsoft Office\root\Office16\lynchtmlconv.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Microsoft Office\root\Office16\MSACCESS.EXE"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Microsoft Office\root\Office16\ONENOTE.EXE"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Microsoft Office\root\Office16\ONENOTEM.EXE"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Microsoft Office\root\Office16\OUTLOOK.EXE"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Microsoft Office\root\Office16\POWERPNT.EXE"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Microsoft Office\root\Office16\WINWORD.EXE"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Mobatek\MobaXterm\MobaXterm.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Notepad++\notepad++.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\NVIDIA Corporation\NvNode\NVIDIA Web Helper.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Razer\Razer Services\Razer Central\Razer Central.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Razer\Razer Services\Razer Central\Razer Updater.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Razer\Razer Services\Razer Central\RazerCentralService.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Razer\Razer Services\GMS\GameManagerService.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Razer\Razer Services\GMS\GameManagerServiceStartup.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Razer\Synapse3\Service\Razer Synapse Service.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Razer\Synapse3\UserProcess\Razer Synapse Service Process.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Razer\Synapse3\WPFUI\Framework\Razer Synapse 3 Host\Razer Synapse 3.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Razer Chroma SDK\bin\RzChromaAppManager.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Razer Chroma SDK\bin\RzSDKClient.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Razer Chroma SDK\bin\RzSDKClientS.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Razer Chroma SDK\bin\RzSDKServer.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Razer Chroma SDK\bin\RzSDKService.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Splashtop\Splashtop Software Updater\SSUService.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Splashtop\Splashtop Remote\Server\SRService.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Splashtop\Splashtop Remote\Client for STP\strwinclt.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\Unigine\Heaven Benchmark 4.0\bin\Heaven.exe"));
		$ExcludedProcesses += ((${ProgFilesX86})+("\WinDirStat\windirstat.exe"));
		# -- PROCESSES -- ProgData
		# $ExcludedProcesses += ((${ProgData})+("\..."));
		# -- PROCESSES -- Sys32
		$ExcludedProcesses += ((${Sys32})+("\ApplicationFrameHost.exe")); # XB1
		$ExcludedProcesses += ((${Sys32})+("\BackgroundTransferHost.exe")); # XB1
		$ExcludedProcesses += ((${Sys32})+("\DbxSvc.exe")); # Dropbox
		$ExcludedProcesses += ((${Sys32})+("\DriverStore\FileRepository\ki131074.inf_amd64_6371bf46cc74b27d\igfxEM.exe")); # INTEL
		$ExcludedProcesses += ((${Sys32})+("\DriverStore\FileRepository\ki131074.inf_amd64_6371bf46cc74b27d\IntelCpHDCPSvc.exe")); # INTEL
		$ExcludedProcesses += ((${Sys32})+("\DriverStore\FileRepository\ki131074.inf_amd64_6371bf46cc74b27d\IntelCpHeciSvc.exe")); # INTEL
		$ExcludedProcesses += ((${Sys32})+("\DriverStore\FileRepository\igdlh64.inf_amd64_8a9535cd18c90bc3\igfxEM.exe")); # INTEL
		$ExcludedProcesses += ((${Sys32})+("\DriverStore\FileRepository\igdlh64.inf_amd64_8a9535cd18c90bc3\IntelCpHDCPSvc.exe")); # INTEL
		$ExcludedProcesses += ((${Sys32})+("\DriverStore\FileRepository\igdlh64.inf_amd64_8a9535cd18c90bc3\IntelCpHeciSvc.exe")); # INTEL
		$ExcludedProcesses += ((${Sys32})+("\DriverStore\FileRepository\ki131074.inf_amd64_6371bf46cc74b27d\igfxEM.exe")); # INTEL
		$ExcludedProcesses += ((${Sys32})+("\dwm.exe")); # "Desktop Window Manager"
		$ExcludedProcesses += ((${Sys32})+("\fontdrvhost.exe"));
		$ExcludedProcesses += ((${Sys32})+("\lsass.exe"));
		$ExcludedProcesses += ((${Sys32})+("\mmc.exe")); # "Microsoft Management Console" (Task Scheduler, namely)
		$ExcludedProcesses += ((${Sys32})+("\RuntimeBroker.exe")); # XB1
		$ExcludedProcesses += ((${Sys32})+("\SearchIndexer.exe"));
		$ExcludedProcesses += ((${Sys32})+("\taskmgr.exe"));
		$ExcludedProcesses += ((${Sys32})+("\wbem\unsecapp.exe")); # WMI external calls
		$ExcludedProcesses += ((${Sys32})+("\wbem\WmiPrvSE.exe")); # "WMI Provider Host", e.g. Windows Management Instrumentation Provider Host
		# -- PROCESSES -- SysDrive
		$ExcludedProcesses += ((${SysDrive})+("\ProgramData\Microsoft\Windows Defender\Platform\4.18.1904.1-0\MsMpEng.exe"));
		$ExcludedProcesses += ((${SysDrive})+("\ProgramData\Microsoft\Windows Defender\Platform\4.18.1904.1-0\NisSrv.exe"));
		# -- PROCESSES -- SysRoot
		$ExcludedProcesses += ((${SysRoot})+("\explorer.exe"));
		# -- PROCESSES -- UserProfile
		$ExcludedProcesses += ((${UserProfile})+("\Documents\MobaXterm\slash\bin\Motty.exe"));
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
		$ExcludedProcesses | Select-Object -Unique | ForEach-Object {
			If ($_ -ne $null) {
				If (Test-Path $_) {
					$FoundProcesses += $_;
				}
				If ($AntiVirusSoftware -eq "Windows Defender") {
					Add-MpPreference -ExclusionProcess "$_";
					If ($? -eq $True) {
						If ($PSBoundParameters.ContainsKey('Verbose')) { Write-Host (("Successfully added exclusion for process   [ ")+($_)+(" ]")); }
					} Else {
						If (Test-Path $_) {
							If ($PSBoundParameters.ContainsKey('Verbose')) { Write-Host (("Error(s) encountered while trying to exlude process:   [ ")+($_)+(" ]")); }
						} Else {
							If ($PSBoundParameters.ContainsKey('Verbose')) { Write-Host (("Skipping exclusion (process doesn't exist)   [ ")+($_)+(" ]")); }
						}
					}
				}
			}
		}
		# ESET Exclusions --> Construct an Import-file which contains all exclusions
		$ImportFilepath = $null;
		If ($AntiVirusSoftware -eq "ESET") {

			$PreExportFilepath = ((${Env:USERPROFILE})+("\Desktop\eset-export.xml"));

ESET_ExportModifier `
-PreExportFilepath ($PreExportFilepath) `
-ESET_ExcludeFilepaths ($FoundFilepaths) `
-ESET_ExcludeExtensions ($FoundExtensions) `
-ESET_ExcludeProcesses ($FoundProcesses) `
;

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

		$Contents_ESET_Import = Get-Content -Path ("$PreExportFilepath");

		#
		# ------------------------------------------------------------
		#
		# ESET - Process Exclusions
		#
		#
		#
		$RowsStart = "";
		$RowsBetween = "";
		$RowsEnd = "";
		$FoundStart = $False;
		$FoundEnd = $False;
		$RegexStart = '^     <ITEM NAME="ExcludedProcesses" DELETE="1">$';
		$RegexEnd = '^     </ITEM>$';
		$Contents_ESET_Import | Select-Object | ForEach-Object {
			If ($FoundStart -eq $False) {
				$RowsStart = (($RowsStart)+("`n")+($_));
				If (([Regex]::Match($_, $RegexStart)).Success -eq $True) {
					$FoundStart = $True;
				}
			} Else {
				If ($FoundEnd -eq $True) {
					$RowsEnd = (($RowsEnd)+("`n")+($_));
				} ElseIf (([Regex]::Match($_, $RegexEnd)).Success -eq $True) {
					$RowsEnd = (($RowsEnd)+("`n")+($_));
					$FoundEnd = $True;
				} Else {
					$RowsBetween = (($RowsBetween)+("`n")+($_));
				}
			}
		}
		$NewRowsBetween = "";
		$i_FilepathName_Base10 = 1;
		$ESET_ExcludeProcesses | Select-Object -Unique | ForEach-Object {
			# \*.*
			$i_FilepathName_Base16 = (([Convert]::ToString($i_FilepathName_Base10, 16)).ToUpper());
			$NewRowsBetween += (('      <NODE NAME="')+($i_FilepathName_Base16)+('" TYPE="string" VALUE="')+($_)+('" />')+("`n"));
			$i_FilepathName_Base10++;
		}
		$Contents_ESET_Import = (($RowsStart)+("`n")+($NewRowsBetween)+("`n")+($RowsEnd));
		$Contents_ESET_Import = $Contents_ESET_Import.Replace("`n`n", "`n");
		$Contents_ESET_Import = $Contents_ESET_Import.Replace("`n`n", "`n");
		$Contents_ESET_Import = $Contents_ESET_Import.Replace("`n`n", "`n");
		$Contents_ESET_Import = $Contents_ESET_Import.Trim();
		#
		#
		#
		# ------------------------------------------------------------
		#
		# ESET - Filepath Exclusions
		#
		#
		#
		$RowsStart = "";
		$RowsBetween = "";
		$RowsEnd = "";
		$FoundStart = $False;
		$FoundEnd = $False;
		$RegexStart = '^     <ITEM NAME="ScannerExcludes" DELETE="1">$';
		$RegexEnd = '^     </ITEM>$';
		$Contents_ESET_Import | Select-Object | ForEach-Object {
			If ($FoundStart -eq $False) {
				$RowsStart = (($RowsStart)+("`n")+($_));
				If (([Regex]::Match($_, $RegexStart)).Success -eq $True) {
					$FoundStart = $True;
				}
			} Else {
				If ($FoundEnd -eq $True) {
					$RowsEnd = (($RowsEnd)+("`n")+($_));
				} ElseIf (([Regex]::Match($_, $RegexEnd)).Success -eq $True) {
					$RowsEnd = (($RowsEnd)+("`n")+($_));
					$FoundEnd = $True;
				} Else {
					$RowsBetween = (($RowsBetween)+("`n")+($_));
				}
			}
		}
		$NewRowsBetween = "";
		$i_FilepathName_Base10 = 1;
		$ESET_ExcludeFilepaths | Select-Object -Unique | ForEach-Object {
			# \*
			$i_FilepathName_Base16 = (([Convert]::ToString($i_FilepathName_Base10, 16)).ToUpper());
			$NewRowsBetween += (('      <ITEM NAME="')+($i_FilepathName_Base16)+('">')+("`n"));
			$NewRowsBetween += (('       <NODE NAME="ExcludeType" TYPE="number" VALUE="0" />')+("`n"));
			$NewRowsBetween += (('       <NODE NAME="Infiltration" TYPE="string" VALUE="" />')+("`n"));		
			$NewRowsBetween += (('       <NODE NAME="FullPath" TYPE="string" VALUE="')+($_)+('\*" />')+("`n"));
			$NewRowsBetween += (('       <NODE NAME="Flags" TYPE="number" VALUE="0" />')+("`n"));
			$NewRowsBetween += (('       <NODE NAME="Hash" TYPE="string" VALUE="" />')+("`n"));
			$NewRowsBetween += (('       <NODE NAME="Description" TYPE="string" VALUE="" />')+("`n"));
			$NewRowsBetween += (('      </ITEM>')+("`n"));
			$i_FilepathName_Base10++;
			# \*.*
			$i_FilepathName_Base16 = (([Convert]::ToString($i_FilepathName_Base10, 16)).ToUpper());
			$NewRowsBetween += (('      <ITEM NAME="')+($i_FilepathName_Base16)+('">')+("`n"));
			$NewRowsBetween += (('       <NODE NAME="ExcludeType" TYPE="number" VALUE="0" />')+("`n"));
			$NewRowsBetween += (('       <NODE NAME="Infiltration" TYPE="string" VALUE="" />')+("`n"));		
			$NewRowsBetween += (('       <NODE NAME="FullPath" TYPE="string" VALUE="')+($_)+('\*.*" />')+("`n"));
			$NewRowsBetween += (('       <NODE NAME="Flags" TYPE="number" VALUE="0" />')+("`n"));
			$NewRowsBetween += (('       <NODE NAME="Hash" TYPE="string" VALUE="" />')+("`n"));
			$NewRowsBetween += (('       <NODE NAME="Description" TYPE="string" VALUE="" />')+("`n"));
			$NewRowsBetween += (('      </ITEM>')+("`n"));
			$i_FilepathName_Base10++;
		}
		$Contents_ESET_Import = (($RowsStart)+("`n")+($NewRowsBetween)+("`n")+($RowsEnd));
		$Contents_ESET_Import = $Contents_ESET_Import.Replace("`n`n", "`n");
		$Contents_ESET_Import = $Contents_ESET_Import.Replace("`n`n", "`n");
		$Contents_ESET_Import = $Contents_ESET_Import.Replace("`n`n", "`n");
		$Contents_ESET_Import = $Contents_ESET_Import.Trim();
		#
		#
		#
		# ------------------------------------------------------------
		#
		# ESET - Extension Exclusions
		#
		#
		#
		$ESET_ExclExt_Content = @();
		$ESET_ExcludeExtensions | Select-Object -Unique | ForEach-Object {
			$ESET_ExclExt_Content += '        <ITEM NAME="ExcludeExtensions" DELETE="1">';
			$ESET_ExclExt_Content += '         <NODE NAME="1" TYPE="string" VALUE="iso" />';
			$ESET_ExclExt_Content += '         <NODE NAME="2" TYPE="string" VALUE="avhd" />';
			$ESET_ExclExt_Content += '         <NODE NAME="3" TYPE="string" VALUE="avhdx" />';
			$ESET_ExclExt_Content += '        </ITEM>';
		}
		$ReturnedStringArr += $ESET_ExclExt_Content;
		#
		#
		#
		# ------------------------------------------------------------
		#

		$ImportDirname = ((${Env:USERPROFILE})+("\Desktop\eset-import"));
		$ImportBasename = (("eset-import_")+(Get-Date -UFormat "%Y%m%d-%H%M%S")+(".xml"));
		$ImportFilepath = (($ImportDirname)+("\")+($ImportBasename));
		
		If ((Test-Path -Path ($ImportDirname)) -eq $false) {
			New-Item -ItemType "Directory" -Path ($ImportDirname) | Out-Null;
		}
		
		Set-Content -Path ($ImportFilepath) -Value ($Contents_ESET_Import);
		
		# Open the containing directory for the user
		Explorer.exe "$ImportDirname";

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
