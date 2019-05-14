# Windows Security - Exclusions Script
#		--> Add paths (single files and/or entire directories) to Windows Security's Exclusion List

# Define list of filepaths to create exclusions-for
$ExclusionPaths = @();

$LocalAppData=(${Env:LocalAppData}); # LocalAppData Path(s)
$ExclusionPaths += ((${LocalAppData})+("\Google\Google Apps Sync"));
$ExclusionPaths += ((${LocalAppData})+("\GitHubDesktop"));
$ExclusionPaths += ((${LocalAppData})+("\Microsoft\OneDrive"));

$ProgFilesX64=((${Env:SystemDrive})+("\Program Files")); # ProgFilesX64 Path(s)
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

$ProgFilesX86=((${Env:SystemDrive})+("\Program Files (x86)")); # ProgFilesX86 Path(s)
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

$SystemDrive=(${Env:SystemDrive}); # SystemDrive Path(s)
$ExclusionPaths += ((${SystemDrive})+("\BingBackground"));
$ExclusionPaths += ((${SystemDrive})+("\ISO\BingBackground"));
$ExclusionPaths += ((${SystemDrive})+("\ISO\QuickNoteSniper"));

$System32=((${Env:SystemRoot})+("\System32")); # System32 Path(s)
$ExclusionPaths += ((${System32})+("\wbem\WmiPrvSE.exe")); # Windows Management Instrumentation Provider
$ExclusionPaths += ((${System32})+("\DbxSvc.exe")); # Dropbox

$UserProfile=(${Env:UserProfile}); # UserProfile Path(s)
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

# Add each exclusion (only if the path exits, per item)
ForEach ($EachExclusionPath In ($ExclusionPaths | Select-Object -Unique)) {
	If (($EachExclusionPath -ne $null) -And (Test-Path $EachExclusionPath)) {
		Write-Host (("Adding Exclusion   [ ")+($EachExclusionPath)+(" ]"));
		Add-MpPreference -ExclusionPath ($EachExclusionPath);
	} Else {
		Write-Host (("Skipping Exclusion (path doesn't exist)   [ ")+($EachExclusionPath)+(" ]"));
	}
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
#		docs.microsoft.com  :::  "Configure and validate exclusions based on file extension and folder location"  :::  https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-antivirus/configure-extension-file-exclusions-windows-defender-antivirus
#