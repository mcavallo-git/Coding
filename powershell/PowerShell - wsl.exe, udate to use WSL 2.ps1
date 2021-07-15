# ------------------------------------------------------------
# wsl.exe - Update to use WSL 2
# ------------------------------------------------------------


wsl.exe --list --verbose;  # The line starting with an asterisk '*' is the current terminal's Linux distro


wsl.exe --set-version Ubuntu 2;  # DON'T USE QUOTES ON DISTRO NAME


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