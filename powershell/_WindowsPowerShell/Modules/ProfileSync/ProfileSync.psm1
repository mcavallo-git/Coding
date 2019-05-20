function ProfileSync {
	Param(

		[String]$MessageOnSuccess = 'Pass - Startup scripts configured (see $Profile)',
		
		[String]$GithubOwner = 'mcavallo-git',
		
		[String]$GithubRepo = 'Coding',

		[Switch]$OverwriteProfile,

		[Switch]$Quiet

	)

	# Ensure that the directory "$Home/.config" exists before first-use
	$CfgPath = (($Home)+("/.config"));
	$CfgExists = Test-Path -Path ($CfgPath);
	If ($CfgExists -eq $false) {
		New-Item -ItemType "Directory" -Path (($CfgPath)+("/")) | Out-Null;
	}

	# Ensure that the directory "$Home/.config/PowerShell" exists before first-use
	$PowerShellPath = (($CfgPath)+("/PowerShell"));
	$PowerShellExists = Test-Path -Path ($PowerShellPath);
	If ($PowerShellExists -eq $false) {
		New-Item -ItemType "Directory" -Path (($PowerShellPath)+("/")) | Out-Null;
	}

	# Get Parent directories which the [ unique Profile directory associated with this user ] is dependen-on
	$Profile_SplitChar = If (($Profile.Split('/')) -eq ($Profile)) { '\' } Else { '/' };
	$Profile_HomeDir = $Profile.Replace((($Home)+($Profile_SplitChar)),"");
	$Profile_ParentDirs = $Profile_HomeDir.Split($Profile_SplitChar);
	# Create parent-directories which are [ required ancestors to the Profile directory ] but are currently [ non-existent ]
	$i_FullPath = $Home;
	For ($i=0; $i -lt ($Profile_ParentDirs.length-1); $i++) {
		$i_FullPath += (($Profile_SplitChar)+($Profile_ParentDirs[$i]));
		If ((Test-Path -PathType Container -Path (($i_FullPath)+($Profile_SplitChar))) -eq $false) {
			# Directory doesn't exist - create it
			If ($psm1.verbosity -ne 0) { Write-Host (("Task - Create parent-directory for Profile: ")+($i_FullPath)); }
			New-Item -ItemType "Directory" -Path (($i_FullPath)+($Profile_SplitChar)) | Out-Null;
		} Else {
			# Directory exists - skip it
			If ($psm1.verbosity -ne 0) { Write-Host (("Skip - Parent-directory for Profile already exists: ")+($i_FullPath)); }
		}
	}

	# Ensure that the file "$Home/.config/PowerShell/Microsoft.PowerShell_profile.ps1" exists before attempting to write to it
	$ProfileExists = Test-Path -PathType "Leaf" -Path ($Profile);
	If ($ProfileExists -eq $false) {
		
		# Create the profile script (necessary action per-user), if not found to exist
		New-Item -ItemType "File" -Path ($Profile) -Value (("### Created on [ ")+(Get-Date ((Get-Date).ToUniversalTime()) -UFormat "%Y%m%d%H%M%S")+(" ] `n")) | Out-Null;
		$ProfileExists = Test-Path -PathType "Leaf" -Path ($Profile);

		If ($ProfileExists -eq $false) {
			# Fail - Unable to Create [Powershell Profile Script]
			Write-Host (("Fail - Unable to Create [Powershell Profile Script]: ") + ($file.BaseName));
			Start-Sleep -Seconds 60;
			Exit 1;

		} Else {
			# Pass - Created Powershell Profile Script
			Write-Host (("Pass - Created Powershell Profile Script: ") + ($file.BaseName));
			
		}
	}
	
	$Pro = @();

	$Pro += 'Write-Host "Loading personal and system profiles...";';

	$Pro += 'New-Alias grep Select-String;';

	$Pro += 'New-Alias which Get-Command;';

	$Pro += (('$GithubOwner="')+(${GithubOwner})+('"; $GithubRepo="')+(${GithubRepo})+('";')+(' Write-Host "Syncing Git-Repo: `"https://github.com/${GithubOwner}/${GithubRepo}.git`"`n"; If (Test-Path "${HOME}/${GithubRepo}") { Set-Location "${HOME}/${GithubRepo}"; git reset --hard "origin/master"; git pull; } Else { Set-Location "${HOME}"; git clone "https://github.com/${GithubOwner}/${GithubRepo}.git"; } . "${HOME}/${GithubRepo}/powershell/_WindowsPowerShell/Modules/ImportModules.ps1";'));
	$Pro += 'Set-Location "${HOME}";';

	### Overwrite $Profile content
	If ($PSBoundParameters.ContainsKey("OverwriteProfile")) {
		Set-Content $Profile "";
	}

	# Format each string-statement for Regex
	For ($i=0; $i -lt $Pro.length; $i++) { If (!(Get-Content $Profile | Select-String $Pro[$i].Replace("\", "\\"))) { (("`n")+($Pro[$i])) | Add-Content $Profile; } }

	If (!($PSBoundParameters.ContainsKey('Quiet'))) {
		$EchoFormatted = $MessageOnSuccess;
		$EchoDashes = "-" * ($EchoFormatted.length);
		Write-Host (("`n`n") + ($EchoDashes) + ("`n") + ($EchoFormatted) + ("`n") + ($EchoDashes) + ("`n`n"));
		
	}

}

Export-ModuleMember -Function "ProfileSync";
