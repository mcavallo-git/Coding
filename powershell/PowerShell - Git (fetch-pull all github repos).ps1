#
# Script to Fetch & Pull all Repositories in the [ %USERPROFILE%\Documents\GitHub ] Directory 
#

$CommandName="git";

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

ForEach ($EachRepoDirBasename in ((Get-ChildItem -Directory -Name -Path ($GitHubReposParentDir)).GetEnumerator())) {
	
	$EachRepoDirFullpath = (($GitHubReposParentDir)+("\")+($EachRepoDirBasename));

	Set-Location -Path $EachRepoDirFullpath;

	$CheckGitStatus = (git status);

	If ($CheckGitStatus -ne $null) {

		$RepoFullpathsArr += $EachRepoDirBasename;

	}

}

If ($RepoFullpathsArr.Length -gt 0) {

	# Do Each Fetch-Pull separately, from the base of their working-tree

	$VerbiageRepositoryCount = If(RepoFullpathsArr.Length -eq 1) { "repository" } Else { "repositories" };
	
	Write-Host (("Found ")+($RepoFullpathsArr.Length)+(" git ")+($VerbiageRepositoryCount)+(" in directory `"$GitHubReposParentDir`":"));

	ForEach ($EachRepoDirBasename in $RepoFullpathsArr) {

		$EachRepoDirFullpath = (($GitHubReposParentDir)+("\")+($EachRepoDirBasename));

		Set-Location -Path $EachRepoDirFullpath;

		Write-Host "Fetching updates for git-repo `"$EachRepoDirBasename`"";
		git fetch;

		Write-Host "Pulling updates for git-repo `"$EachRepoDirBasename`"";
		git pull;

	}

} Else {

	Write-Host "No git repositories found in: `"$GitHubReposParentDir`"";

}

Write-Host -NoNewLine "Press any key to continue...";
$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
