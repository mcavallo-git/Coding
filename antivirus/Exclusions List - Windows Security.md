

# Windows Security
### Exclusion List

***
## PowerShell - Auto-Exclusions Script
###### Add paths (files/folders) to the exclusion list
###### Note: !!! Requires elevated permissions (run powershell as admin and paste code into terminal) !!!

```


# Setup static references
$SystemDrive=(${Env:SystemDrive});
$ProgFilesX64=((${SystemDrive})+("\Program Files"));
$ProgFilesX86=(($ProgFilesX64)+(" (x86)"));
$LocalAppData=(${Env:LocalAppData});
$UserProfile=(${Env:UserProfile});

# Define list of filepaths to create exclusions-for
$ExclusionPaths = @();

# LocalAppData Paths
$ExclusionPaths += ((${LocalAppData})+("\Google\Google Apps Sync"));
$ExclusionPaths += ((${LocalAppData})+("\GitHubDesktop"));
$ExclusionPaths += ((${LocalAppData})+("\Microsoft\OneDrive"));

# ProgFilesX64 Paths
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
$ExclusionPaths += ((${ProgFilesX64})+("\paint.net"));

# ProgFilesX86 Paths
$ExclusionPaths += ((${ProgFilesX86})+("\Dropbox"));
$ExclusionPaths += ((${ProgFilesX86})+("\efs"));
$ExclusionPaths += ((${ProgFilesX86})+("\Intel"));
$ExclusionPaths += ((${ProgFilesX86})+("\LastPass"));
$ExclusionPaths += ((${ProgFilesX86})+("\Mailbird"));
$ExclusionPaths += ((${ProgFilesX86})+("\Malwarebytes Anti-Exploit"));
$ExclusionPaths += ((${ProgFilesX86})+("\Microsoft Office"));
$ExclusionPaths += ((${ProgFilesX86})+("\Microsoft OneDrive"));
$ExclusionPaths += ((${ProgFilesX86})+("\Mobatek"));
$ExclusionPaths += ((${ProgFilesX86})+("\Notepad++"));
$ExclusionPaths += ((${ProgFilesX86})+("\Reflector 3"));
$ExclusionPaths += ((${ProgFilesX86})+("\Splashtop"));
$ExclusionPaths += ((${ProgFilesX86})+("\WinDirStat"));

# SystemDrive Paths
$ExclusionPaths += ((${SystemDrive})+("\BingBackground"));
$ExclusionPaths += ((${SystemDrive})+("\ISO\BingBackground"));
$ExclusionPaths += ((${SystemDrive})+("\ISO\QuickNoteSniper"));

# UserProfile Paths
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
		Write-Host (("Adding Exclusion (path exists): [ ")+($EachExclusionPath)+(" ]"));
		Add-MpPreference -ExclusionPath ($EachExclusionPath);
	} Else {
		Write-Host (("Skipping Exclusion (path doesn't exist):   [ ")+($EachExclusionPath)+(" ]"));
	}
}

# Review the list of exclusions
$GetMp = Get-MpPreference; `
Write-Host "`nExclusions - File Extensions:"; If ($GetMp.ExclusionExtension -eq $Null) { Write-Host "None"; } Else { $GetMp.ExclusionExtension; } `
Write-Host "`nExclusions - Processes:"; If ($GetMp.ExclusionProcess -eq $Null) { Write-Host "None"; } Else { $GetMp.ExclusionProcess; } `
Write-Host "`nExclusions - Paths:"; If ($GetMp.ExclusionPath -eq $Null) { Write-Host "None"; } Else { $GetMp.ExclusionPath; } `
Write-Host "`n";


```


***
## PowerShell Commands
###### Perform/Test-via individual actions

Add [ file-extension ] to the exclusion list
```Add-MpPreference -ExclusionExtension ".Example"```

Add [ path to file/folder ] to the exclusion list
```Add-MpPreference -ExclusionPath "C:\Example"```

Create or overwrite the exclusion list
```Set-MpPreference```

Remove item from the exclusion list
```Remove-MpPreference```

Review the list of exclusions alongside all other Windows Defender Antivirus preferences
```Get-MpPreference```


***
## View Exclusion List
###### Manually inspect/add-to the exclusion list, directly
* In Windows 10, perform a start menu search for ```Virus & threat protection``` & open the respective settings page
* Under ```Virus & threat protection settings``` select ```Manage settings```
* Under ```Exclusions``` select ```Add or remove exclusions```
* Iteratively select ```Add an exclusion``` (dropdown), select the desired exclusion-type (file, folder, file-type, or process), and then input the associated  exclusion-path



***
## Citation(s)
[docs.microsoft.com - "Configure and validate exclusions based on file extension and folder location"](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-antivirus/configure-extension-file-exclusions-windows-defender-antivirus)
