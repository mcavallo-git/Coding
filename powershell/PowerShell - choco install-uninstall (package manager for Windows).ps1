# ------------------------------------------------------------
#
# Install choco
#  |--> choco is the cli reference for "Chocolatey", a package manager for Windows
#  |--> Chocolatey is software management automation for Windows that wraps installers, executables, zips, and scripts into compiled packages
#

<# Install choco (one-liner) #> PowerShell -Command "If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; Start-Process -Filepath ((GV PS).Value) -ArgumentList ('-Command SV ProgressPreference SilentlyContinue; If ((GCM choco -ErrorAction SilentlyContinue) -Eq ((GV null).Value)) { Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString((Write-Output https://chocolatey.org/install.ps1))); }; Start-Sleep -Seconds 5;') -Verb RunAs -Wait -PassThru | Out-Null;";


# ------------------------------
#
# Configure choco
#

<# Configure choco (one-liner) - Auto-accept (skip) confirmation prompts during choco installs,upgrades,etc. #> choco feature enable -n=allowGlobalConfirmation;


# ------------------------------
#
# Install choco packages
#

<# Install NETworkManager via choco (one-liner) #> If ((GCM choco -ErrorAction SilentlyContinue) -NE ((GV null).Value)) { choco install networkmanager; };


# ------------------------------
#
# Uninstall choco
#

<# Uninstall choco (one-liner) #> PowerShell -Command "If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; If (Test-Path ((((GCI env:\PROGRAMDATA).Value)+(Write-Output \chocolatey)))) { Start-Process -Filepath ((GV PS).Value) -ArgumentList ('-Command Remove-Item -Verbose -Recurse -Force -Path (((GCI env:\PROGRAMDATA).Value)+(Write-Output \chocolatey)); Start-Sleep -Seconds 5;') -Verb RunAs -Wait -PassThru | Out-Null; }";


# ------------------------------------------------------------
#
# Citation(s)
#
#   chocolatey.org  |  "Chocolatey Software | Installation"  |  https://chocolatey.org/docs/installation#install-with-cmdexe
#
#   chocolatey.org  |  "Chocolatey Software | Chocolatey - The package manager for Windows"  |  https://chocolatey.org/
#
#   chocolatey.org  |  "Chocolatey Software | NETworkManager 2019.12.0"  |  https://chocolatey.org/packages/NETworkManager
#
#   stackoverflow.com  |  "How do I update all Chocolatey applications without confirmation? - Stack Overflow"  |  https://stackoverflow.com/a/30428182
#
# ------------------------------------------------------------