

# One-Liner to bring a new repo into powershell's package manager
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted;

# After logged in, install package(s) fro mthe repo
Install-Module -Name "CredentialManager"


# Citations
#
#			Thanks to addictivetips user 'Fatima Wahab' on forum https://www.addictivetips.com/windows-tips/add-a-trusted-repository-in-powershell-windows-10/
#
