################################################################################
##  File:  PowerShell - install_chromium.ps1
##  Desc:  Install Chromium
################################################################################

# Set working directory
SV WorkingDir ((GCI env:\TEMP).Value);

# Get the latest version of Chromium
[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; # Force TLS1.2 (otherwise often throws error in Win2016)
$ProgressPreference='SilentlyContinue'; # Hide Invoke-WebRequest's progress bar
$ResponseObj=(Invoke-WebRequest -UseBasicParsing -Uri ("https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Win_x64%2FLAST_CHANGE?alt=media"));
$ChromiumVersion=(${ResponseObj}.Content);
Write-Host "Info:  Chromium - latest available version = [ ${ChromiumVersion} ]";

# Download chromium installer
$DownloadUrl="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Win_x64%2F${ChromiumVersion}%2Fmini_installer.exe?alt=media";
Write-Host "Info:  Downloading chromium installer from url [ ${DownloadUrl} ]...";
(New-Object System.Net.WebClient).DownloadFile(("${DownloadUrl}"), (((GV WorkingDir).Value)+(write \mini_installer.exe)) );

# Install Chromium
Write-Host "Info:  Installing chromium v${ChromiumVersion}";

# Start-Process -Filepath (((GV WorkingDir).Value)+(write \mini_installer.exe));
& (((GV WorkingDir).Value)+(write \mini_installer.exe));

# Wait for installation to finish
$Process2Monitor=([IO.Path]::GetFileNameWithoutExtension("mini_installer.exe"));
Do {
  SV ProcessesFound (Get-Process | Where-Object { ((GV Process2Monitor).Value) -contains (((GV _).Value).Name); } | Select-Object -ExpandProperty Name);
  If ((GV ProcessesFound).Value) {
    ((write Still` running:` )+(((GV ProcessesFound).Value) -join (write `,` ))) | Write-Host;
    Start-Sleep -Seconds 2;
  } Else {
    Remove-Item -Verbose -Path (((GV WorkingDir).Value)+(write \mini_installer.exe)) -ErrorAction SilentlyContinue;
  }
} Until (!((GV ProcessesFound).Value));
Start-Sleep -Seconds 3;

$ChromePath = "${env:LOCALAPPDATA}\Chromium\Application\";

Write-Host "Info:  Calling [ Get-ChildItem `"${ChromePath}`"; ]...";
Get-ChildItem "${ChromePath}";

Write-Host "Info:  Prepending to PATH (env var):  [ ${ChromePath} ]";
Write-Host "##vso[task.prependpath]$ChromePath";


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.chromium.org  |  "Download Chromium"  |  https://www.chromium.org/getting-involved/download-chromium/
#
# ------------------------------------------------------------