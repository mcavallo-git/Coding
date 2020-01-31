# ------------------------------------------------------------
#
# Install the "Chocolatey" package manager for Windows
#   |--> Chocolatey is software management automation for Windows that wraps installers, executables, zips, and scripts into compiled packages
#
If ((Get-Command "choco" -ErrorAction "SilentlyContinue") -Eq $Null) {
	Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force;
	Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));
}


If ((Get-Command "choco" -ErrorAction "SilentlyContinue") -NE $Null) {
	# The choco feature "allowGlobalConfirmation" skips (auto-accepts) confirmation prompts when installing/updating modules through choco
	choco feature enable -n=allowGlobalConfirmation;
	# NETworkManager
	choco install networkmanager;
}


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