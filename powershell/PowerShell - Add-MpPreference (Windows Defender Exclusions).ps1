# Windows Security - Items to add to Windows Defender's Exclusion List

# User / System Directories
$LocalAppData = (${Env:LocalAppData}); # LocalAppData
$ProgFilesX64 = ((${Env:SystemDrive})+("\Program Files")); # ProgFilesX64
$ProgFilesX86 = ((${Env:SystemDrive})+("\Program Files (x86)")); # ProgFilesX86
$SystemDrive = (${Env:SystemDrive}); # SystemDrive
$System32 = ((${Env:SystemRoot})+("\System32")); # System32
$UserProfile = (${Env:USERPROFILE}); # UserProfile

# **** PROCESS EXCLUSIONS

$ExclusionProcesses = @();
# -- PROCESSES -- LocalAppData
$ExclusionProcesses += ((${LocalAppData})+("\Dropbox\Client\Dropbox.exe"));
$ExclusionProcesses += ((${LocalAppData})+("\GitHubDesktop\GitHubDesktop.exe"));
# -- PROCESSES -- ProgFiles X64
$ExclusionProcesses += ((${ProgFilesX64})+("\AutoHotkey\AutoHotkey.exe"));
$ExclusionProcesses += ((${ProgFilesX64})+("\Classic Shell\ClassicStartMenu.exe"));
$ExclusionProcesses += ((${ProgFilesX64})+("\Cryptomator\Cryptomator.exe"));
$ExclusionProcesses += ((${ProgFilesX64})+("\FileZilla FTP Client\filezilla.exe"));
$ExclusionProcesses += ((${ProgFilesX64})+("\Git\cmd\git.exe"));
$ExclusionProcesses += ((${ProgFilesX64})+("\Git\git-bash.exe"));
$ExclusionProcesses += ((${ProgFilesX64})+("\Greenshot\Greenshot.exe"));
$ExclusionProcesses += ((${ProgFilesX64})+("\Malwarebytes\Anti-Malware\mbam.exe"));
$ExclusionProcesses += ((${ProgFilesX64})+("\Malwarebytes\Anti-Malware\mbamtray.exe"));
$ExclusionProcesses += ((${ProgFilesX64})+("\Microsoft VS Code\Code.exe"));
$ExclusionProcesses += ((${ProgFilesX64})+("\NVIDIA Corporation\NvContainer\nvcontainer.exe"));
$ExclusionProcesses += ((${ProgFilesX64})+("\NVIDIA Corporation\ShadowPlay\nvsphelper64.exe"));
$ExclusionProcesses += ((${ProgFilesX64})+("\NVIDIA Corporation\NVIDIA GeForce Experience\NVIDIA GeForce Experience.exe"));
$ExclusionProcesses += ((${ProgFilesX64})+("\NVIDIA Corporation\NVIDIA GeForce Experience\NVIDIA Notification.exe"));
$ExclusionProcesses += ((${ProgFilesX64})+("\NVIDIA Corporation\NVIDIA GeForce Experience\NVIDIA Share.exe"));
# -- PROCESSES -- ProgFiles X86
$ExclusionProcesses += ((${ProgFilesX86})+("\Dropbox\Client\Dropbox.exe"));
$ExclusionProcesses += ((${ProgFilesX86})+("\Intel\Thunderbolt Software\tbtsvc.exe"));
$ExclusionProcesses += ((${ProgFilesX86})+("\Intel\Thunderbolt Software\Thunderbolt.exe"));
$ExclusionProcesses += ((${ProgFilesX86})+("\Unigine\Heaven Benchmark 4.0\bin\Heaven.exe"));
$ExclusionProcesses += ((${ProgFilesX86})+("\Microsoft Office\root\Office16\lync.exe"));
$ExclusionProcesses += ((${ProgFilesX86})+("\Mobatek\MobaXterm\MobaXterm.exe"));
$ExclusionProcesses += ((${ProgFilesX86})+("\Razer\Razer Services\Razer Central\Razer Central.exe"));
$ExclusionProcesses += ((${ProgFilesX86})+("\Razer\Razer Services\Razer Central\Razer Updater.exe"));
$ExclusionProcesses += ((${ProgFilesX86})+("\Razer\Razer Services\Razer Central\RazerCentralService.exe"));
$ExclusionProcesses += ((${ProgFilesX86})+("\Razer\Synapse3\Service\Razer Synapse Service.exe"));
$ExclusionProcesses += ((${ProgFilesX86})+("\Razer\Synapse3\UserProcess\Razer Synapse Service Process.exe"));
$ExclusionProcesses += ((${ProgFilesX86})+("\Razer\Synapse3\WPFUI\Framework\Razer Synapse 3 Host\Razer Synapse 3.exe"));
# -- PROCESSES -- System32
$ExclusionProcesses += ((${System32})+("\DbxSvc.exe"));  # (DROPBOX)
$ExclusionProcesses += ((${System32})+("\DriverStore\FileRepository\igdlh64.inf_amd64_8a9535cd18c90bc3\igfxEM.exe"));  # (INTEL)
$ExclusionProcesses += ((${System32})+("\DriverStore\FileRepository\igdlh64.inf_amd64_8a9535cd18c90bc3\IntelCpHDCPSvc.exe"));  # (INTEL)
# -- PROCESSES -- UserProfile
$ExclusionProcesses += ((${UserProfile})+("\Documents\MobaXterm\slash\bin\Motty.exe"));


