# ------------------------------------------------------------
# wsl.exe - Update to use WSL 2
# ------------------------------------------------------------

# Download & Install the WSL 2 updated kernel for x64 systems (if not installed, already)
PowerShell -Command "If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; Start-Process -Filepath ((GV PS).Value) -ArgumentList ('-Command Set-Location ((GCI env:\TEMP).Value); SV ProgressPreference SilentlyContinue; Invoke-WebRequest -UseBasicParsing -Uri (Write-Output https://aka.ms/wsl2kernelmsix64) -OutFile (Write-Output .\wsl_update_x64.msi); Start-Process ((GCM msiexec).Source) -ArgumentList (Write-Output /I` wsl_update_x64.msi` /quiet) -Wait; Start-Sleep -Seconds 5;') -Verb RunAs -Wait -PassThru | Out-Null;";


# Source URL:  https://aka.ms/wsl2kernelmsix64       # Direct URL:  https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
# ------------------------------

# Enable the "Virtual Machine Platform" Windows 10 feature
Get-WindowsOptionalFeature -Online -FeatureName "VirtualMachinePlatform" | Where-Object { $_.State -Eq "Disabled" } | Enable-WindowsOptionalFeature -Online;


# ------------------------------

# Determine distros to be updated
wsl.exe --list --verbose;  # The line starting with an asterisk '*' is the current terminal's Linux distro

# Update desired distros to WSL 2
wsl.exe --set-version Ubuntu 2;  # DON'T USE QUOTES ON DISTRO NAME

# Update default WSL version to WSL 2
wsl.exe --set-default-version 2;  


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.docker.com  |  "Docker Desktop WSL 2 backend | Docker Documentation"  |  https://docs.microsoft.com/en-us/windows/wsl/about#what-is-wsl-2
#
#   docs.microsoft.com  |  "Install WSL on Windows 10 | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/wsl/install-win10#step-4---download-the-linux-kernel-update-package
#
#   docs.microsoft.com  |  "What is Windows Subsystem for Linux | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/wsl/about
#
# ------------------------------------------------------------