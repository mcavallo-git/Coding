# ------------------------------------------------------------
#
# PowerShell - install wsl2 (Windows Subsystem for Linux v2)
#


# Run the following command(s) in a non-admin PowerShell terminal (installs the Ubuntu-20.04 WSL distro (Linux Distribution)):
Start-Process -Filepath ("${env:windir}\System32\wsl.exe") -ArgumentList ("--install --distribution Ubuntu-20.04") -Verb RunAs;


# Verify that the installed Ubuntu-20.04 distro is using WSL version 2:
wsl --list --verbose;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Install WSL | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/wsl/install#step-4---download-the-linux-kernel-update-package
#
# ------------------------------------------------------------