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

		[Int]$ConfigSearchDepth = 3,

		[String]$Action = "Pull",
		[Switch]$Fetch,
		[Switch]$Pull,

		[ValidateSet("SSH","HTTPS")]
		[String]$SetOriginNotation = "SSH",

		[Switch]$Quiet
	
	)

	$CommandName="git";

	$Dashes = "`n--------------------------------`n";

	If((Get-Command $CommandName -ErrorAction "SilentlyContinue") -eq $Null) {
		## Fail - Command [ $CommandName ] not found Locally
		$OnErrorShowUrl="https://git-scm.com/downloads";
		Write-Host (("$($MyInvocation.MyCommand.Name) - Fail: Command [ ")+($CommandName)+(" ] not found locally")) -ForegroundColor Yellow;
		Write-Host (("$($MyInvocation.MyCommand.Name) - Info: For troubleshooting, download references, etc. please visit Url: ")+($OnErrorShowUrl)) -ForegroundColor Green;
		Start ($OnErrorShowUrl);
		Write-Host -NoNewLine "$($MyInvocation.MyCommand.Name) - Press any key to close this window...";
		$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
		Exit 1;
	}
	## Command [ $CommandName ] Exists Locally

	### Only go to a given depth to find Git-Repo directories within the ${Directory}
	Write-Host "$($MyInvocation.MyCommand.Name) - Task: Searching `"${Directory}`" for git repositories...";
	$RepoFullpathsArr = (Get-ChildItem -Path "${Directory}" -Filter "config" -Depth (${ConfigSearchDepth}+2) -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Directory.Name -Eq ".git"} | Foreach-Object { $_.Directory.Parent; } );

	$ReposFetched = @();
	$ReposPulled = @();

	If ($PSBoundParameters.ContainsKey("Action") -Eq $False) {
		$Action ="Fetch";
	}

	If ($RepoFullpathsArr.Length -gt 0) {

		# Do Each Fetch-Pull separately, from the base of their working-tree

		$VerbiageRepositoryCount = If($RepoFullpathsArr.Length -eq 1) { "repository" } Else { "repositories" };
		
		Write-Host "`n$($MyInvocation.MyCommand.Name) - Info: Found $($RepoFullpathsArr.Length) $($VerbiageRepositoryCount):`n";
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
				$GitConfig.Content.FoundUrlHTTPS = If (($GitConfig.Content.HTTPS -match ($GitConfig.Regex.HTTPS)) -ne $Null) { $true } Else { $false };

				# Convert any HTTPS Urls found in .git/config to SSH-notation
				If ($GitConfig.Content.FoundUrlHTTPS -eq $true) {
					$GitConfig.Content.SSH = ($GitConfig.Content.HTTPS -replace ($GitConfig.Regex.HTTPS),($GitConfig.Regex.SSH));
					Set-Content -Path ($GitConfig.Path) -Value ($GitConfig.Content.SSH);
				}
				
			}

			Set-Location -Path ${EachRepoDirFullpath};
			$GitSyncPadding = ((${EachRepoDirBasename}.Length)+(2));

			If (($Action -eq "Pull") -Or ($PSBoundParameters.ContainsKey("Pull") -Eq $True)) {

				# Fetch + pull repositories
				Write-Host -NoNewline "$($MyInvocation.MyCommand.Name) - Task: Pulling updates for repository `"";
				Write-Host -NoNewline "${EachRepoDirBasename}" -ForegroundColor Yellow;
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
				# Write-Host "$($MyInvocation.MyCommand.Name) - Fetch + pull complete." -ForegroundColor Green;
				
			} ElseIf (($Action -eq "Fetch") -Or ($PSBoundParameters.ContainsKey("Fetch") -Eq $True)) {


				# Fetch updates, only (no pull)
				Write-Host -NoNewline "$($MyInvocation.MyCommand.Name) - Task: Fetching updates for repository `"";
				Write-Host -NoNewline "${EachRepoDirBasename}" -ForegroundColor Yellow;
				Write-Host -NoNewline (("`"...") + ((" ").PadRight((${GitSyncPadding}-${EachRepoDirBasename}.Length), ' ')));
				$fetcher = (git fetch);
				$ReposFetched += ${EachRepoDirBasename};
				Write-Host "Fetch complete." -ForegroundColor Green;

			} Else {
				Write-Host "Unhandled Value for Parameter `$Action: `"$($Action)`" " -ForegroundColor Yellow;

			}
		}
	
		Write-Host "`n`n$($MyInvocation.MyCommand.Name) - All Repositories $($Action)ed" -ForegroundColor Green;

	} Else {
		Write-Host "$($MyInvocation.MyCommand.Name) - No git repositories found in `"$($Directory)`"`n" -ForegroundColor Yellow;
	}


	# ------------------------------------------------------------
	#	### "Press any key to continue..."
	#
	# Write-Host -NoNewLine "`n`n$($MyInvocation.MyCommand.Name) - Press any key to continue...`n`n" -ForegroundColor Yellow;
	# $KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	#
	# ------------------------------------------------------------
	#	### "Press any key to close this window..."
	#
	# Write-Host -NoNewLine "`n`n$($MyInvocation.MyCommand.Name) - Press any key to close this window...`n`n" -ForegroundColor Yellow;
	# $KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	#
	# ------------------------------------------------------------
	# ### "Press 'Escape' to close this window..."
	#
	# Write-Host -NoNewLine "`n`n$($MyInvocation.MyCommand.Name) - Press 'Escape' to close this window...`n`n" -ForegroundColor Yellow;
	# $KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	# While ($KeyPress.VirtualKeyCode -ne 27) {
	# 	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	# }
	#
	# ------------------------------------------------------------
	# ### "Closing in 3...2...1..."
	Write-Host -NoNewLine "$($MyInvocation.MyCommand.Name) - Closing in ";
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
