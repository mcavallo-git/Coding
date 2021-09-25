# ------------------------------------------------------------
#
#	PowerShell Module
#		|
#		|--> Name:
#		|      ExclusionsListUpdate
#		|
#		|--> Description:
#		|      Updates/Adds exclusions (to anti-virus/anti-malware software) for files/runtimes which exist on local device
#		|
#		|--> Example Call(s):
#		       Import-Module "${Home}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\ExclusionsListUpdate\ExclusionsListUpdate.psm1"; ExclusionsListUpdate -Defender -DryRun;
#
# ------------------------------------------------------------
function ExclusionsListUpdate {
	Param(

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

		[Switch]$DryRun,
		[Switch]$Entertainment,
		[Switch]$Quiet,
		[Switch]$RemoveMissing,
		[Switch]$Verbose

	)
	# ------------------------------------------------------------
	If ($False) { # RUN THIS SCRIPT:

		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy 'RemoteSigned' -Scope 'CurrentUser' -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/ExclusionsListUpdate/ExclusionsListUpdate.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'ExclusionsListUpdate' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\ExclusionsListUpdate\ExclusionsListUpdate.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
		ExclusionsListUpdate -Defender -DryRun;

	}
	# ------------------------------------------------------------

	$ESET = If ($PSBoundParameters.ContainsKey('ESET')) { $True } Else { $False };
	$ESET_ExportToCopyFrom = If ($ESET_ExportToCopyFrom -Ne "") { $ESET_ExportToCopyFrom } Else { ((${Env:USERPROFILE})+("\Desktop\eset-export.xml")) };
	$MalwarebytesAntiMalware = If ($PSBoundParameters.ContainsKey('MalwarebytesAntiMalware')) { $True } Else { $False };
	$MalwarebytesAntiRansomware = If ($PSBoundParameters.ContainsKey('MalwarebytesAntiRansomware')) { $True } Else { $False };
	$MalwarebytesAntiExploit = If ($PSBoundParameters.ContainsKey('MalwarebytesAntiExploit')) { $True } Else { $False };
	$WindowsDefender = If (($PSBoundParameters.ContainsKey('WindowsDefender')) -Or ($PSBoundParameters.ContainsKey('Defender'))) { $True } Else { $False };

	$IncludeEntertainment = If ($PSBoundParameters.ContainsKey('Entertainment')) { $True } Else { $False };

	$RunMode_DryRun = If ($PSBoundParameters.ContainsKey('DryRun') -Eq $True) { $True } Else { $False };

	Write-Output "";
	Write-Output "  Exclusions List Update  ";
	If (${RunMode_DryRun} -Eq $True) { <# NOT running in Dry Run mode #>
		Write-Output "  *** DRY RUN MODE ACTIVE ***";
	}
	Write-Output "";
	Write-Output "  Antivirus Software:  ";
	If ($ESET -eq $True) { Write-Output "    ESET    "; }
	If ($MalwarebytesAntiMalware -eq $True) { Write-Output "    MalwarebytesAntiMalware    "; }
	If ($MalwarebytesAntiRansomware -eq $True) { Write-Output "    MalwarebytesAntiRansomware    "; }
	If ($MalwarebytesAntiExploit -eq $True) { Write-Output "    MalwarebytesAntiExploit    "; }
	If ($WindowsDefender -eq $True) { Write-Output "    WindowsDefender    "; }
	Write-Output "";

	$FoundFilepaths = @();
	$FoundExtensions = @();
	$FoundProcesses = @();

	<# Import Module 'RunningAsAdministrator' #>
	If (-Not (Get-Command -Name 'RunningAsAdministrator' -ErrorAction 'SilentlyContinue')) { 
		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy 'RemoteSigned' -Scope 'CurrentUser' -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/RunningAsAdministrator/RunningAsAdministrator.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'RunningAsAdministrator' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\RunningAsAdministrator\RunningAsAdministrator.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
	}

	# Require Escalated Privileges
	If ((RunningAsAdministrator) -ne ($True)) {

		$PSCommandArgs = @();
		$i=0;
		While ($i -lt $args.Length) {
			$PSCommandArgs += $args[$i];
			$i++;
		}

		$CommandString="`$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; `$ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/PrivilegeEscalation/PrivilegeEscalation.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'PrivilegeEscalation' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\PrivilegeEscalation\PrivilegeEscalation.psm1', ((Get-Variable -Name 'HOME').Value))); }; ";
		$CommandString+=" ExclusionsListUpdate";
		If ($ESET -eq $True) {                                 $CommandString+=" -ESET"; }
		If ($MalwarebytesAntiMalware -eq $True) {              $CommandString+=" -MalwarebytesAntiMalware"; }
		If ($MalwarebytesAntiRansomware -eq $True) {           $CommandString+=" -MalwarebytesAntiRansomware"; }
		If ($MalwarebytesAntiExploit -eq $True) {              $CommandString+=" -MalwarebytesAntiExploit"; }
		If ($WindowsDefender -eq $True) {                      $CommandString+=" -WindowsDefender"; }
		If ($PSBoundParameters.ContainsKey('DryRun')) {        $CommandString+=" -DryRun"; }
		If ($PSBoundParameters.ContainsKey('Entertainment')) { $CommandString+=" -Entertainment"; }
		If ($PSBoundParameters.ContainsKey('Quiet')) {         $CommandString+=" -Quiet"; }
		If ($PSBoundParameters.ContainsKey('RemoveMissing')) { $CommandString+=" -RemoveMissing"; }
		If ($PSBoundParameters.ContainsKey('Verbose')) {       $CommandString+=" -Verbose"; }

		<# Import Module 'PrivilegeEscalation' #>
		If (-Not (Get-Command -Name 'PrivilegeEscalation' -ErrorAction 'SilentlyContinue')) { 
			$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy 'RemoteSigned' -Scope 'CurrentUser' -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/PrivilegeEscalation/PrivilegeEscalation.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'PrivilegeEscalation' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\PrivilegeEscalation\PrivilegeEscalation.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
		}

		<# Re-run this command w/ Administrator privileges #>
		PrivilegeEscalation -Command ("${CommandString}");

	} Else {

		# ------------------------------------------------------------
		#
		# User/System Directories
		#

		$LocalAppData = (${Env:LocalAppData}); # LocalAppData

		$WindowsApps = ((${Env:LocalAppData})+("\Microsoft\WindowsApps")); # WindowsApps

		$ProgData = ((${Env:SystemDrive})+("\ProgramData")); # ProgData

		$ProgFilesX64 = ((${Env:SystemDrive})+("\Program Files")); # ProgFilesX64

		$ProgFilesX86 = ((${Env:SystemDrive})+("\Program Files (x86)")); # ProgFilesX86

		$SysDrive = (${Env:SystemDrive}); # C:\

		$SysRoot = (${Env:SystemRoot}); # C:\Windows

		$Sys32 = ((${Env:SystemRoot})+("\System32")); # C:\Windows\System32

		$UserProfile = (${Env:USERPROFILE}); # UserProfile


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
		$ExcludedFilepaths += ((${ProgFilesX64})+("\McAfee"));
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
		$ExcludedFilepaths += ((${ProgFilesX86})+("\McAfee"));
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
		$ExcludedExtensions += ("avhd");
		$ExcludedExtensions += ("avhdx");
		$ExcludedExtensions += ("iso");
		$ExcludedExtensions += ("rct");
		$ExcludedExtensions += ("vhd");
		$ExcludedExtensions += ("vhdx");
		$ExcludedExtensions += ("vmcx");
		$ExcludedExtensions += ("vmrs");
		$ExcludedExtensions += ("vsv");
		# ------------------------------------------------------------
		# -- PROCESSES -- AppData\Local
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
		# -- PROCESSES -- Program Files\
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="7-Zip"; Depth="2"; Parent=""; Basename="7z*.exe"; }; # 7-Zip
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="AMD\CNext\CNext"; Depth=""; Parent=""; Basename="amdow.exe"; }; # AMD-Radeon (GPU)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="AMD\CNext\CNext"; Depth=""; Parent=""; Basename="AMDRSSrcExt.exe"; }; # AMD-Radeon (GPU)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="AMD\CNext\CNext"; Depth=""; Parent=""; Basename="RadeonSettings.exe"; }; # AMD-Radeon (GPU)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="AutoHotkey"; Depth=""; Parent=""; Basename="Ahk2Exe.exe"; }; # AutoHotkey
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="AutoHotkey"; Depth=""; Parent=""; Basename="AutoHotkey*.exe"; }; # AutoHotkey
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Classic Shell"; Depth="1"; Parent=""; Basename="*.exe"; };  # Classic Shell
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Common Files\McAfee\SystemCore"; Depth="1"; Parent=""; Basename="*.exe"; };  # McAfee Management Service
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Cryptomator"; Depth=""; Parent=""; Basename="Cryptomator.exe"; }; # Cryptomator
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Dolby"; Depth=""; Parent=""; Basename="DolbyDAX2API.exe"; }; # Dolby Audio
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Epic Games\Chivalry2"; Depth=""; Parent=""; Basename="*.exe"; }; # Chivalry 2
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="FileZilla FTP Client"; Depth="1"; Parent=""; Basename="*.exe"; }; # Filezilla
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Git"; Depth="5"; Parent=""; Basename="*.exe"; }; # Git
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Greenshot"; Depth=""; Parent=""; Basename="Greenshot.exe"; }; # Greenshot
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="HWiNFO64"; Depth=""; Parent=""; Basename="HWiNFO64.EXE"; }; # HWiNFO64
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Logitech/LogiOptions"; Depth=""; Parent=""; Basename="*.exe"; }; # Logitech Options
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Logitech/SetPointP"; Depth=""; Parent=""; Basename="*.exe"; }; # Logitech SetPoint
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Mailbird"; Depth=""; Parent=""; Basename="CefSharp.BrowserSubprocess.exe"; }; # Mailbird
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Mailbird"; Depth=""; Parent=""; Basename="Mailbird*.exe"; }; # Mailbird
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Mailbird"; Depth=""; Parent=""; Basename="sqlite3.exe"; }; # Mailbird
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Malwarebytes"; Depth=""; Parent=""; Basename="mbam.exe"; }; # Malwarebytes
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Malwarebytes"; Depth=""; Parent=""; Basename="mbamtray.exe"; }; # Malwarebytes
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Malwarebytes"; Depth=""; Parent=""; Basename="mbamservice.exe"; }; # Malwarebytes
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="McAfee"; Depth=""; Parent=""; Basename="*.exe"; }; # McAfee Agent, DLP, Endpoint Security, MCP
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Microsoft Office\Office[0-9][0-9]"; Depth="1"; Parent=""; Basename="*.exe"; }; # Office 64-bit (older)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Microsoft Office\root\Office[0-9][0-9]"; Depth="1"; Parent=""; Basename="*.exe"; }; # Office 64-bit (newer)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Microsoft VS Code"; Depth=""; Parent=""; Basename="Code.exe"; }; # VS Code
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Microsoft VS Code"; Depth=""; Parent=""; Basename="rg.exe"; }; # VS Code
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Mozilla Firefox"; Depth="1"; Parent=""; Basename="*.exe"; }; # Firefox
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="NVIDIA Corporation"; Depth=""; Parent=""; Basename="NV*.exe"; }; # NVIDIA
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Palo Alto Networks\GlobalProtect"; Depth="3"; Parent=""; Basename="*.exe"; }; # Palo Alto Global Protect (VPN)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Palo Alto Networks\Traps"; Depth="1"; Parent=""; Basename="*.exe"; }; # Palo Alto Traps (Endpoint Security Manager)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="PowerShell"; Depth="2"; Parent=""; Basename="pwsh.exe"; }; # PowerShell
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Qualys\QualysAgent"; Depth="3"; Parent=""; Basename="*.exe"; }; # Qualys Cloud Agent (Remote patching via vendor CDNs)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Synaptics"; Depth=""; Parent=""; Basename="SynTPEnh*.exe"; }; # Synaptics
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="TortoiseGit"; Depth=""; Parent=""; Basename="*.exe"; }; # TortoiseGit
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="WindowsApps"; Depth="2"; Parent=""; Basename="DiskMark64.exe"; }; # Crystal Disk Mark
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="WindowsApps"; Depth=""; Parent=""; Basename="IGCC.exe"; }; # Intel Graphics
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="WindowsApps"; Depth=""; Parent=""; Basename="IGCCTray.exe"; }; # Intel Graphics
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="WindowsApps"; Depth=""; Parent=""; Basename="nvcplui.exe"; }; # NVidia Control Panel GUI
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="WindowsApps"; Depth=""; Parent=""; Basename="XboxApp.exe"; Entertainment=$True; }; # Microsoft XBox Application
		$ExcludedProcesses += @{ Dirname=${ProgFilesX64}; AddDir="Windows Defender Advanced Threat Protection"; Depth=""; Parent=""; Basename="*.exe"; }; # Microsoft Security Center / Defender / Defender ATP (Advanced Threat Protection)
		# -- PROCESSES -- Program Files (x86)\
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="APC\PowerChute Personal Edition"; Depth="3"; Parent=""; Basename="*.exe"; }; # APC PowerChute Personal Edition (Battery Backup Manager)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="ASUS\ROG Live Service"; Depth=""; Parent=""; Basename="ROGLiveService.exe"; }; # ASUS ROG Live Service
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Cisco\Cisco AnyConnect Secure Mobility Client"; Depth="3"; Parent=""; Basename="*.exe"; }; # Cisco AnyConnect (VPN)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Cisco\Cisco AnyConnect VPN Client"; Depth="3"; Parent=""; Basename="*.exe"; }; # Cisco AnyConnect (VPN)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Common Files\Oracle\Java"; Depth="2"; Parent=""; Basename="java.exe"; }; # Java
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Dell SecureWorks"; Depth="4"; Parent=""; Basename="*.exe"; }; # Dell SecureWorks Red Cloak (monitors netflow, processes, memory, registry, etc.)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Dropbox"; Depth="2"; Parent=""; Basename="Dropbox*.exe"; }; # Dropbox + Required-Components
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Dropbox"; Depth="5"; Parent=""; Basename="dbxsvc.exe"; }; # Dropbox
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="EasyAntiCheat"; Depth="1"; Parent=""; Basename="EasyAntiCheat.exe"; }; # Chivalry 2 - 'EasyAntiCheat' service
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Epic Games"; Depth="5"; Parent="Overlay"; Basename="EOSOverlayRenderer-Win64-Shipping.exe"; }; # Chivalry 2 - 'EOSOverlayRenderer'
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Epic Games"; Depth="5"; Parent="Win64"; Basename="EpicGamesLauncher.exe"; }; # Chivalry 2 - Epic Games Launcher
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="efs"; Depth="1"; Parent=""; Basename="search.exe"; }; # Effective File Search
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Google\Chrome"; Depth=""; Parent=""; Basename="chrome.exe"; }; # Google Chrome (Browser)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Gpg4win\bin"; Depth="1"; Parent=""; Basename="*.exe"; }; # GpG4Windows
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Intel"; Depth=""; Parent=""; Basename="DSAService.exe"; }; # Intel Tray-Icon
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Intel"; Depth=""; Parent=""; Basename="DSATray.exe"; }; # Intel Tray-Icon
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Intel"; Depth=""; Parent=""; Basename="lrio.exe"; }; # Telemetry
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Intel"; Depth=""; Parent=""; Basename="iasopt.exe"; }; # Telemetry
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Intel"; Depth=""; Parent=""; Basename="tbtsvc.exe"; }; # Thunderbolt
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Intel"; Depth=""; Parent=""; Basename="Thunderbolt.exe"; }; # Thunderbolt
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="LastPass"; Depth=""; Parent=""; Basename="ie_extract.exe"; }; # Lastpass
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="LastPass"; Depth=""; Parent=""; Basename="lastpass.exe"; }; # Lastpass
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="LastPass"; Depth=""; Parent=""; Basename="LastPassBroker.exe"; }; # Lastpass
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="LastPass"; Depth=""; Parent=""; Basename="nplastpass.exe"; }; # Lastpass
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="LastPass"; Depth=""; Parent=""; Basename="WinBioStandalone.exe"; }; # Lastpass
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="LastPass"; Depth=""; Parent=""; Basename="wlandecrypt.exe"; }; # Lastpass
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Malwarebytes Anti-Exploit"; Depth="1"; Parent=""; Basename="mb*.exe"; }; # Malwarebytes
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Malwarebytes' Anti-Malware"; Depth="1"; Parent=""; Basename="mb*.exe"; }; # Malwarebytes
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Malwarebytes' Anti-Malware\Chameleon"; Depth="1"; Parent=""; Basename="*.exe"; }; # Malwarebytes
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="McAfee"; Depth=""; Parent=""; Basename="*.exe"; }; # McAfee Endpoint Security, Management of Native Encryption, System Information Reporter
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin"; Depth="2"; Parent=""; Basename="MSBuild.exe"; }; # MSBuild - Code-Compiler for ASP.NET Apps
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft Visual Studio\2017\Professional\Common7\IDE"; Depth="1"; Parent=""; Basename="devenv.com"; }; # DevEnv - Visual Studio (main exe, both GUI & CLI)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft Visual Studio\2017\Professional\Common7\IDE"; Depth="1"; Parent=""; Basename="devenv.exe"; }; # DevEnv - Visual Studio (main exe, both GUI & CLI)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin"; Depth="2"; Parent=""; Basename="MSBuild.exe"; }; # MSBuild - Code-Compiler for ASP.NET Apps
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft Visual Studio\2019\Professional\Common7\IDE"; Depth="1"; Parent=""; Basename="devenv.com"; }; # DevEnv - Visual Studio (main exe, both GUI & CLI)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft Visual Studio\2019\Professional\Common7\IDE"; Depth="1"; Parent=""; Basename="devenv.exe"; }; # DevEnv - Visual Studio (main exe, both GUI & CLI)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft Office\Office[0-9][0-9]"; Depth="1"; Parent=""; Basename="*.exe"; }; # Office 32-bit (older)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft Office\root\Office[0-9][0-9]"; Depth="1"; Parent=""; Basename="*.exe"; }; # Office 32-bit (newer)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Microsoft\Edge\Application"; Depth="1"; Parent=""; Basename="msedge.exe"; }; # Microsoft Edge
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Mobatek"; Depth=""; Parent=""; Basename="MobaXterm.exe"; }; # MobaXTerm SSH-Client
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Mozilla Maintenance Service"; Depth="1"; Parent=""; Basename="maintenanceservice.exe"; }; # Mozilla Firefox
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="MSBuild"; Depth=""; Parent=""; Basename="MSBuild.exe"; }; # MSBuild - Code-Compiler for ASP.NET Apps
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="MSI Afterburner"; Depth=""; Parent=""; Basename="MSIAfterburner.exe"; }; # MSI Afterburner (GPU Over/Underclocking Tool)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Notepad++"; Depth=""; Parent=""; Basename="notepad++.exe"; }; # Notepad++
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="NVIDIA Corporation"; Depth=""; Parent=""; Basename="NVIDIA Web Helper.exe"; }; # NVIDIA
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="PRTG Network Monitor"; Depth="3"; Parent=""; Basename="PRTG*.exe"; }; # PRTG
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="PRTG Network Monitor"; Depth="3"; Parent=""; Basename="paessler*.exe"; }; # PRTG
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="PRTG Network Monitor"; Depth="3"; Parent=""; Basename="python*.exe"; }; # PRTG
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="PRTG Network Monitor\Sensor System"; Depth="2"; Parent=""; Basename="*"; }; # PRTG
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Razer"; Depth=""; Parent=""; Basename="CefSharp.BrowserSubprocess.exe"; Entertainment=$True; }; # Razer Core X Chroma
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Razer"; Depth=""; Parent=""; Basename="GameManagerService*.exe"; Entertainment=$True; }; # Razer Core X Chroma
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Razer"; Depth=""; Parent=""; Basename="Razer*.exe"; Entertainment=$True; }; # Razer Core X Chroma
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Razer Chroma SDK\bin"; Depth="1"; Parent=""; Basename="Rz*.exe"; Entertainment=$True; }; # Razer Core X Chroma
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Reflector 3"; Depth=""; Parent=""; Basename="Reflector3.exe"; }; # Reflector (Airplay Server)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Royal TS V5"; Depth=""; Parent=""; Basename="RoyalTS.exe"; }; # Royal TS (Remote Management)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Splashtop\Splashtop Remote"; Depth="5"; Parent=""; Basename="*.exe"; }; # Splashtop
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Splashtop\Splashtop Software Updater"; Depth="5"; Parent=""; Basename="*.exe"; }; # Splashtop
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Tanium"; Depth="6"; Parent=""; Basename="*.exe"; }; # Tanium Endpoint Management (Device Monitor & Management Utility)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="TeamViewer"; Depth="1"; Parent=""; Basename="TeamViewer*.exe"; }; # Teamviewer
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="Unigine"; Depth=""; Parent=""; Basename="Heaven.exe"; }; # Heaven's Benchmark
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="VMware\VMware Workstation"; Depth="2"; Parent=""; Basename="*.exe"; }; # VMware Workstation
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="WinDirStat"; Depth="1"; Parent=""; Basename="windirstat.exe"; }; # WinDirStat (Disk Usage Analyzer)
		$ExcludedProcesses += @{ Dirname=${ProgFilesX86}; AddDir="World of Warcraft"; Depth="2"; Parent=""; Basename="*.exe"; Entertainment=$True; }; # WoW
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
		$ExcludedProcesses += @{ Dirname=${Sys32}; AddDir=""; Depth="1"; Parent=""; Basename="mfevtps.exe"; }; # McAfee Process Validation service
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
		$ExcludedProcesses += @{ Dirname=${SysDrive}; AddDir="ProgramData\Logishrd"; Depth=""; Parent=""; Basename="Logi*.exe"; };
		$ExcludedProcesses += @{ Dirname=${SysDrive}; AddDir="ProgramData\Microsoft\Windows Defender\Platform"; Depth=""; Parent=""; Basename="MsMpEng.exe"; };
		$ExcludedProcesses += @{ Dirname=${SysDrive}; AddDir="ProgramData\Microsoft\Windows Defender\Platform"; Depth=""; Parent=""; Basename="NisSrv.exe"; };
		# -- PROCESSES -- SysRoot
		$ExcludedProcesses += @{ Dirname=${SysRoot}; AddDir=""; Depth="1"; Parent=""; Basename="explorer.exe"; };
		$ExcludedProcesses += @{ Dirname=${SysRoot}; AddDir="ImmersiveControlPanel"; Depth="1"; Parent=""; Basename="SystemSettings.exe"; };
		$ExcludedProcesses += @{ Dirname=${SysRoot}; AddDir="SystemApps"; Depth="3"; Parent=""; Basename="ShellExperienceHost.exe"; };
		$ExcludedProcesses += @{ Dirname=${SysRoot}; AddDir="SystemApps"; Depth="3"; Parent=""; Basename="StartMenuExperienceHost.exe"; };
		# $ExcludedProcesses += @{ Dirname=${SysRoot}; AddDir="WinSxS"; Depth="2"; Parent=""; Basename="TiWorker.exe"; }; # Windows Module Installer Worker - Takes forever to find
		# -- PROCESSES -- UserProfile
		$ExcludedProcesses += @{ Dirname=${UserProfile}; AddDir="Documents\MobaXterm"; Depth=""; Parent=""; Basename="Motty.exe"; };
		# -- PROCESSES -- NVIDIA Driver-related
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
				If (($_.Entertainment -Eq $True) -And ($IncludeEntertainment -Eq $False)) {
					If ($PSBoundParameters.ContainsKey('Verbose')) { Write-Output (("Skipping Exclusion (to include, call with `"-Entertainment`"):  [ ")+($_)+(" ]")); }
				} Else {
					If (Test-Path $_) {
						$FoundFilepaths += $_;
					}
					If ($WindowsDefender -eq $True) {
						If (${RunMode_DryRun} -Eq $False) { <# NOT running in Dry Run mode #>
							Add-MpPreference -ExclusionPath "$_" -ErrorAction "SilentlyContinue";
							If ($? -eq $True) {
								If ($PSBoundParameters.ContainsKey('Verbose')) { Write-Output (("Successfully added exclusion for filepath   [ ")+($_)+(" ]")); }
							} Else {
								If (Test-Path $_) {
									If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Output (("Error(s) encountered while trying to exlude filepath:   [ ")+($_)+(" ]")); }
								} Else {
									If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Output (("Skipping exclusion (filepath doesn't exist)   [ ")+($_)+(" ]")); }
								}
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
					If (${RunMode_DryRun} -Eq $False) { <# NOT running in Dry Run mode #>
						Add-MpPreference -ExclusionExtension "$_" -ErrorAction "SilentlyContinue";
						If ($? -eq $True) {
							If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Output (("Successfully added exclusion for extension   [ ")+($_)+(" ]")); }
						} Else {
							If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Output (("Error(s) encountered while trying to exlude extension:   [ ")+($_)+(" ]")); }
						}
					}
				}
			}
		}
		# Determine which processes exist locally
		$ExcludedProcesses | ForEach-Object {
			If ($_ -ne $Null) {
				If (($_.Entertainment -Eq $True) -And ($IncludeEntertainment -Eq $False)) {
					If ($PSBoundParameters.ContainsKey('Verbose')) { Write-Output (("Skipping Exclusion (to include, call with `"-Entertainment`"):  [ ")+($_)+(" ]")); }
				} Else {
					$Each_Dirname = $_.Dirname;
					If ($_.AddDir -ne "") {
						$Each_Dirname = (($_.Dirname)+("\")+($_.AddDir));
					}
					$Each_Basename = $_.Basename;
					$Each_Parent = If (($_.Parent -ne $Null) -And ($_.Parent -ne ""))  { $_.Parent } Else { "" };
					$Each_Depth = If (($_.Depth -ne $Null) -And ($_.Depth -ne ""))  { [Int]$_.Depth } Else { "" };
					If ((Test-Path $Each_Dirname) -And ($Each_Basename -ne "")) {
						If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Output "Searching `"${Each_Dirname}`" for `"${Each_Basename}`"..."; }
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
		# Show Filepaths/Processes found locally (before applying exclusions for them)
		#
		If (!($PSBoundParameters.ContainsKey('Quiet'))) {
			Write-Output "`n""Exclusions - Filepaths (which exist locally):"; If ($FoundFilepaths -eq $Null) { Write-Output "None"; } Else { $FoundFilepaths; }
			Write-Output "`n""Exclusions - Processes (which exist locally):"; If ($FoundProcesses -eq $Null) { Write-Output "None"; } Else { $FoundProcesses; }
			Write-Output "`n""Exclusions - Extensions:"; If ($FoundExtensions -eq $Null) { Write-Output "None"; } Else { $FoundExtensions; }
			Write-Output "`n";
		}
		#
		#
		# ------------------------------------------------------------
		#
		# ESET Exclusions 
		#		Construct an Import-file which contains all exclusions
		#
		If ($ESET -eq $True) {
			If (${RunMode_DryRun} -Eq $False) { <# NOT running in Dry Run mode #>
				$ExitCode = ESET_ExportModifier -ESET_ExportToCopyFrom ($ESET_ExportToCopyFrom) -ESET_ExcludeFilepaths ($FoundFilepaths) -ESET_ExcludeExtensions ($FoundExtensions) -ESET_ExcludeProcesses ($FoundProcesses);
			}
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

				# Cannot find Malwarebytes' exclusions tool/utility
				Write-Output "";
				Write-Output "  Error: Unable to find Malwarebytes' exclusions tool/utility `"${MBAR_FindBasename}`" in directory `"${MBAR_SearchDirname}`"  ";
				Write-Output "";

			} Else {

				#	Found Malwarebytes' exclusions tool/utility
				Write-Output "";
				Write-Output "  Info: Malwarebytes' exclusions tool/utility found with path `"${MalwarebytesAssistant}`"  ";
				Write-Output "";

				If (${RunMode_DryRun} -Eq $False) { <# NOT running in Dry Run mode #>
					$FoundProcesses | Select-Object -Unique | ForEach-Object {
						Start-Process -Filepath ("${MalwarebytesAssistant}") -ArgumentList (@("--exclusions add `"$_`"")) -NoNewWindow -Wait -PassThru -ErrorAction ("SilentlyContinue");
					}
				}

			}
		}
		# ------------------------------------------------------------
		#
		# Windows Defender Exclusions
		#		Apply directly via PowerShell built-in command(s)
		#
		If ($WindowsDefender -eq $True) {

			If (${RunMode_DryRun} -Eq $False) { <# NOT running in Dry Run mode #>
				<# Apply process exclusions for matching files found locally #>
				$FoundProcesses | Select-Object -Unique | ForEach-Object {
					If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Output "Adding Defender Process-Exclusion: `"$_`"..."; }
					Add-MpPreference -ExclusionProcess "$_" -ErrorAction "SilentlyContinue";
					If ($? -eq $True) {
						If ($PSBoundParameters.ContainsKey('Verbose')) { Write-Output (("Successfully added exclusion for process   [ ")+($_)+(" ]")); }
					} Else {
						If (Test-Path $_) {
							If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Output (("Error(s) encountered while trying to exlude process:   [ ")+($_)+(" ]")); }
						} Else {
							If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Output (("Skipping exclusion (process doesn't exist)   [ ")+($_)+(" ]")); }
						}
					}
				}
				If ($PSBoundParameters.ContainsKey('RemoveMissing')) {
					<# Remove process exclusions for files NOT found locally #>
					$ProcessExclusions_Removed = @();
					((Get-MpPreference).ExclusionProcess) | ForEach-Object {
						If ((Test-Path -LiteralPath ("$_")) -NE $True) {
							$ProcessExclusions_Removed += ("$_");
							Write-Output "Removing Defender Process-Exclusion: `"$_`"...";
							If (${RunMode_DryRun} -Eq $False) { <# NOT running in Dry Run mode #>
								Remove-MpPreference -ExclusionProcess ("$_") -ErrorAction "SilentlyContinue";
							}
						}
					}
					Write-Output "`nWindows Defender (Removed Exclusions) - Processes: $(${ProcessExclusions_Removed}.Count;)"; If ($ProcessExclusions_Removed -eq $Null) { Write-Output "0"; } Else { ${ProcessExclusions_Removed}.Count; }
				}
				<# Ensure that exclusions lists set by "Add-MpPreference" are actually used #>
				If ($True) {
					Write-Output "`nSetting Registry Key values to ensure that exclusions lists set by `"Add-MpPreference`" are actually used";
					<# Configure local setting override for monitoring file and program activity on your computer - https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsDefender::RealtimeProtection_LocalSettingOverrideDisableOnAccessProtection #>
					If (-Not (Test-Path -Path ("Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection"))) { New-Item -Force -Path ("Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection") | Out-Null; };
					Set-ItemProperty -LiteralPath ("Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection") -Name ("LocalSettingOverrideDisableOnAccessProtection") -Value (1) | Out-Null;
					<# Configure local administrator merge behavior for lists  -  https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsDefender::DisableLocalAdminMerge #>
					If (-Not (Test-Path -Path ("Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender"))) { New-Item -Force -Path ("Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender") | Out-Null; };
					Set-ItemProperty -LiteralPath ("Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender") -Name ("DisableLocalAdminMerge") -Value (0) | Out-Null;
				}
			}
			# $FinalExclusions = @{};
			# ${FinalExclusions}.ExclusionExtension = ((Get-MpPreference).ExclusionExtension);
			# ${FinalExclusions}.ExclusionPath = ((Get-MpPreference).ExclusionPath);
			# ${FinalExclusions}.ExclusionProcess = ((Get-MpPreference).ExclusionProcess);
			$FinalExclusions = (Get-MpPreference);
			Write-Output "`nWindows Defender (Live Exclusions) - File-Extensions: $(If (${FinalExclusions}.ExclusionExtension -eq $Null) { Write-Output "0"; } Else { ${FinalExclusions}.ExclusionExtension.Count; };)";
			Write-Output "`nWindows Defender (Live Exclusions) - Filepaths: $(If (${FinalExclusions}.ExclusionPath -eq $Null) { Write-Output "0"; } Else { ${FinalExclusions}.ExclusionPath.Count; };)";
			Write-Output "`nWindows Defender (Live Exclusions) - Processes: $(If (${FinalExclusions}.ExclusionProcess -eq $Null) { Write-Output "0"; } Else { ${FinalExclusions}.ExclusionProcess.Count; };)";
		}
		#
		# ------------------------------------------------------------
		#
		$WaitCloseSeconds = 60;
		Write-Output "`nClosing after ${WaitCloseSeconds}s...";
		Write-Output "`n";
		Start-Sleep -Seconds ${WaitCloseSeconds};
	}
}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "ExclusionsListUpdate";
}


# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function ESET_ExportModifier {
	Param(

		[String]$ESET_ExportToCopyFrom,

		[String[]]$ESET_ExcludeFilepaths = @(),

		[String[]]$ESET_ExcludeProcesses = @(),

		[String[]]$ESET_ExcludeExtensions = @()

	)

	If ((Test-Path -Path ("$ESET_ExportToCopyFrom")) -eq $False) {
		Write-Output "";
		Write-Output "  Error in function `"ESET_ExportModifier`"  ";
		Write-Output "";
		Write-Output "    Please go to ESET > 'Setup' > 'Import/Export Settings' > 'Export settings' to path: `n`n    $ESET_ExportToCopyFrom    `n`n";
		Write-Output "";
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

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "ESET_ExportModifier";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Add-MpPreference (Defender) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/defender/add-mppreference
#
#   docs.microsoft.com  |  "Select-Xml (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/select-xml
#
#   docs.microsoft.com  |  "Configure Microsoft Defender Antivirus exclusions on Windows Server | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-antivirus/configure-server-exclusions-windows-defender-antivirus
#
#   docs.microsoft.com  |  "Configure and validate exclusions based on extension, name, or location | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-antivirus/configure-extension-file-exclusions-windows-defender-antivirus
#
#   superuser.com  |  "How to monitor Windows Defender real time protection? - Super User"  |  https://superuser.com/questions/1256548
#
# ------------------------------------------------------------