# **** FILEPATH EXCLUSIONS

$ExclusionPaths = @();
# -- FILEPATHS -- LocalAppData
$ExclusionPaths += ((${LocalAppData})+("\Google\Google Apps Sync"));
$ExclusionPaths += ((${LocalAppData})+("\GitHubDesktop"));
$ExclusionPaths += ((${LocalAppData})+("\Microsoft\OneDrive"));
# -- FILEPATHS -- ProgFiles X64
$ExclusionPaths += ((${ProgFilesX64})+("\7-Zip"));
$ExclusionPaths += ((${ProgFilesX64})+("\AirParrot 2"));
$ExclusionPaths += ((${ProgFilesX64})+("\AutoHotkey"));
$ExclusionPaths += ((${ProgFilesX64})+("\Classic Shell"));
$ExclusionPaths += ((${ProgFilesX64})+("\Cryptomator"));
$ExclusionPaths += ((${ProgFilesX64})+("\ESET"));
$ExclusionPaths += ((${ProgFilesX64})+("\FileZilla FTP Client"));
$ExclusionPaths += ((${ProgFilesX64})+("\Git"));
$ExclusionPaths += ((${ProgFilesX64})+("\Greenshot"));
$ExclusionPaths += ((${ProgFilesX64})+("\HandBrake"));
$ExclusionPaths += ((${ProgFilesX64})+("\KDiff3"));
$ExclusionPaths += ((${ProgFilesX64})+("\Malwarebytes"));
$ExclusionPaths += ((${ProgFilesX64})+("\Mailbird"));
$ExclusionPaths += ((${ProgFilesX64})+("\Microsoft Office 15"));
$ExclusionPaths += ((${ProgFilesX64})+("\Microsoft VS Code"));
$ExclusionPaths += ((${ProgFilesX64})+("\NVIDIA Corporation"));
$ExclusionPaths += ((${ProgFilesX64})+("\paint.net"));
# -- FILEPATHS -- ProgFiles X86
$ExclusionPaths += ((${ProgFilesX86})+("\Dropbox"));
$ExclusionPaths += ((${ProgFilesX86})+("\efs"));
$ExclusionPaths += ((${ProgFilesX86})+("\GIGABYTE"));
$ExclusionPaths += ((${ProgFilesX86})+("\Intel"));
$ExclusionPaths += ((${ProgFilesX86})+("\LastPass"));
$ExclusionPaths += ((${ProgFilesX86})+("\Mailbird"));
$ExclusionPaths += ((${ProgFilesX86})+("\Malwarebytes Anti-Exploit"));
$ExclusionPaths += ((${ProgFilesX86})+("\Microsoft Office"));
$ExclusionPaths += ((${ProgFilesX86})+("\Microsoft OneDrive"));
$ExclusionPaths += ((${ProgFilesX86})+("\Mobatek"));
$ExclusionPaths += ((${ProgFilesX86})+("\Notepad++"));
$ExclusionPaths += ((${ProgFilesX86})+("\Razer"));
$ExclusionPaths += ((${ProgFilesX86})+("\Razer Chroma SDK"));
$ExclusionPaths += ((${ProgFilesX86})+("\Reflector 3"));
$ExclusionPaths += ((${ProgFilesX86})+("\Splashtop"));
$ExclusionPaths += ((${ProgFilesX86})+("\WinDirStat"));
# -- FILEPATHS -- SystemDrive
$ExclusionPaths += ((${SystemDrive})+("\BingBackground"));
$ExclusionPaths += ((${SystemDrive})+("\ISO\BingBackground"));
$ExclusionPaths += ((${SystemDrive})+("\ISO\QuickNoteSniper"));
# -- FILEPATHS -- System32
$ExclusionPaths += ((${System32})+("\wbem\WmiPrvSE.exe")); # Windows Management Instrumentation Provider
$ExclusionPaths += ((${System32})+("\DbxSvc.exe")); # Dropbox
# -- FILEPATHS -- UserProfile
$UserProfile=(${Env:UserProfile});
$ExclusionPaths += ((${UserProfile})+("\Dropbox"));

