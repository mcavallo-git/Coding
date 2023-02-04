# ------------------------------------------------------------
#
# PowerShell - GitSyncAll
#   |
#   |--> Description:
#   |      Module to Fetch and/or Pull all Git repositories foudn within the [ %USERPROFILE%\Documents\GitHub ] user directory
#   |
#   |--> Example Call(s):
#          GitSyncAll -Fetch
#          GitSyncAll -Pull
#
function GitSyncAll {
  Param(

    [String]$Directory = ("${env:REPOS_DIR}"),
    [String]$FallbackDirectory = ("${HOME}"),

    [Int]$ConfigSearchDepth = 3,

    [Switch]$Fetch,
    [Switch]$Pull,

    [ValidateSet("SSH","HTTPS")]
    [String]$SetOriginNotation = "SSH",

    [Switch]$Quiet
  
  )
  If ($False) { # RUN THIS SCRIPT REMOTELY:

    $ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol;  [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy 'RemoteSigned' -Scope 'CurrentUser' -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/GitSyncAll/GitSyncAll.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'GitSyncAll' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\GitSyncAll\GitSyncAll.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak; GitSyncAll -Pull;

  }

  $CommandName="git";

  $Dashes = "`n--------------------------------`n";

  If($null -eq (Get-Command $CommandName -ErrorAction "SilentlyContinue")) {
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
  If ([String]::IsNullOrEmpty("${Directory}")) {
    Write-Host "$($MyInvocation.MyCommand.Name) - Info: Using fallback directory `"${FallbackDirectory}`"";
    $Directory = "${FallbackDirectory}";
  }
  Write-Host "$($MyInvocation.MyCommand.Name) - Task: Searching `"${Directory}`" for git repositories...";
  $RepoFullpathsArr = (Get-ChildItem -Path "${Directory}" -Filter "config" -Depth (${ConfigSearchDepth}+2) -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Directory.Name -Eq ".git"} | Foreach-Object { $_.Directory.Parent; } );

  $ReposFetched = @();
  $ReposPulled = @();

  $Action = "";
  If ($PSBoundParameters.ContainsKey("Pull") -Eq $True) {
    $Action = "Pull";
  } ElseIf ($PSBoundParameters.ContainsKey("Fetch") -Eq $True) {
    $Action = "Fetch";
  } Else {
    # Default Action
    $Action = "Fetch";
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
        $GitConfig.Regex.SSHCommand = '^\s*sshcommand = (.+)';

        $GitConfig.Content = @{};
        $GitConfig.Content.Full = Get-Content -Path ($GitConfig.Path);
        $GitConfig.Content.RegexTest_HTTPS = If (($GitConfig.Content.Full -match ($GitConfig.Regex.HTTPS)) -ne $Null) { $True } Else { $False };
        $GitConfig.Content.RegexTest_SSHCommand = If (($GitConfig.Content.Full -match ($GitConfig.Regex.SSHCommand)) -ne $Null) { $True } Else { $False };

        # If an "ssh_command" is instantiated (in .git/config), convert any HTTPS URLs to SSH URLs
        If ($GitConfig.Content.RegexTest_SSHCommand -eq $True) {
          If ($GitConfig.Content.RegexTest_HTTPS -eq $True) {
            $GitConfig.Content.SSH = ($GitConfig.Content.Full -replace ($GitConfig.Regex.HTTPS),($GitConfig.Regex.SSH));
            Set-Content -Path ($GitConfig.Path) -Value ($GitConfig.Content.SSH);
          }
        }
        
      }

      Set-Location -Path ${EachRepoDirFullpath};
      $GitSyncPadding = ((${EachRepoDirBasename}.Length)+(2));
      If ("${Action}" -Eq "Pull") {

        Write-Host -NoNewline "$($MyInvocation.MyCommand.Name) - Task: Pulling updates for repository `"";
        Write-Host -NoNewline "${EachRepoDirBasename}" -ForegroundColor Yellow;
        Write-Host -NoNewline (("`"...") + ((" ").PadRight((${GitSyncPadding}-${EachRepoDirBasename}.Length), ' ')));
        # Fetch Repository
        $fetcher = (git fetch);
        $ReposFetched += ${EachRepoDirBasename};
        # Pull Repository 
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
        
      } ElseIf ("${Action}" -Eq "Fetch") {

        # Fetch updates, only (no pull)
        Write-Host -NoNewline "$($MyInvocation.MyCommand.Name) - Task: Fetching updates for repository `"";
        Write-Host -NoNewline "${EachRepoDirBasename}" -ForegroundColor Yellow;
        Write-Host -NoNewline (("`"...") + ((" ").PadRight((${GitSyncPadding}-${EachRepoDirBasename}.Length), ' ')));
        $fetcher = (git fetch);
        $ReposFetched += ${EachRepoDirBasename};
        Write-Host "Fetch complete." -ForegroundColor Green;

      } Else {
        Write-Host "Unhandled Value for Parameter `${Action}: `"${Action}`" " -ForegroundColor Yellow;

      }

      # Compress the Repo's database
      Set-Location -Path ${EachRepoDirFullpath};
      # git gc;
      git gc --auto;

    }
  
    Write-Host "`n`n$($MyInvocation.MyCommand.Name) - All Repositories ${Action}ed" -ForegroundColor Green;

  } Else {
    Write-Host "$($MyInvocation.MyCommand.Name) - No git repositories found in `"${Directory}`"`n" -ForegroundColor Yellow;
  }


  # ------------------------------------------------------------
  # ### "Press any key to continue..."
  #
  # Write-Host -NoNewLine "`n`n$($MyInvocation.MyCommand.Name) - Press any key to continue...`n`n" -ForegroundColor Yellow;
  # $KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
  #
  # ------------------------------------------------------------
  # ### "Press any key to close this window..."
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
  #   $KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
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

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
  Export-ModuleMember -Function "GitSyncAll";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   Icon file "GitSyncAll.ico" (should be next to this file) thanks-to:  https://www.iconarchive.com/download/i103479/paomedia/small-n-flat/sign-sync.ico
#
# ------------------------------------------------------------