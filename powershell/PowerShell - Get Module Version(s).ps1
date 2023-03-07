If ($True) {
  #
  # PowerShell - Get Module Version(s)
  #
  Write-Host "##[debug] ------------------------------------------------------------";
  Write-Host "##[debug] Getting PowerShell Version...";
  Write-Host ((Write-Output PowerShell)+([String][Char]32)+(((GV PSVersionTable).Value).PSVersion.Major)+(Write-Output .)+(((GV PSVersionTable).Value).PSVersion.Minor))
  Write-Host "##[debug] ------------------------------------------------------------";
  Write-Host "##[debug] Calling [ Get-Module -ListAvailable PackageManagement, PowerShellGet | Select-Object -Property Name, Version, Path, RootModule | ... ; ]...";
  Get-Module -ListAvailable PackageManagement, PowerShellGet | Select-Object -Property Name, Version, Path, RootModule | ForEach-Object {
    Write-Host "##[debug] ------------------------------------------------------------";
    Write-Host "";
    $RootPath = "$(([IO.Path]::GetDirectoryName($_.Path)))\$($_.RootModule)";
    Write-Host -NoNewLine "RootPath   : ${RootPath}";
    $_ | Format-List;
  };
  Write-Host "##[debug] ------------------------------------------------------------";
  Write-Host "##[debug] Calling [ Get-Help Install-Module; ]...";
  Get-Help Install-Module;
  Write-Host "##[debug] ------------------------------------------------------------";
}