# Add OneDrive paths to exclusions list
If (${Env:OneDrive} -ne $null) {
	$ExclusionPaths += ${Env:OneDrive};
	$ExclusionPaths += (${Env:OneDrive}).replace("OneDrive - ","");
}

# Add OneDrive4Biz paths to exclusions list
If (${Env:OneDriveCommercial} -ne $null) {
	$ExclusionPaths += ${Env:OneDriveCommercial}; 
	$ExclusionPaths += (${Env:OneDriveCommercial}).replace("OneDrive - ","");
}

# Add the exclusions
ForEach ($EachFilepath In ($ExclusionPaths | Select-Object -Unique)) {
	If (($EachFilepath -ne $null) -And (Test-Path $EachFilepath)) {
		Write-Host (("Adding Exclusion (Filepath)   [ ")+($EachFilepath)+(" ]"));
		Add-MpPreference -ExclusionPath ($EachFilepath);
	} Else {
		Write-Host (("Skipping Exclusion (Filepath doesn't exist)   [ ")+($EachFilepath)+(" ]"));
	}
}
ForEach ($EachProcess In ($ExclusionProcesses | Select-Object -Unique)) {
	Write-Host (("Adding Exclusion (Process)   [ ")+($EachProcess)+(" ]"));
	Add-MpPreference -ExclusionProcess ($EachProcess);
}

# Review the list of exclusions
$GetMp = Get-MpPreference; `
Write-Host "`nExclusions - File Extensions:"; If ($GetMp.ExclusionExtension -eq $Null) { Write-Host "None"; } Else { $GetMp.ExclusionExtension; } `
Write-Host "`nExclusions - Processes:"; If ($GetMp.ExclusionProcess -eq $Null) { Write-Host "None"; } Else { $GetMp.ExclusionProcess; } `
Write-Host "`nExclusions - Paths:"; If ($GetMp.ExclusionPath -eq $Null) { Write-Host "None"; } Else { $GetMp.ExclusionPath; } `
Write-Host "`n";


#
# Citation(s)
#
#		docs.microsoft.com
#			"Add-MpPreference"
#			 https://docs.microsoft.com/en-us/powershell/module/defender/add-mppreference?view=win10-ps
#
#		docs.microsoft.com
#			"Configure and validate exclusions based on file extension and folder location"
#			 https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-antivirus/configure-extension-file-exclusions-windows-defender-antivirus
#