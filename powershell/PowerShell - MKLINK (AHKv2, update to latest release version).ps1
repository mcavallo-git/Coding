# ------------------------------------------------------------
# PowerShell - MKLINK (AHKv2, update to latest release version).ps1
# ------------------------------------------------------------

If ($True) {
  # ------------------------------
  # Get the latest version of AHKv2
  [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; # Force TLS1.2 (otherwise often throws error in Win2016)
  $ProgressPreference='SilentlyContinue'; # Hide Invoke-WebRequest's progress bar
  $ResponseObj=(Invoke-WebRequest -UseBasicParsing -Uri ("https://www.autohotkey.com/download/2.0/version.txt")); # Get the latest stable version of kubectl
  $LatestVersion=(${ResponseObj}.Content);
  Write-Host "Info:  AHKv2 - latest available version = [ ${LatestVersion} ]" -ForegroundColor "Green";
  # ------------------------------
  # Update MKLINKs
  $ParentDirectory="${env:ProgramFiles}\AutoHotkey-v2";
  $LatestVersionDirectory="${ParentDirectory}\AutoHotkey_${LatestVersion}";
  If (-Not (Test-Path -PathType "Container" -Path ("${ParentDirectory}"))) {
    Write-Host "ERROR - Directory not found: `"${ParentDirectory}`" " -ForegroundColor "Yellow";
  } ElseIf (-Not (Test-Path -PathType "Container" -Path ("${LatestVersionDirectory}"))) {
    Write-Host "ERROR - Directory not found: `"${LatestVersionDirectory}`" " -ForegroundColor "Yellow";
  } Else {
    Add-Type -AssemblyName Microsoft.VisualBasic;  # Enable recycle bin file/folder deletion (instead of permanent file/folder deletion)
    $RELPATHS_ARR = @("AutoHotkey.chm","AutoHotkey32.exe","AutoHotkey64.exe","Install.cmd","license.txt","UX","WindowSpy.ahk");
    ${RELPATHS_ARR} | ForEach-Object {
      Write-Host "------------------------------";
      $REDIRECT_FROM="${ParentDirectory}\${_}";
      $REDIRECT_TO="${LatestVersionDirectory}\${_}";
      If (Test-Path -Path ("${REDIRECT_TO}")) {
        # ------------------------------
        # Remove symlink/file (if exists)
        If (Test-Path -Path ("${REDIRECT_FROM}")) {
          If (Test-Path -PathType "Container" -Path ("${REDIRECT_FROM}")) {
            Write-Host "Deleting directory `"${REDIRECT_FROM}`"..." -ForegroundColor "DarkGray";
            [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory("${REDIRECT_FROM}",'OnlyErrorDialogs','SendToRecycleBin'); <# Delete directory to the Recycle Bin #>
          } Else {
            Write-Host "Deleting file `"${REDIRECT_FROM}`"..." -ForegroundColor "DarkGray";
            [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile("${REDIRECT_FROM}",'OnlyErrorDialogs','SendToRecycleBin'); <# Delete file to the Recycle Bin #>
          }
        }
        $MKLINK_ISDIR = If (Test-Path -PathType "Container" -Path ("${REDIRECT_TO}")) { Write-Output " /D"; } Else { Write-Output ""; };
        $CMD_CLI="MKLINK${MKLINK_ISDIR} `"${REDIRECT_FROM}`" `"${REDIRECT_TO}`"";
        Write-Host "Calling [ ${env:COMSPEC} /C ${CMD_CLI} ]..." -ForegroundColor "DarkGray";
        Start-Process -Filepath ("${env:COMSPEC}") -ArgumentList (@("/C", "${CMD_CLI}")) -NoNewWindow -Wait -PassThru -ErrorAction ("SilentlyContinue") | Out-Null;
      }
    };
  }
  # ------------------------------
}
