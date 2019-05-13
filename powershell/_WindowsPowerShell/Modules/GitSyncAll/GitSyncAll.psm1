#
#	Example Call:
#
#		GitSyncAll -Directory "$HOME/git"
#
#
function GitSyncAll {
	#
	# Module to Fetch & Pull all Repositories in a given directory [ %USERPROFILE%\Documents\GitHub ] Directory 
	#
	Param(

		[String]$Directory = (($HOME)+("/Documents/GitHub")),

		[Boolean]$SSH_UrlNotation = $true
	
	)
		
	$CommandName="git";

	$Dashes = "`n--------------------------------`n";

	If((Get-Command $CommandName -ErrorAction SilentlyContinue) -eq $null) {

		## Fail - Command [ $CommandName ] not found Locally

		$OnErrorShowUrl="https://git-scm.com/downloads";

		Write-Host (("Fail - Command [ ")+($CommandName)+(" ] not found locally")) -ForegroundColor red;

		Write-Host (("Info - For troubleshooting, download references, etc. please visit Url: ")+($OnErrorShowUrl)) -ForegroundColor green;
		Start ($OnErrorShowUrl);
		Write-Host -NoNewLine "Press any key to close this window...";
		$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
		Exit 1;

	}

	## Command [ $CommandName ] Exists Locally

	$GitHubReposParentDir = (($Home)+("\Documents\GitHub"));

	$RepoFullpathsArr = @();

	ForEach ($EachRepoDirBasename in ((Get-ChildItem -Directory -Name -Path ($GitHubReposParentDir)).GetEnumerator())) {
		
		$EachRepoDirFullpath = (($GitHubReposParentDir)+("\")+($EachRepoDirBasename));

		Set-Location -Path $EachRepoDirFullpath;

		If (Test-Path -PathType Container -Path (($EachRepoDirFullpath)+("/.git"))) {

			If (Test-Path -PathType Leaf -Path (($EachRepoDirFullpath)+("/.git/config"))) {

				$GitStatus = (git status);

				If ($GitStatus -ne $null) {

					$RepoFullpathsArr += $EachRepoDirBasename;

				}

			}

		}

	}

	$ReposUpdated = @();

	If ($RepoFullpathsArr.Length -gt 0) {

		# Do Each Fetch-Pull separately, from the base of their working-tree

		$VerbiageRepositoryCount = If($RepoFullpathsArr.Length -eq 1) { "repository" } Else { "repositories" };
		
		Write-Host (("`nFound ")+($RepoFullpathsArr.Length)+(" git ")+($VerbiageRepositoryCount)+(" in `"$GitHubReposParentDir`"`n"));

		ForEach ($EachRepoDirBasename in $RepoFullpathsArr) {

			$EachRepoDirFullpath = (($GitHubReposParentDir)+("\")+($EachRepoDirBasename));

			If ($SSH_UrlNotation -eq $true) {

				$GitConfig = @{};

				$GitConfig.Path = (($EachRepoDirFullpath)+("/.git/config"));

				$GitConfig.Regex = @{};
				$GitConfig.Regex.HTTPS = '(\s*url\ =\ )(https\:\/\/)(github\.com)(\/)(.+)';
				$GitConfig.Regex.SSH = '$1git@$3:$5';

				$GitConfig.Content = @{};
				$GitConfig.Content.HTTPS = Get-Content -Path ($GitConfig.Path);
				$GitConfig.Content.FoundUrlHTTPS = If (($GitConfig.Content.HTTPS -match ($GitConfig.Regex.HTTPS)) -ne $null) { $true } Else { $false };

				# Convert any HTTPS Urls found in .git/config to SSH-notation
				If ($GitConfig.Content.FoundUrlHTTPS -eq $true) {
					$GitConfig.Content.SSH = ($GitConfig.Content.HTTPS -replace ($GitConfig.Regex.HTTPS),($GitConfig.Regex.SSH));
					Set-Content -Path ($GitConfig.Path) -Value ($GitConfig.Content.SSH);
				}
				
			}


			Set-Location -Path $EachRepoDirFullpath;

			Write-Host -NoNewline "Fetching/Pulling Repo ";
			Write-Host -NoNewline "$EachRepoDirBasename" -ForegroundColor Magenta;
			Write-Host -NoNewline ((" ...") + ((" ").PadRight((35-$EachRepoDirBasename.Length), ' ')));

			$fetcher = (git fetch);

			$puller = (git pull);

			If ($SSH_UrlNotation -eq $true) {

				# Revert Git-Config file's Urls to HTTPS notation
				# If ($GitConfig.Content.FoundUrlHTTPS -eq $true) {
				# 	Set-Content -Path ($GitConfig.Path) -Value ($GitConfig.Content.HTTPS);
				# }
				
			}

			If ($puller -is [String]) {

				Write-Host ($puller) -ForegroundColor green;

			} Else {
				
				ForEach ($EachLine In $puller) {
					Write-Host ($EachLine) -ForegroundColor Yellow;
				}

				$ReposUpdated += $EachRepoDirBasename;

			}
			
		}

		Write-Host "";

	} Else {

		Write-Host "No git repositories found in: `"$GitHubReposParentDir`"`n" -ForegroundColor Magenta;

	}

	Write-Host "`n`n  All Repositories Synced  `n`n" -ForegroundColor green;

	Write-Host -NoNewLine "  Closing in ";
	
	$SecondsTilAutoExit=30;

	While ($SecondsTilAutoExit -gt 0) {
				
		Write-Host -NoNewLine ($SecondsTilAutoExit);

		$MillisecondsRemaining = 1000;

		While ($MillisecondsRemaining -gt 0) {

			$WaitMilliseconds = 250;

			$MillisecondsRemaining -= $WaitMilliseconds;

			[Threading.Thread]::Sleep($WaitMilliseconds);

			Write-Host -NoNewLine ".";
		}

		# Write-Host -NoNewLine "`n";

		$SecondsTilAutoExit--;

	}

}

Export-ModuleMember -Function "GitSyncAll";

#
#	Citation(s)
#		
#		Icon file "GitSyncAll.ico" thanks-to:  https://www.iconarchive.com/download/i103479/paomedia/small-n-flat/sign-sync.ico
#
