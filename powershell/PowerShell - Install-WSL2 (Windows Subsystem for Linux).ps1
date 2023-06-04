# ------------------------------------------------------------
#
# PowerShell - Install-WSL2 (Windows Subsystem for Linux)
#
# ------------------------------------------------------------


# Run the following command(s) in a non-admin PowerShell terminal (installs the Ubuntu-22.04 WSL distro (Windows Subsystem for Linux distribution)):
Start-Process -Filepath ("${env:windir}\System32\wsl.exe") -ArgumentList ("--install --distribution Ubuntu-22.04") -Verb RunAs;


# Verify that the installed Linux distro is using WSL version 2:
wsl --list --verbose;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Install WSL | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/wsl/install#step-4---download-the-linux-kernel-update-package
#
# ------------------------------------------------------------