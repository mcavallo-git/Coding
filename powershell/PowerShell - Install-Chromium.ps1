# ------------------------------
#
# PowerShell - Install Google Chromium (open-source web browser)
#
# ------------------------------

If ($True) {

  # ------------------------------------------------------------
  #
  # Determine the latest version of Chromium
  #
  [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; # Force TLS1.2 (otherwise often throws error in Win2016)
  $ProgressPreference='SilentlyContinue'; # Hide Invoke-WebRequest's progress bar
  $ResponseObj=(Invoke-WebRequest -UseBasicParsing -Uri ("https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Win_x64%2FLAST_CHANGE?alt=media"));
  $ChromiumVersion=(${ResponseObj}.Content);
  Write-Host "##[debug] Info:  Chromium - latest available version = [ ${ChromiumVersion} ]";

  $Process2Monitor=([IO.Path]::GetFileNameWithoutExtension("mini_installer.exe"));

  # ------------------------------
  #
  # Download Chromium installer
  #
  $DownloadUrl="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Win_x64%2F${ChromiumVersion}%2Fmini_installer.exe?alt=media";
  Write-Host "##[debug] Info:  Downloading chromium installer from url [ ${DownloadUrl} ]...";
  (New-Object System.Net.WebClient).DownloadFile(("${DownloadUrl}"), ("${env:TEMP}\mini_installer.exe"));

  # ------------------------------
  #
  # Install Chromium
  #
  Write-Host "##[debug] Info:  Installing chromium v${ChromiumVersion}"
  & "${env:TEMP}\mini_installer.exe";
  # Start-Process -Filepath ("${env:TEMP}\mini_installer.exe");

  # ------------------------------
  #
  # Wait for installation to finish
  #
  Do {
    $ProcessesFound = (Get-Process | Select-Object -ExpandProperty "Name" -Unique | Where-Object { ${Process2Monitor} -contains "${_}"; } | Select-Object -First 1);
    If (${ProcessesFound}) {
      Write-Host "##[debug] Waiting for process to complete:  [ ${Process2Monitor} ]...";
      Start-Sleep -Seconds 2;
    } Else {
      Remove-Item -Verbose -Path ("${env:TEMP}\mini_installer.exe") -ErrorAction SilentlyContinue;
    }
  } Until (-Not (${ProcessesFound}));
  Start-Sleep -Seconds 3;

  # ------------------------------
  #
  # Show resultant installation directory
  #
  $ChromePath = "${env:LOCALAPPDATA}\Chromium\Application\";
  Write-Host "##[debug] Info:  Calling [ Get-ChildItem `"${ChromePath}`"; ]...";
  Get-ChildItem "${ChromePath}";

  # ------------------------------
  #
  # Prepend chrome's executable directory to the system PATH
  #
  Write-Host "##[debug] Info:  Prepending to directory to system PATH:  [ ${ChromePath} ]";
  Write-Host "##vso[task.prependpath]$ChromePath";

  # ------------------------------

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.chromium.org  |  "Download Chromium"  |  https://www.chromium.org/getting-involved/download-chromium/
#
# ------------------------------------------------------------