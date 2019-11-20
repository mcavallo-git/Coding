

# One-Liner to bring a new repo into powershell's package manager
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted;

# After logged in, install package(s) fro mthe repo
Install-Module -Name "CredentialManager"


# ------------------------------------------------------------
#
#	Citation(s)
#
#   addictivetips.com  |  "How To Add A Trusted Repository In PowerShell In Windows 10"  |  https://www.addictivetips.com/windows-tips/add-a-trusted-repository-in-powershell-windows-10/
#
# ------------------------------------------------------------
