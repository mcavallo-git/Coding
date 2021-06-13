
function ProfileSync {
	Param(

		[String]$MessageOnSuccess = 'Pass - Startup scripts configured (see $Profile)',
		
		[String]$GithubOwner = 'mcavallo-git',
		
		[String]$GithubRepo = 'Coding',

		[Switch]$NoOverwrite,

		[Switch]$Quiet

	)
	# ------------------------------------------------------------
	If ($False) { # RUN THIS SCRIPT:


		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/master/sync.ps1?t=$((Date).Ticks)")); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;


	}
	# ------------------------------------------------------------
	
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
			If ($psm1.verbosity -ne 0) { Write-Host (("ProfileSync - Create parent-directory for Profile: ")+($i_FullPath)); }
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

	$Pro += ('[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/master/sync.ps1?t=$((Date).Ticks)"));');

	### Overwrite $Profile content
	If (($PSBoundParameters.ContainsKey('NoOverwrite')) -Eq ($False)) {
		Set-Content -Path ("${Profile}") -Value ("");
	}

	# Format each string-statement for Regex
	For ($i=0; $i -lt $Pro.length; $i++) { If (!(Get-Content $Profile | Select-String $Pro[$i].Replace("\", "\\"))) { (("`n")+($Pro[$i])) | Add-Content $Profile; } }

	If (($PSBoundParameters.ContainsKey('Quiet')) -Eq ($False)) {
		$EchoFormatted = $MessageOnSuccess;
		$EchoDashes = "-" * ($EchoFormatted.length);
		Write-Host (("`n`n") + ($EchoDashes) + ("`n") + ($EchoFormatted) + ("`n") + ($EchoDashes) + ("`n`n"));
		
	}

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "ProfileSync" -ErrorAction "SilentlyContinue";
}

