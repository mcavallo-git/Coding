# ------------------------------------------------------------
#
# PowerShell - Install a PowerShell Module from a given PowerShell Repository
#
# ------------------------------------------------------------

$PSModule_Name=("SqlServer");

$PSRepository_Name=("PSGallery");

If ((Get-Module -ListAvailable -Name "${PSModule_Name}" -ErrorAction SilentlyContinue) -Eq $Null) {
	[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12;
	If ((Get-PSRepository -Name "${PSRepository_Name}" -ErrorAction SilentlyContinue) -Eq $Null) {
		Set-PSRepository -Name "${PSRepository_Name}" -InstallationPolicy Trusted;
	};
	Install-Module -Name "${PSModule_Name}" -Scope CurrentUser -AllowClobber -Force;
};


# ------------------------------------------------------------
#
#	Citation(s)
#
#   addictivetips.com  |  "How To Add A Trusted Repository In PowerShell In Windows 10"  |  https://www.addictivetips.com/windows-tips/add-a-trusted-repository-in-powershell-windows-10/
#
#   addictivetips.com  |  "Install-Module (PowerShellGet) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/powershellget/install-module?view=powershell-5.1
#
#   addictivetips.com  |  "Set-PSRepository (PowerShellGet) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/powershellget/set-psrepository?view=powershell-5.1
#
# ------------------------------------------------------------
