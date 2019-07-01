#
#	GitSyncAll
#		Performs batch-actions on every sub-git-directories found within a given directory
#
function GitSyncAll {
	#
	# Module to Fetch & Pull all Repositories in a given directory [ %USERPROFILE%\Documents\GitHub ] Directory 
	#
	Param(

		[String]$Directory = ("${HOME}"),

		[Int]$Depth = 3,

		[ValidateSet("Fetch","Pull")]
		[String]$Action = "Pull",

		[ValidateSet("SSH","HTTPS")]
		[String]$SetOriginNotation = "SSH",

		[Switch]$Quiet

	
	)
	
	$Depth_GitConfigFile = ($Depth+2);

	$CommandName="git";

	$Dashes = "`n--------------------------------`n";

	If((Get-Command $CommandName -ErrorAction "SilentlyContinue") -eq $null) {
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

	### Only go to a given depth to find Git-Repo directories within the ${Directory}
	Write-Host "Searching `"${Directory}`" for git repositories...";
	$RepoFullpathsArr = (Get-ChildItem -Path "${Directory}" -Filter "config" -Depth (${Depth_GitConfigFile}) -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Directory.Name -Eq ".git"} | Foreach-Object { $_.Directory.Parent; } );

	$ReposFetched = @();
	$ReposPulled = @();

	If ($RepoFullpathsArr.Length -gt 0) {

		# Do Each Fetch-Pull separately, from the base of their working-tree

		$VerbiageRepositoryCount = If($RepoFullpathsArr.Length -eq 1) { "repository" } Else { "repositories" };
		
		Write-Host (("`nFound ")+($RepoFullpathsArr.Length)+(" ")+($VerbiageRepositoryCount)+(":"));
		Write-Host "";
		$RepoFullpathsArr.FullName | Format-List;
		Write-Host "`n";

		ForEach ($EachRepoDir in $RepoFullpathsArr) {

			$EachRepoDirBasename = (${EachRepoDir}.Name);
			$EachRepoDirFullpath = (${EachRepoDir}.FullName);

			If ($SetOriginNotation -eq "SSH") {

				$GitConfig = @{};

				$GitConfig.Path = ("${EachRepoDirFullpath}/.git/config");

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

			Set-Location -Path ${EachRepoDirFullpath};
			$GitSyncPadding = ((${EachRepoDirBasename}.Length)+(2));

			If ($Action -eq "Pull") {
				# Fetch + pull repositories
				Write-Host -NoNewline "Pulling updates for repository `"";
				Write-Host -NoNewline "${EachRepoDirBasename}" -ForegroundColor Magenta;
				Write-Host -NoNewline (("`"...") + ((" ").PadRight((${GitSyncPadding}-${EachRepoDirBasename}.Length), ' ')));
				$fetcher = (git fetch);
				$ReposFetched += ${EachRepoDirBasename};
				$puller = (git pull);
				$ReposPulled += ${EachRepoDirBasename};
				If ($puller -is [String]) {
					Write-Host ($puller) -ForegroundColor Green;
				} Else {
					ForEach ($EachLine In $puller) {
						Write-Host ($EachLine);
					}
				}
				# Write-Host "Fetch + pull complete." -ForegroundColor Green;
				
			} ElseIf ($Action -eq "Fetch") {
				# Fetch updates, only (no pull)
				Write-Host -NoNewline "Fetching updates for repository `"";
				Write-Host -NoNewline "${EachRepoDirBasename}" -ForegroundColor Magenta;
				Write-Host -NoNewline (("`"...") + ((" ").PadRight((${GitSyncPadding}-${EachRepoDirBasename}.Length), ' ')));
				$fetcher = (git fetch);
				$ReposFetched += ${EachRepoDirBasename};
				Write-Host "Fetch complete." -ForegroundColor Green;

			} Else {
				Write-Host "Unhandled Value for Parameter `$Action: `"${Action}`" " -BackgroundColor "Black" -ForegroundColor "Red";

			}
		}
	
		Write-Host "`n`n  All Repositories ${Action}ed" -ForegroundColor "Green";

	} Else {
		Write-Host "No git repositories found in: `"${Directory}`"`n" -ForegroundColor "Magenta";
	}


	# ------------------------------------------------------------
	#	### "Press any key to continue..."
	#
	# Write-Host -NoNewLine "`n`n  Press any key to continue...`n`n" -BackgroundColor "Black" -ForegroundColor "Yellow";
	# $KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	#
	# ------------------------------------------------------------
	#	### "Press any key to close this window..."
	#
	# Write-Host -NoNewLine "`n`n  Press any key to close this window...`n`n" -BackgroundColor "Black" -ForegroundColor "Yellow";
	# $KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	#
	# ------------------------------------------------------------
	# ### "Press 'Escape' to close this window..."
	#
	# Write-Host -NoNewLine "`n`n  Press 'Escape' to close this window...`n`n" -BackgroundColor "Black" -ForegroundColor "Yellow";
	# $KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	# While ($KeyPress.VirtualKeyCode -ne 27) {
	# 	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	# }
	#
	# ------------------------------------------------------------
	# ### "Closing in 3...2...1..."
	Write-Host -NoNewLine "  Closing in ";
	$WaitSeconds = 3;
	While ($WaitSeconds -gt 0) {
		Write-Host -NoNewLine ($WaitSeconds);
		$MillisecondsRemaining = 1000;
		While ($MillisecondsRemaining -gt 0) {
			$WaitMilliseconds = 250;
			$MillisecondsRemaining -= $WaitMilliseconds;
			[Threading.Thread]::Sleep($WaitMilliseconds);
			Write-Host -NoNewLine ".";
		}
		$WaitSeconds--;
	}
	#
	# ------------------------------------------------------------
	#
	Return;
}
Export-ModuleMember -Function "GitSyncAll";

#
#	Citation(s)
#		
#		Icon file "GitSyncAll.ico" thanks-to:  https://www.iconarchive.com/download/i103479/paomedia/small-n-flat/sign-sync.ico
#
