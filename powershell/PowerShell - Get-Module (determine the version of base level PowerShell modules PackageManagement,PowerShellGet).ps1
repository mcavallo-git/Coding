# ------------------------------------------------------------
# PowerShell - Get-Module (determine the version of base level PowerShell modules PackageManagement,PowerShellGet)
# ------------------------------------------------------------


# Get all currently-loaded PowerShell modules
Get-Module | Sort-Object -Property Name | Select-Object -Property Name, Version, Path, RootModule | Format-List;


# Get specific PowerShell modules  ( which exist in ${env:PSModulePath} )
Get-Module -ListAvailable @("PackageManagement","PowerShellGet") | Sort-Object -Property Name | Select-Object -Property Name, Version, Path, RootModule | Format-List;


# Get all PowerShell modules  ( which exist in ${env:PSModulePath} )
(Get-Module -ListAvailable | Sort-Object -Property Name | ForEach-Object {
  "-- "*20;
  $_ | Select-Object -Property Name, Version, Path | Format-List | Out-String;
  If (($_.Path) -NE ($_.RootModule)) {
    # Only drill down on $_.RootModule details that aren't immediately apparent from the $_.Path
    If (($_.RootModule) -notmatch "^.+\.(dll|psm1)`$") {
      "ModName : $($_.RootModule)";
    } Else {
      # Resolve the path to the RootModule (if not the same as the Path and contains a file extension)
      $RootModPath="$([IO.Path]::GetDirectoryName($_.Path))\$([IO.Path]::GetFileName($_.RootModule))";
      If (Test-Path -PathType "Leaf" -Path ("${RootModPath}")) {
        "ModPath : ${RootModPath}";
      } Else {
        "RootMod : $($_.RootModule)";
      };
    };
  };
} | Out-String -Width 500) -replace "(\n)\s*\n","`$1" -replace "\n`$",""; "-- "*20;


# ------------------------------------------------------------
#
# Get version info for base level PowerShell module(s)
#

# Basic - Get base level PowerShell module version info
Get-Module -ListAvailable @("PackageManagement","PowerShellGet") | Sort-Object -Property Name | Select-Object -Property Name, Version, Path, RootModule | Format-Table | Out-String -Width 500;


# Advanced - Get base level PowerShell module version info
If ($True) {
  Write-Host "------------------------------------------------------------";
  Write-Host "Getting PowerShell Version...";
  Write-Host ((Write-Output PowerShell)+([String][Char]32)+(((GV PSVersionTable).Value).PSVersion.Major)+(Write-Output .)+(((GV PSVersionTable).Value).PSVersion.Minor))
  Write-Host "------------------------------------------------------------";
  Write-Host "Calling [ Get-Module -ListAvailable @(`"PackageManagement`",`"PowerShellGet`") | ... ; ]...";
  (Get-Module -ListAvailable @("PackageManagement","PowerShellGet") | Sort-Object -Property Name | ForEach-Object {
    "-- "*20;
    $_ | Select-Object -Property Name, Version, Path | Format-List | Out-String;
    If (($_.Path) -NE ($_.RootModule)) {
      # Only drill down on $_.RootModule details that aren't immediately apparent from the $_.Path
      If (($_.RootModule) -notmatch "^.+\.(dll|psm1)`$") {
        "ModName : $($_.RootModule)";
      } Else {
        # Resolve the path to the RootModule (if not the same as the Path and contains a file extension)
        $RootModPath="$([IO.Path]::GetDirectoryName($_.Path))\$([IO.Path]::GetFileName($_.RootModule))";
        If (Test-Path -PathType "Leaf" -Path ("${RootModPath}")) {
          "ModPath : ${RootModPath}";
        } Else {
          "RootMod : $($_.RootModule)";
        };
      };
    };
  } | Out-String -Width 500) -replace "(\n)\s*\n","`$1" -replace "\n`$",""; "-- "*20;
  Write-Host "------------------------------------------------------------";
  # Write-Host "Calling [ Get-Help Install-Module; ]...";
  # Get-Help Install-Module;
  # Write-Host "------------------------------------------------------------";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   learn.microsoft.com  |  "Get-Module (Microsoft.PowerShell.Core) - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/get-module
#
#   learn.microsoft.com  |  "Format-Table (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/format-table
#
#   learn.microsoft.com  |  "Out-String (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/out-string
#
#   learn.microsoft.com  |  "Path.GetDirectoryName Method (System.IO) | Microsoft Learn"  |  https://learn.microsoft.com/en-us/dotnet/api/system.io.path.getdirectoryname
#
#   learn.microsoft.com  |  "Path.GetFileName Method (System.IO) | Microsoft Learn"  |  https://learn.microsoft.com/en-us/dotnet/api/system.io.path.getfilename
#
#   stackoverflow.com  |  "console - Powershell output column width - Stack Overflow"  |  https://stackoverflow.com/a/978794
#
# ------------------------------------------------------------