#
# Script to Fetch & Pull all Repositories in the [ %USERPROFILE%\Documents\GitHub ] Directory 
#

$CommandName="git";

# $Revertable_ErrorActionPreference=$ErrorActionPreference;
# $ErrorActionPreference='SilentlyContinue';
# 	$GetCommand = (Get-Command $CommandName);
# $ErrorActionPreference=$Revertable_ErrorActionPreference;

If((Get-Command $CommandName -ErrorAction SilentlyContinue) -eq $null) {

	## Fail - Command [ $CommandName ] not found Locally

	$OnErrorShowUrl="https://git-scm.com/downloads";

	Write-Host (("Fail - Command [ ")+($CommandName)+(" ] not found locally"));

	Write-Host (("Info - For troubleshooting, download references, etc. please visit Url: ")+($OnErrorShowUrl)); Start ($OnErrorShowUrl);

	Start-Sleep -Seconds 60;

	Exit 1;

}

## Command [ $CommandName ] Exists Locally

$GitHubReposParentDir = (($Home)+("\Documents\GitHub"));

$RepoFullpathsArr = @();

ForEach ($EachRepoDir in ((Get-ChildItem -Directory -Name -Path ($GitHubReposParentDir)).GetEnumerator())) {
	
	$CurrentRepoFullpath = (($GitHubReposParentDir)+("\")+($EachRepoDir));

	Set-Location -Path $CurrentRepoFullpath;

	$CheckGitStatus = (git status);

	If ($CheckGitStatus -ne $null) {

		$RepoFullpathsArr += $CurrentRepoFullpath;

	}

}

ForEach ($EachRepoFullpath in $RepoFullpathsArr) {

	Write-Host "Attempting to fetch/pull repo w/ local fullpath:  $EachRepoFullpath";

	Set-Location -Path $EachRepoFullpath;

	git fetch;

	git pull;

}