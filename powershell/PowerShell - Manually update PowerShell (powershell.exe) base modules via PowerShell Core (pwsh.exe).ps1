# ------------------------------------------------------------
# PowerShell - Manually update PowerShell (powershell.exe) base modules via PowerShell Core (pwsh.exe)
# ------------------------------------------------------------


If ($True) {
  #
  # Update PowerShell Module 'PackageManagement' - https://www.powershellgallery.com/packages/PackageManagement/1.4.8.1
  #
  $DownloadDir="C:\ISO\nupkg";
  $NupkgName="PackageManagement";
  $NupkgVersion="1.4.8.1";
  # $NupkgVersion="1.4.4";
  $NupkgBasePath="${DownloadDir}\${NupkgName}";
  # Ensure the download dir exists
  If (($False) -Eq (Test-Path -PathType "Container" -Path ("${DownloadDir}"))) {
    New-Item -ItemType "Directory" -Path ("${DownloadDir}") | Out-Null;
  }
  # Download the nupkg
  [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; # Force TLS1.2
  $ProgressPreference='SilentlyContinue'; # Hide Invoke-WebRequest's progress bar
  Invoke-WebRequest -Uri ("https://www.powershellgallery.com/api/v2/package/${NupkgName}/${NupkgVersion}") -OutFile ("${NupkgBasePath}.${NupkgVersion}.nupkg");
  # Rename .nupkg to .zip
  Move-Item -Path ("${NupkgBasePath}.${NupkgVersion}.nupkg") -Destination ("${NupkgBasePath}.zip") -Force;
  # Cover both 32- and 64-bit PowerShell module directories
  @("${Env:ProgramFiles}","${Env:ProgramFiles(x86)}") | ForEach-Object {
    $Each_ModulesDir = "${_}\WindowsPowerShell\Modules";
    # Relocate existing package (can't remove - blocked by OS)
    If (($True) -Eq (Test-Path -PathType "Container" -Path ("${Each_ModulesDir}\${NupkgName}"))) {
      Move-Item -Path ("${Each_ModulesDir}\${NupkgName}") -Destination ("${env:TEMP}\${NupkgName}.$(Get-Date -Format 'yyyyMMddTHHmmss.ffffffzz')") -Force -Confirm:$False;
      Start-Sleep -Milliseconds 100;
    }
    New-Item -ItemType "Directory" -Path ("${Each_ModulesDir}\${NupkgName}\") | Out-Null;
    # Unpack the archive
    Expand-Archive -LiteralPath ("${NupkgBasePath}.zip") -DestinationPath ("${Each_ModulesDir}\${NupkgName}\");
    # Cleanup/Remove the already-unpacked archive
    Remove-Item "${NupkgBasePath}.zip" -Force;
  }
}


# ------------------------------


If ($True) {
  #
  # Update PowerShell Module 'PowerShellGet' - https://www.powershellgallery.com/packages/PowerShellGet
  #
  $DownloadDir="C:\ISO\nupkg";
  $NupkgName="PowerShellGet";
  $NupkgVersion="2.2.5";
  # $NupkgVersion="1.1.0.0";
  $NupkgBasePath="${DownloadDir}\${NupkgName}";
  # Ensure the download dir exists
  If (($False) -Eq (Test-Path -PathType "Container" -Path ("${DownloadDir}"))) {
    New-Item -ItemType "Directory" -Path ("${DownloadDir}") | Out-Null;
  }
  # Download the nupkg
  [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; # Force TLS1.2
  $ProgressPreference='SilentlyContinue'; # Hide Invoke-WebRequest's progress bar
  Invoke-WebRequest -Uri ("https://www.powershellgallery.com/api/v2/package/${NupkgName}/${NupkgVersion}") -OutFile ("${NupkgBasePath}.${NupkgVersion}.nupkg");
  # Rename .nupkg to .zip
  Move-Item -Path ("${NupkgBasePath}.${NupkgVersion}.nupkg") -Destination ("${NupkgBasePath}.zip") -Force;
  # Cover both 32- and 64-bit PowerShell module directories
  @("${Env:ProgramFiles}","${Env:ProgramFiles(x86)}") | ForEach-Object {
    $Each_ModulesDir = "${_}\WindowsPowerShell\Modules";
    # Relocate existing package (can't remove - blocked by OS)
    If (($True) -Eq (Test-Path -PathType "Container" -Path ("${Each_ModulesDir}\${NupkgName}"))) {
      Move-Item -Path ("${Each_ModulesDir}\${NupkgName}") -Destination ("${env:TEMP}\${NupkgName}.$(Get-Date -Format 'yyyyMMddTHHmmss.ffffffzz')") -Force -Confirm:$False;
      Start-Sleep -Milliseconds 100;
    }
    New-Item -ItemType "Directory" -Path ("${Each_ModulesDir}\${NupkgName}\") | Out-Null;
    # Unpack the archive
    Expand-Archive -LiteralPath ("${NupkgBasePath}.zip") -DestinationPath ("${Each_ModulesDir}\${NupkgName}\");
    # Cleanup/Remove the already-unpacked archive
    Remove-Item "${NupkgBasePath}.zip" -Force;
  }
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "continuous integration - Open or extract files nupkg with Powershell - Stack Overflow"  |  https://stackoverflow.com/a/54175268
#
#   stackoverflow.com  |  "visual studio - How do I install a NuGet package .nupkg file locally? - Stack Overflow"  |  https://stackoverflow.com/a/35753968
#
# ------------------------------------------------------------