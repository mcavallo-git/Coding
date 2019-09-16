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

		[Switch]$ESET,
		[String]$ESET_ExportToCopyFrom = "",

		[Switch]$MalwarebytesAntiMalware,

		[Switch]$MalwarebytesAntiRansomware,

		[Switch]$MalwarebytesAntiExploit,

		[Switch]$WindowsDefender,
		[Switch]$Defender, 

		$ExcludedFilepaths = @(),
		$ExcludedProcesses = @(),
		$ExcludedExtensions = @(),

		[Switch]$Personal,
		[Switch]$Entertainment,

		[Switch]$Quiet,
		[Switch]$Verbose

	)

	$ESET = If ($PSBoundParameters.ContainsKey('ESET')) { $True } Else { $False };
	$MalwarebytesAntiMalware = If ($PSBoundParameters.ContainsKey('MalwarebytesAntiMalware')) { $True } Else { $False };
	$MalwarebytesAntiRansomware = If ($PSBoundParameters.ContainsKey('MalwarebytesAntiRansomware')) { $True } Else { $False };
	$MalwarebytesAntiExploit = If ($PSBoundParameters.ContainsKey('MalwarebytesAntiExploit')) { $True } Else { $False };
	$WindowsDefender = If (($PSBoundParameters.ContainsKey('WindowsDefender')) -Or ($PSBoundParameters.ContainsKey('Defender'))) { $True } Else { $False };

	$ESET_ExportToCopyFrom = If ($ESET_ExportToCopyFrom -Ne "") { $ESET_ExportToCopyFrom } Else { ((${Env:USERPROFILE})+("\Desktop\eset-export.xml")) };

	$IncludePersonal = If ($PSBoundParameters.ContainsKey('Personal')) { $True } Else { $False };
	$IncludeEntertainment = If (($PSBoundParameters.ContainsKey('Personal')) -Or ($PSBoundParameters.ContainsKey('Entertainment'))) { $True } Else { $False };

	Write-Host "";
	Write-Host "  Exclusions List Update  " -BackgroundColor ("Black") -ForegroundColor ("Green");
	Write-Host "";
	Write-Host "  Antivirus Software:  " -BackgroundColor ("Black") -ForegroundColor ("Green");
	If ($ESET -eq $True) { Write-Host "    ESET    " -BackgroundColor ("Black") -ForegroundColor ("Green"); }
	If ($MalwarebytesAntiMalware -eq $True) { Write-Host "    MalwarebytesAntiMalware    " -BackgroundColor ("Black") -ForegroundColor ("Green"); }
	If ($MalwarebytesAntiRansomware -eq $True) { Write-Host "    MalwarebytesAntiRansomware    " -BackgroundColor ("Black") -ForegroundColor ("Green"); }
	If ($MalwarebytesAntiExploit -eq $True) { Write-Host "    MalwarebytesAntiExploit    " -BackgroundColor ("Black") -ForegroundColor ("Green"); }
	If ($WindowsDefender -eq $True) { Write-Host "    WindowsDefender    " -BackgroundColor ("Black") -ForegroundColor ("Green"); }
	Write-Host "";
	
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
		
		$CommandString = "ExclusionsListUpdate";

		If ($ESET -eq $True) {                           $CommandString = "$CommandString -ESET"; }
		If ($MalwarebytesAntiMalware -eq $True) {        $CommandString = "$CommandString -MalwarebytesAntiMalware"; }
		If ($MalwarebytesAntiRansomware -eq $True) {     $CommandString = "$CommandString -MalwarebytesAntiRansomware"; }
		If ($MalwarebytesAntiExploit -eq $True) {        $CommandString = "$CommandString -MalwarebytesAntiExploit"; }
		If ($WindowsDefender -eq $True) {                $CommandString = "$CommandString -WindowsDefender"; }
		If ($PSBoundParameters.ContainsKey('Quiet')) {   $CommandString = "$CommandString -Quiet"; }
		If ($PSBoundParameters.ContainsKey('Verbose')) { $CommandString = "$CommandString -Verbose"; }
				
		PrivilegeEscalation -Command ("${CommandString}");

	} Else {

		#
		# ------------------------------------------------------------
		#
		# User/System Directories

		$LocalAppData = (${Env:LocalAppData}); # LocalAppData

		$WindowsApps = ((${Env:LocalAppData})+("\Microsoft\WindowsApps")); # WindowsApps

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
		$ExcludedFilepaths += ((${ProgFilesX86})+("\Malwarebytes' Anti-Malware"));
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
		$ExcludedFilepaths += ((${UserProfile})+("\Documents\Github"));
		# -- FILEPATHS (Environment-Based) -- OneDrive Synced Dir(s)
		If (${Env:OneDrive} -ne $Null) {
			$ExcludedFilepaths += ${Env:OneDrive};
			$ExcludedFilepaths += (${Env:OneDrive}).replace("OneDrive - ","");
		}
		# -- FILEPATHS (Environment-Based) -- Cloud-Synced  :::  Sharepoint Synced Dir(s) / OneDrive-Shared Synced Dir(s)
		If (${Env:OneDriveCommercial} -ne $Null) {
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
		$ExcludedProcesses += @{ Dirname=${LocalAppData}; AddDir="Dropbox"; Depth=""; Parent=""; Basename="Dropbox.exe"; }; # Dropbox
		$ExcludedProcesses += @{ Dirname=${LocalAppData}; AddDir="GitHubDesktop"; Depth="8"; Parent=""; Basename="*.exe"; }; # GitHub Desktop
		$ExcludedProcesses += @{ Dirname=${LocalAppData}; AddDir="Google\Chrome"; Depth=""; Parent=""; Basename="software_reporter_tool.exe"; };
		$ExcludedProcesses += @{ Dirname=${LocalAppData}; AddDir="Microsoft"; Depth="3"; Parent=""; Basename="python*.exe"; }; # Python
		$ExcludedProcesses += @{ Dirname=${LocalAppData}; AddDir="Microsoft"; Depth="3"; Parent=""; Basename="ubuntu*.exe"; }; # Windows Subsystem for Linux (WSL)
		$ExcludedProcesses += @{ Dirname=${LocalAppData}; AddDir="Microsoft"; Depth="3"; Parent=""; Basename="onedrive*.exe"; }; # Microsoft Onedrive
		$ExcludedProcesses += @{ Dirname=${LocalAppData}; AddDir="Microsoft\OneDrive"; Depth="3"; Parent=""; Basename="file*.exe"; }; # Microsoft Onedrive
		$ExcludedProcesses += @{ Dirname=${LocalAppData}; AddDir="Microsoft\Teams"; Depth="1"; Parent=""; Basename="Update.exe"; }; # Microsoft Teams
		$ExcludedProcesses += @{ Dirname=${LocalAppData}; AddDir="Microsoft\Teams\current"; Depth="1"; Parent=""; Basename="Squirrel.exe"; }; # Microsoft Teams
		$ExcludedProcesses += @{ Dirname=${LocalAppData}; AddDir="Microsoft\Teams\current"; Depth="1"; Parent=""; Basename="Teams.exe"; }; # Microsoft Teams
		$ExcludedProcesses += @{ Dirname=${LocalAppData}; AddDir="Postman"; Depth="2"; Parent=""; Basename="Postman.exe"; }; # Postman
		$ExcludedProcesses += @{ Dirname=${LocalAppData}; AddDir="Postman"; Depth="2"; Parent=""; Basename="Update.exe"; }; # Postman
		$ExcludedProcesses += @{ Dirname=${LocalAppData}; AddDir="Postman"; Depth="2"; Parent=""; Basename="Squirrel.exe"; }; # Postman
		$ExcludedProcesses += @{ Dirname=${LocalAppData}; AddDir="Programs\Microsoft VS Code"; Depth=""; Parent=""; Basename="Code*.exe"; }; # VS Code
		# -- PROCESSES -- ProgFiles X64
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="7-Zip"; Depth="2"; Parent=""; Basename="7z*.exe"; }; # 7-Zip
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="AutoHotkey"; Depth=""; Parent=""; Basename="Ahk2Exe.exe"; }; # AutoHotkey
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="AutoHotkey"; Depth=""; Parent=""; Basename="AutoHotkey*.exe"; }; # AutoHotkey
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Classic Shell"; Depth="1"; Parent=""; Basename="*.exe"; };  # Classic Shell
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Cryptomator"; Depth=""; Parent=""; Basename="Cryptomator.exe"; }; # Cryptomator
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Dolby"; Depth=""; Parent=""; Basename="DolbyDAX2API.exe"; }; # Dolby Audio
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="FileZilla FTP Client"; Depth="1"; Parent=""; Basename="*.exe"; }; # Filezilla
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Git"; Depth="5"; Parent=""; Basename="*.exe"; }; # Git
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Greenshot"; Depth=""; Parent=""; Basename="Greenshot.exe"; }; # Greenshot
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Mailbird"; Depth=""; Parent=""; Basename="CefSharp.BrowserSubprocess.exe"; }; # Mailbird
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Mailbird"; Depth=""; Parent=""; Basename="Mailbird*.exe"; }; # Mailbird
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Mailbird"; Depth=""; Parent=""; Basename="sqlite3.exe"; }; # Mailbird
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Malwarebytes"; Depth=""; Parent=""; Basename="mbam.exe"; }; # Malwarebytes
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Malwarebytes"; Depth=""; Parent=""; Basename="mbamtray.exe"; }; # Malwarebytes
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Malwarebytes"; Depth=""; Parent=""; Basename="mbamservice.exe"; }; # Malwarebytes
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Microsoft Office\Office[0-9][0-9]"; Depth="1"; Parent=""; Basename="*.exe"; }; # Office 64-bit (older)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Microsoft Office\root\Office[0-9][0-9]"; Depth="1"; Parent=""; Basename="*.exe"; }; # Office 64-bit (newer)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Microsoft VS Code"; Depth=""; Parent=""; Basename="Code.exe"; }; # VS Code
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Microsoft VS Code"; Depth=""; Parent=""; Basename="rg.exe"; }; # VS Code
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Mozilla Firefox"; Depth="1"; Parent=""; Basename="*.exe"; }; # Firefox
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="NVIDIA Corporation"; Depth=""; Parent=""; Basename="NV*.exe"; }; # NVIDIA
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="PowerShell"; Depth="2"; Parent=""; Basename="pwsh.exe"; }; # PowerShell
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Synaptics"; Depth=""; Parent=""; Basename="SynTPEnh*.exe"; }; # Synaptics
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="TortoiseGit"; Depth="3"; Parent=""; Basename="git*.exe"; }; # TortoiseGit
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="WindowsApps"; Depth=""; Parent=""; Basename="XboxApp.exe"; Entertainment=$True; }; # Microsoft XBox Application
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="WindowsApps"; Depth=""; Parent=""; Basename="IGCCTray.exe"; }; # Intel Graphics
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="WindowsApps"; Depth=""; Parent=""; Basename="IGCC.exe"; }; # Intel Graphics
		# -- PROCESSES -- ProgFiles X86
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Dropbox"; Depth="2"; Parent=""; Basename="Dropbox*.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Dropbox"; Depth="5"; Parent=""; Basename="dbxsvc.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="efs"; Depth="1"; Parent=""; Basename="search.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Google\Chrome"; Depth=""; Parent=""; Basename="chrome.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Gpg4win\bin"; Depth="1"; Parent=""; Basename="*.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Intel"; Depth=""; Parent=""; Basename="DSAService.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Intel"; Depth=""; Parent=""; Basename="DSATray.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Intel"; Depth=""; Parent=""; Basename="lrio.exe"; }; # Telemetry
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Intel"; Depth=""; Parent=""; Basename="iasopt.exe"; }; # Telemetry
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Intel"; Depth=""; Parent=""; Basename="tbtsvc.exe"; }; # Thunderbolt
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Intel"; Depth=""; Parent=""; Basename="Thunderbolt.exe"; }; # Thunderbolt
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="LastPass"; Depth=""; Parent=""; Basename="ie_extract.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="LastPass"; Depth=""; Parent=""; Basename="lastpass.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="LastPass"; Depth=""; Parent=""; Basename="LastPassBroker.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="LastPass"; Depth=""; Parent=""; Basename="nplastpass.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="LastPass"; Depth=""; Parent=""; Basename="WinBioStandalone.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="LastPass"; Depth=""; Parent=""; Basename="wlandecrypt.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Malwarebytes Anti-Exploit"; Depth="1"; Parent=""; Basename="mb*.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Malwarebytes' Anti-Malware"; Depth="1"; Parent=""; Basename="mb*.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Malwarebytes' Anti-Malware\Chameleon"; Depth="1"; Parent=""; Basename="*.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft Office\Office[0-9][0-9]"; Depth="1"; Parent=""; Basename="*.exe"; }; # Office 32-bit (older)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft Office\root\Office[0-9][0-9]"; Depth="1"; Parent=""; Basename="*.exe"; }; # Office 32-bit (newer)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Mobatek"; Depth=""; Parent=""; Basename="MobaXterm.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Mozilla Maintenance Service"; Depth="1"; Parent=""; Basename="maintenanceservice.exe"; }; # Mozilla Firefox
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Notepad++"; Depth=""; Parent=""; Basename="notepad++.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="NVIDIA Corporation"; Depth=""; Parent=""; Basename="NVIDIA Web Helper.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="PRTG Network Monitor"; Depth="3"; Parent=""; Basename="PRTG*.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="PRTG Network Monitor"; Depth="3"; Parent=""; Basename="paessler*.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="PRTG Network Monitor"; Depth="3"; Parent=""; Basename="python*.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="PRTG Network Monitor\Sensor System"; Depth="2"; Parent=""; Basename="*"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Razer"; Depth=""; Parent=""; Basename="CefSharp.BrowserSubprocess.exe"; Entertainment=$True; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Razer"; Depth=""; Parent=""; Basename="GameManagerService*.exe"; Entertainment=$True; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Razer"; Depth=""; Parent=""; Basename="Razer*.exe"; Entertainment=$True; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Razer Chroma SDK\bin"; Depth="1"; Parent=""; Basename="Rz*.exe"; Entertainment=$True; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Reflector 3"; Depth=""; Parent=""; Basename="Reflector3.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Splashtop\Splashtop Remote"; Depth="5"; Parent=""; Basename="*.exe"; }; # Splashtop
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Splashtop\Splashtop Software Updater"; Depth="5"; Parent=""; Basename="*.exe"; }; # Splashtop
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="TeamViewer"; Depth="1"; Parent=""; Basename="TeamViewer*.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Unigine"; Depth=""; Parent=""; Basename="Heaven.exe"; }; # Heaven's Benchmark
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="WinDirStat"; Depth="1"; Parent=""; Basename="windirstat.exe"; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="World of Warcraft"; Depth="2"; Parent=""; Basename="*.exe"; Entertainment=$True; };
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Xvid"; Depth="1"; Parent=""; Basename="*.exe"; }; # XVid
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Yubico\YubiKey Personalization Tool"; Depth="1"; Parent=""; Basename="yubikey-personalization-gui.exe"; }; # Yubico
		# -- PROCESSES -- ProgData
		# $ExcludedProcesses += ((${ProgData})+("\..."));
		# -- PROCESSES -- Sys32
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="ApplicationFrameHost.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="AUDIODG.EXE"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="BackgroundTransferHost.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="conhost.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="csrss.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="CxAudMsg64.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="dashost.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="DbxSvc.exe"; }; # Dropbox
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="DllHost.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="dwm.exe"; }; # Desktop Window Manager
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="dxdiag.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="fontdrvhost.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="lsass.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="mmc.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="rundll32.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="RuntimeBroker.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="SearchIndexer.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="sihost.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="smartscreen.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="smss.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="Taskmgr.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="wininit.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="winlogon.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="WLANExt.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="WUDFHost.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir="DriverStore\FileRepository"; Depth=""; Parent=""; Basename="GfxDownloadWrapper.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir="DriverStore\FileRepository"; Depth=""; Parent=""; Basename="igfxCUIService.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir="DriverStore\FileRepository"; Depth=""; Parent=""; Basename="igfxEM.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir="DriverStore\FileRepository"; Depth=""; Parent=""; Basename="igfxEMN.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir="DriverStore\FileRepository"; Depth=""; Parent=""; Basename="igfxext.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir="DriverStore\FileRepository"; Depth=""; Parent=""; Basename="igfxextN.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir="DriverStore\FileRepository"; Depth=""; Parent=""; Basename="IntelCpHDCPSvc.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir="DriverStore\FileRepository"; Depth=""; Parent=""; Basename="IntelCpHeciSvc.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir="wbem"; Depth="1"; Parent=""; Basename="unsecapp.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir="wbem"; Depth="1"; Parent=""; Basename="WmiPrvSE.exe"; };
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir="WindowsPowerShell\v1.0"; Depth="1"; Parent=""; Basename="powershell.exe"; };
		# -- PROCESSES -- SysDrive
		$ExcludedProcesses += @{ Dirname=${SysDrive}; AddDir="ProgramData\Microsoft\Windows Defender\Platform"; Depth=""; Parent=""; Basename="MsMpEng.exe"; };
		$ExcludedProcesses += @{ Dirname=${SysDrive}; AddDir="ProgramData\Microsoft\Windows Defender\Platform"; Depth=""; Parent=""; Basename="NisSrv.exe"; };
		# -- PROCESSES -- SysRoot
		$ExcludedProcesses += @{ Dirname=${SysRoot}; AddDir=""; Depth="1"; Parent=""; Basename="explorer.exe"; };
		$ExcludedProcesses += @{ Dirname=${SysRoot}; AddDir="ImmersiveControlPanel"; Depth="1"; Parent=""; Basename="SystemSettings.exe"; };
		$ExcludedProcesses += @{ Dirname=${SysRoot}; AddDir="SystemApps"; Depth="3"; Parent=""; Basename="ShellExperienceHost.exe"; };
		$ExcludedProcesses += @{ Dirname=${SysRoot}; AddDir="SystemApps"; Depth="3"; Parent=""; Basename="StartMenuExperienceHost.exe"; };
		$ExcludedProcesses += @{ Dirname=${SysRoot}; AddDir="WinSxS"; Depth="2"; Parent=""; Basename="TiWorker.exe"; };
		# -- PROCESSES -- UserProfile
		$ExcludedProcesses += @{ Dirname=${UserProfile}; AddDir="Documents\MobaXterm"; Depth=""; Parent=""; Basename="Motty.exe"; };
		# -- PROCESSES -- NVidia Driver-related
		$NVDriverPath = (Get-ChildItem -Path ("C:\Windows\System32\DriverStore\FileRepository") -Filter ("NVTelemetryContainer.exe") -File -Recurse -Force -ErrorAction "SilentlyContinue" | ForEach-Object { $_.Directory.Parent.FullName; });
		If ($NVDriverPath -Ne $Null) {
			$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir="DRIVERS\NVIDIA Corporation\Drs"; Depth="1"; Parent=""; Basename="dbInstaller.exe"; };
			$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="MCU.exe"; };
			$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="nvdebugdump.exe"; };
			$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="nvidia-smi.exe"; };
			$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="vulkan*.exe"; };
			$ExcludedProcesses += @{ Dirname=${NVDriverPath}; AddDir=""; Depth="1"; Parent=""; Basename="*.exe"; };
		}
		# ------------------------------------------------------------
		#
		#		APPLY THE EXCLUSIONS
		#
		$ExcludedFilepaths | Select-Object -Unique | ForEach-Object {
			If ($_ -ne $Null) {
				If (Test-Path $_) {
					If (($_.Entertainment -Eq $True) -And ($IncludeEntertainment -Eq $False)) {
						If ($PSBoundParameters.ContainsKey('Verbose')) { Write-Host (("Skipping Exclusion (to include, call with `"-Entertainment`"):  [ ")+($_)+(" ]")); }
					} Else {
						$FoundFilepaths += $_;
					}
				}
				If ($WindowsDefender -eq $True) {
					If (($_.Entertainment -Eq $True) -And ($IncludeEntertainment -Eq $False)) {
						If ($PSBoundParameters.ContainsKey('Verbose')) { Write-Host (("Skipping Exclusion (to include, call with `"-Entertainment`"):  [ ")+($_)+(" ]")); }
					} Else {
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
		}
		$ExcludedExtensions | Select-Object -Unique | ForEach-Object {
			If ($_ -ne $Null) {
				$FoundExtensions += $_;
				If ($WindowsDefender -eq $True) {
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
		$ExcludedProcesses | ForEach-Object {
			If ($_ -ne $Null) {
				If (($_.Entertainment -Eq $True) -And ($IncludeEntertainment -Eq $False)) {
					If ($PSBoundParameters.ContainsKey('Verbose')) { Write-Host (("Skipping Exclusion (to include, call with `"-Entertainment`"):  [ ")+($_)+(" ]")); }
				} Else {
					$Each_Dirname = $_.Dirname;
					If ($_.AddDir -ne "") {
						$Each_Dirname = (($_.Dirname)+("\")+($_.AddDir));
					}
					$Each_Basename = $_.Basename;
					$Each_Parent = If (($_.Parent -ne $Null) -And ($_.Parent -ne ""))  { $_.Parent } Else { "" };
					$Each_Depth = If (($_.Depth -ne $Null) -And ($_.Depth -ne ""))  { [Int]$_.Depth } Else { "" };
					If ((Test-Path $Each_Dirname) -And ($Each_Basename -ne "")) {
						If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host "Searching `"${Each_Dirname}`" for `"${Each_Basename}`"..."; }
						If ($Each_Parent -eq "") {
							If ($Each_Depth -eq "") {
								# Matching on [ top level directory ] & [ basename ]
								$FoundProcesses += (Get-ChildItem -Path ("$Each_Dirname") -Filter ("$Each_Basename") -File -Recurse -Force -ErrorAction "SilentlyContinue" | ForEach-Object { $_.FullName; });
							} Else {
								# Matching on [ top level directory ], [ basename ] & [ depth ]
								$FoundProcesses += (Get-ChildItem -Path ("$Each_Dirname") -Filter ("$Each_Basename") -Depth ($Each_Depth) -File -Recurse -Force -ErrorAction "SilentlyContinue" | ForEach-Object { $_.FullName; });
							}
						} Else {
							If ($Each_Depth -eq "") {
								# Matching on [ top level directory ], [ basename ] & [ parent directory name ]
								$FoundProcesses += (Get-ChildItem -Path ("$Each_Dirname") -Filter ("$Each_Basename") -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Directory.Name -Eq "$Each_Parent" } | ForEach-Object { $_.FullName; });
							} Else {
								# Matching on [ top level directory ], [ basename ], [ parent directory name ] & [ depth ]
								$FoundProcesses += (Get-ChildItem -Path ("$Each_Dirname") -Filter ("$Each_Basename") -Depth ($Each_Depth) -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Directory.Name -Eq "$Each_Parent" } | ForEach-Object { $_.FullName; });
							}
						}
					}
				}
			}
		}
		# ------------------------------------------------------------
		#
		#		REVIEW FINAL EXCLUSIONS-LIST (before applying them)
		#
		#
		#
		If (!($PSBoundParameters.ContainsKey('Quiet'))) {
			Write-Host "`nExclusions - Filepaths (which exist locally):"; If ($FoundFilepaths -eq $Null) { Write-Host "None"; } Else { $FoundFilepaths; }
			Write-Host "`nExclusions - Processes (which exist locally):"; If ($FoundProcesses -eq $Null) { Write-Host "None"; } Else { $FoundProcesses; }
			Write-Host "`nExclusions - Extensions:"; If ($FoundExtensions -eq $Null) { Write-Host "None"; } Else { $FoundExtensions; }
			Write-Host "`n";
		}
		#
		#
		#
		# ------------------------------------------------------------
		#
		# ESET Exclusions 
		#		Construct an Import-file which contains all exclusions
		#
		If ($ESET -eq $True) {
			$ExitCode = ESET_ExportModifier -ESET_ExportToCopyFrom ($ESET_ExportToCopyFrom) -ESET_ExcludeFilepaths ($FoundFilepaths) -ESET_ExcludeExtensions ($FoundExtensions) -ESET_ExcludeProcesses ($FoundProcesses);
		}
		# ------------------------------------------------------------
		#
		# Malwarebytes Anti-Ransomware
		#		Use [ malwarebytes_assistant.exe --exclusions add "FILEPATH" ] to add exclusions
		#
		If ($MalwarebytesAntiRansomware -eq $True) {

			$MBAR_SearchDirname = ((${ProgFilesX64})+("\Malwarebytes"));
			$MBAR_FindBasename = "malwarebytes_assistant.exe";

			$MalwarebytesAssistant = (Get-ChildItem -Path ("${MBAR_SearchDirname}") -Filter ("${MBAR_FindBasename}") -File -Recurse -Force -ErrorAction "SilentlyContinue" | ForEach-Object { $_.FullName; });
			
			If ($MalwarebytesAssistant -eq $Null) {
				
				# Cannot find Exclusions tool/utility
				Write-Host "";
				Write-Host (("  Error - Unable to find Exclusions utility `"")+($MBAR_FindBasename)+("`" in directory `"")+($MBAR_SearchDirname)+("`"  ")) -BackgroundColor ("Black") -ForegroundColor ("Red");
				Write-Host "";

			} Else {
				
				Write-Host "";
				Write-Host ("MalwarebytesAssistant: "+($MalwarebytesAssistant));
				Write-Host "";

				# Found Exclusions tool/utility - add any/all exclusions
				# $FoundProcesses | Select-Object -Unique | ForEach-Object {
				# 	$MalwarebytesAssistant --exclusions add "$_"
				# }

			}
		}
		# ------------------------------------------------------------
		#
		# Windows Defender Exclusions
		#		Apply directly via PowerShell built-in command(s)
		#
		If ($WindowsDefender -eq $True) {
			$FoundProcesses | Select-Object -Unique | ForEach-Object {
				If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host "Adding Defender Process-Exclusion: `"$_`"..."; }
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
			$LiveWD = (Get-MpPreference);
			Write-Host "`nWindows Defender (Live Exclusions) - Filepaths:"; If ($LiveWD.ExclusionPath -eq $Null) { Write-Host "None"; } Else { $LiveWD.ExclusionPath; }
			Write-Host "`nWindows Defender (Live Exclusions) - Processes:"; If ($LiveWD.ExclusionProcess -eq $Null) { Write-Host "None"; } Else { $LiveWD.ExclusionProcess; }
			Write-Host "`nWindows Defender (Live Exclusions) - File-Extensions:"; If ($LiveWD.ExclusionExtension -eq $Null) { Write-Host "None"; } Else { $LiveWD.ExclusionExtension; }
		}
		#
		# ------------------------------------------------------------
		#
		$WaitCloseSeconds = 60;
		Write-Host "`nClosing after ${WaitCloseSeconds}s...";
		Write-Host "`n";
		Start-Sleep -Seconds ${WaitCloseSeconds};
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

		[String]$ESET_ExportToCopyFrom,

		[String[]]$ESET_ExcludeFilepaths = @(),

		[String[]]$ESET_ExcludeProcesses = @(),

		[String[]]$ESET_ExcludeExtensions = @()

	)

	If ((Test-Path -Path ("$ESET_ExportToCopyFrom")) -eq $False) {
		Write-Host "";
		Write-Host "  Error in function `"ESET_ExportModifier`"  " -BackgroundColor ("Black") -ForegroundColor ("Yellow");
		Write-Host "";
		Write-Host "    Please go to ESET > 'Setup' > 'Import/Export Settings' > 'Export settings' to path: `n`n    $ESET_ExportToCopyFrom    `n`n" -BackgroundColor ("Black") -ForegroundColor ("Yellow");
		Write-Host "";
		Return 1;
	} Else {
		$Dirname_NewImport = ((${Env:USERPROFILE})+("\Desktop\eset-import"));
		$Basename_NewImport = (("eset-import_")+(Get-Date -UFormat "%Y%m%d-%H%M%S")+(".xml"));
		$Fullpath_NewImport = (($Dirname_NewImport)+("\")+($Basename_NewImport));
		If ((Test-Path -Path ($Dirname_NewImport)) -eq $false) {
			New-Item -ItemType "Directory" -Path ($Dirname_NewImport) | Out-Null;
		}
		Set-Content -Path ($Fullpath_NewImport) -Value (Get-Content -Path ("$ESET_ExportToCopyFrom"));
		$XmlDoc = New-Object -TypeName "System.Xml.XmlDocument";
		$XmlDoc.Load($Fullpath_NewImport);
		#
		# ------------------------------------------------------------
		#
		# [ ESET ] All Process Exclusions
		#
		$NewExclusion = @{};
		$NewExclusion.Type = "Process";
		$NewExclusion.SoftwareLocation = "[ ESET Advanced Setup (Taskbar notification area + Right-Click) ] -> [ DETECTION ENGINE (Left) ] -> [ Real-time file system protection (Left) ] -> [ BASIC (Right) ] -> [ PROCESSES EXCLUSIONS (Right) ] -> [ Edit ]";
		$NewExclusion.PreserveExportedExclusions = $True;
		$NewExclusion.XPath_Container = "/ESET/PRODUCT[@NAME='endpoint']/ITEM[@NAME='plugins']/ITEM[@NAME='01000101']/ITEM[@NAME='settings']/ITEM[@NAME='ExcludedProcesses'][@DELETE='1']";
		$NewExclusion.XPath_Children = "$($NewExclusion.XPath_Container)/NODE";

		$NewExclusion.NextName = 0;
		$XmlDoc | Select-Xml -XPath "$($NewExclusion.XPath_Children)" | ForEach-Object {
			$NewExclusion.NextName = [Int]((($NewExclusion.NextName,[Int]([Convert]::ToString("0x$($_.Node.NAME)", 10))) | Measure -Max).Maximum);
		};
		$NewExclusion.NextName++;

		$ESET_ExcludeProcesses | Select-Object -Unique | ForEach-Object {
			$NewEle = $XmlDoc.CreateElement("NODE");
			$NewEle.SetAttribute("NAME", ([Convert]::ToString($($NewExclusion.NextName), 16)));
			$NewEle.SetAttribute("TYPE", "string");
			$NewEle.SetAttribute("VALUE", $_);
			($XmlDoc | Select-Xml -XPath "$($NewExclusion.XPath_Container)").Node.AppendChild($NewEle);
			$NewExclusion.NextName++;
		}

		# ------------------------------------------------------------
		#
		# [ ESET ] All Filepath Exclusions
		#
		$NewExclusion = @{};
		$NewExclusion.Type = "Filepath";
		$NewExclusion.SoftwareLocation = "[ ESET Advanced Setup (Taskbar notification area + Right-Click) ] -> [ DETECTION ENGINE (Left) ] -> [ BASIC (Right) ] -> [ EXCLUSIONS (Right) ] -> [ Edit ]";
		$NewExclusion.PreserveExportedExclusions = $True;
		$NewExclusion.XPath_Container = "/ESET/PRODUCT[@NAME='endpoint']/ITEM[@NAME='plugins']/ITEM[@NAME='01000600']/ITEM[@NAME='settings']/ITEM[@NAME='ScannerExcludes'][@DELETE='1']";
		$NewExclusion.XPath_Children = "$($NewExclusion.XPath_Container)/ITEM";

		$NewExclusion.NextName = 0;
		$XmlDoc | Select-Xml -XPath "$($NewExclusion.XPath_Children)" | ForEach-Object {
			$NewExclusion.NextName = [Int]((($NewExclusion.NextName,[Int]([Convert]::ToString("0x$($_.Node.NAME)", 10))) | Measure -Max).Maximum);
		};
		$NewExclusion.NextName++;
		$ESET_ExcludeFilepaths | Select-Object -Unique | ForEach-Object {
			$EachFilepath = $_;
			@("*","*.*") | Select-Object -Unique | ForEach-Object {
				$NewEle = $XmlDoc.CreateElement("ITEM");
				$NewEle.SetAttribute("NAME", ([Convert]::ToString($($NewExclusion.NextName), 16)));
				$NewEle.InnerXml = '';
				$NewEle.InnerXml += (('<NODE NAME="ExcludeType" TYPE="number" VALUE="0" />'));
				$NewEle.InnerXml += (('<NODE NAME="Infiltration" TYPE="string" VALUE="" />'));		
				$NewEle.InnerXml += (('<NODE NAME="FullPath" TYPE="string" VALUE="')+($EachFilepath)+('\')+($_)+('" />'));
				$NewEle.InnerXml += (('<NODE NAME="Flags" TYPE="number" VALUE="0" />'));
				$NewEle.InnerXml += (('<NODE NAME="Hash" TYPE="string" VALUE="" />'));
				$NewEle.InnerXml += (('<NODE NAME="Description" TYPE="string" VALUE="" />'));
				($XmlDoc | Select-Xml -XPath "$($NewExclusion.XPath_Container)").Node.AppendChild($NewEle);
				$NewExclusion.NextName++;
			}
		}

		# ------------------------------------------------------------
		#
		# [ ESET ] All Extension Exclusions
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

		$XmlDoc.Save($Fullpath_NewImport); # Save the updated exclusions list to the Import XML file

		Explorer.exe "$Dirname_NewImport"; # Show the directory containing the import-file

		# 
		# ------------------------------------------------------------
		Return 0;
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
#			https://docs.microsoft.com/en-us/powershell/module/defender/add-mppreference
#
#			"Select-Xml"  |  "Finds text in an XML string or document"
#			https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/select-xml
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
