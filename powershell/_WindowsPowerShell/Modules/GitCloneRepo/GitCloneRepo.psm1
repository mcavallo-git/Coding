function GitCloneRepo {
	Param(

		[Parameter(Mandatory=$true)]
		[String]$Url,

		[String]$LocalDirname,

		[String]$GitBranch = "master",

		[String]$CommitSHA = "",

		[Switch]$Quiet,

		[Switch]$SkipResolveUrl

	)
	
	# Default the parent-dir to temp-dir (when no dir is passed via parameter specification)
	If (!($PSBoundParameters.ContainsKey('LocalDirname'))) {

		$TmpDir = If ($Tmp -ne $null) { $Tmp } ElseIf ($Env:Tmp -ne $null) { $Env:Tmp } Else { $Home };

		$DefaultDirname = (($TmpDir)+("/")+("GitCloneRepo"));

		If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host (("Task - Defaulting git repository's parent directory to `"")+($DefaultDirname)+("`"")); }

		$LocalDirname = $DefaultDirname;
		
	}

	$CanUse_sh = If ((Get-Command -Name "sh" -ErrorAction 'SilentlyContinue') -ne $null) { $true } Else { $false };
	$CanUse_bash = If ((Get-Command -Name "bash" -ErrorAction 'SilentlyContinue') -ne $null) { $true } Else { $false };

	# Setup Git Object
	$Repo = @{};

	$Repo.ParentDir = $LocalDirname;

	$Repo.ParentDirExists = Test-Path -Path ($Repo.ParentDir);

	# Determine if we need to create repository's parent-directory
	If ($Repo.ParentDirExists -eq $false) {
		If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host (("Task - Creating git repository's parent directory `"")+($Repo.ParentDir)+("`"")); }
		New-Item -ItemType "Directory" -Path (($Repo.ParentDir)+("/")) | Out-Null;
	} Else {
		If (!($PSBoundParameters.ContainsKey('Quiet'))) { <# Write-Host (("Skip - No need to create repo parent-directory (already exists): ") + ($Repo.ParentDir)); #> }
	}

	Set-Location -Path ($Repo.ParentDir);

	$ReponameGuess = [System.IO.Path]::GetFileNameWithoutExtension($Url.Split("/")[-1]);

	$ResolvedUrl = $null;
	If ($PSBoundParameters.ContainsKey('SkipResolveUrl')) {
		$ResolvedUrl = $Url;
		
	} Else {

		# Attempt to resolve any git repository url redirects
		$ResolvedUrl = [System.Net.HttpWebRequest]::Create($Url).GetResponse().ResponseUri.AbsoluteUri;

		$ResolvedExitCode = If($?){0}Else{1};
		If ($ResolvedExitCode -ne 0) {
			# Unable to resolve git repository url
			$ResolvedUrl = $Url;
		}

		# Determine if Git-Repo Url is forwarded or not
		If ($ResolvedUrl -ne $Url) {
			If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host "Pass - Resolved git repository url to `"${ResolvedUrl}`" from `"${Url}`""; }
		} Else {
			If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host "Pass - Resolved git repository url to `"${ResolvedUrl}`""; }
		}

	}

	# Repo-Basename
	$Repo.RepoBasename = [System.IO.Path]::GetFileNameWithoutExtension(([System.Uri]$ResolvedUrl).Segments[-1]);

	# Determine if we need to clone the repo (first-time use) or pull the repo (every-time-after use)
	$WorkingTreeFullpath = (($Repo.ParentDir) + ("/") + ($Repo.RepoBasename));
	
	$Repo.ConfigDir_Fullpath = (($WorkingTreeFullpath) + ("/.git"));

	$Repo.ConfigFile_Fullpath = (($Repo.ConfigDir_Fullpath) + ("/config"));
	
	
	If ((Test-Path -Path ($Repo.ConfigFile_Fullpath)) -eq $true) {

		# Repo exists & has a "/.git/config" file in it - try to reset it
		Set-Location -Path ($WorkingTreeFullpath);
		$CommandDescription = "Resetting local git repository to branch `"origin/${GitBranch}`"";
		$Repo.ResetHead = (git reset --hard "origin/${GitBranch}");
		$Repo.ResetExitCode = If($?){0}Else{1};
		If ($Repo.CloneExitCode -ne 0) {
			If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host (("Fail - Error thrown while [")+($CommandDescription)+("]")); }
		} Else {
			If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host (("Pass - Success while [")+($CommandDescription)+("]")); }
		}
		# $Repo.Pull = (git pull);
		# $Repo.PullExitCode = If($?){0}Else{1};


	} Else {

		# Repo dir exists, but doesn't have a "/.git/config" file - try to remove it
		If ((Test-Path -PathType Container -Path ($WorkingTreeFullpath)) -eq $true) {
			$CommandDescription = "Attempting to remove directory containing git-repo (working-tree)";
			If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host (("Task - ")+($CommandDescription)+(": ") + ($Repo.RepoBasename)); }
			Remove-Item ($WorkingTreeFullpath) -Force -Recurse; Start-Sleep -Seconds 1;
			If ((Test-Path -Path ($WorkingTreeFullpath)) -eq $true) {
				# Failed to remove directory
				Write-Host (("Fail - Error thrown while [")+($CommandDescription)+("]"));
				Start-Sleep -Seconds 60;
				Exit 1;
			}
		}
		
		# Clone the Git-Repo
		$Repo.CloneExitCode = $null;
		$CommandDescription = "Attempting to clone git-repo";
		If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host (("Task - ")+($CommandDescription)+(": ") + ($Repo.RepoBasename)); }
		If (!($PSBoundParameters.ContainsKey('Quiet'))) {
			$Repo.CloneUrl = (git clone ($ResolvedUrl));
			$Repo.CloneExitCode = If($?){0}Else{1};
		} Else {
			$Repo.CloneUrl = (git clone --quiet ($ResolvedUrl));
			$Repo.CloneExitCode = If($?){0}Else{1};
		}

		# Fail-out on non-zero exit-codes
		If ($Repo.CloneExitCode -ne 0) {
			Write-Host (("Fail - Error thrown while [")+($CommandDescription)+("]"));
			Start-Sleep -Seconds 60;
			Exit 1;
		}
	
		If ((Test-Path -PathType Container -Path ($WorkingTreeFullpath)) -eq $false) {
			# Failed to Clone Repo
			Write-Host (("Fail - Unable to Clone Git-Repo from Url: ") + ($ResolvedUrl));
			Start-Sleep -Seconds 60;
			Exit 1;
		}
	}

	# Check that Git-Repo directory exists before returning
	If ((Test-Path -PathType Container -Path ($WorkingTreeFullpath)) -eq $false) {
		# Failed to Clone Repo - Exit Immediately
		Write-Host ("Fail - Local git repository's working-tree not found");
		Start-Sleep -Seconds 60;
		Exit 1;

	} Else {

		# Optional - Revert to specific commit SHA hash (revert the repository to a speicifc revision/point-in-time)
		$CommitSHA = $CommitSHA.Trim();
		If (($PSBoundParameters.ContainsKey('CommitSHA')) -and ($CommitSHA.Length -eq "40")) {
			If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host (("Task - Reverting local git repository to commit SHA `"")+($CommitSHA)+("`"")); }
			Set-Location -Path ($WorkingTreeFullpath);
			$Repo.ResetHead = (git reset --hard "$CommitSHA");
		}

		# Successfully found (at least one) repo which exists
		If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host (("Pass - Updated local git repository `"")+($WorkingTreeFullpath)+("`"")); }

		
		# Get the absolute path to this git working-tree via linux sh/bash command
		Set-Location ($WorkingTreeFullpath);
		$WorkingTree_WindowsPath = (pwd);
		$WorkingTree_UnixPath = If ($CanUse_sh -eq $true){ (sh -c "pwd") } Else { (bash -c "pwd") };

		# Remove amateurish non-case-sensitive directires (in Windows) while in a linux-based environment
		$RelPath_InvalidDir = (($Repo.RepoBasename)+(".DTO"));
		$RelPath_CorrectDir = (($Repo.RepoBasename)+(".Dto"));
		
		$AbsPath_InvalidDir = (($WorkingTree_UnixPath)+("/")+($RelPath_InvalidDir));
		$AbsPath_CorrectDir = (($WorkingTree_UnixPath)+("/")+($RelPath_CorrectDir));

		# Determine the number if Duplicates, when there are any
		$LinuxCommand_FindCorrectDirs = "find '$WorkingTree_UnixPath' -maxdepth 1 -type 'd' -name '$RelPath_CorrectDir';";
		$LinuxCommand_FindInvalidDirs = "find '$WorkingTree_UnixPath' -maxdepth 1 -type 'd' -iname '*$RelPath_InvalidDir*' -not -name '$RelPath_CorrectDir';";

		Set-Location ($WorkingTree_WindowsPath);
		$CorrectDirs = If ($CanUse_sh -eq $true) { (sh -c "$LinuxCommand_FindCorrectDirs") } Else { (bash -c "$LinuxCommand_FindCorrectDirs") };
		$InvalidDirs = If ($CanUse_sh -eq $true) { (sh -c "$LinuxCommand_FindInvalidDirs") } Else { (bash -c "$LinuxCommand_FindInvalidDirs") };

		If ($InvalidDirs -ne $null) {

			If (($InvalidDirs.Count) -gt 0) {

				# Invalid Dirnames exist - Update invalid into correct & Delete invalid
				$rsync_to = $AbsPath_CorrectDir;

				$i=0;
				ForEach ($EachInvalidDir In ($InvalidDirs.Split("`n")).GetEnumerator()) {
					$i++;
					$EachInvalidDir = $EachInvalidDir.Replace("`r","");
					$EachInvalidDir_Rel = $EachInvalidDir.Split("/")[-1];
					$rsync_from = (($EachInvalidDir_Rel)+("_")+($i))

					Set-Location ($WorkingTree_WindowsPath);
					
					$UseGitEmail = ("programmers@boneal.net");
					$UseGitUser = ((whoami).Split('\'))[-1];
					
					git config user.email ($UseGitEmail);
					git config user.name ($UseGitUser);

					$LinuxCommand_RSyncStep1 = "mv '$EachInvalidDir_Rel' '$rsync_from'; git add -A && git commit -m 'Starting Duped-Dir-Hotfix';";
					$LinuxCommand_RSyncStep2 = "rsync -a '$rsync_from/' '$rsync_to/'; rm -rf '$rsync_from/'; git add -A && git commit -m 'Finishing Duped-Dir-Hotfix';";

					If ($CanUse_sh -eq $true) {
						sh -c "$LinuxCommand_RSyncStep1";
						sh -c "$LinuxCommand_RSyncStep2";
					} Else {
						bash -c "$LinuxCommand_RSyncStep1";
						bash -c "$LinuxCommand_RSyncStep2";
					};
					$i++;
				}

			}
		}

	}

	Return $WorkingTree_UnixPath;

}

Export-ModuleMember -Function "GitCloneRepo";

# Import-Module ("GitCloneRepo/GitCloneRepo.psm1");

# Get-Module "GitCloneRepo";
