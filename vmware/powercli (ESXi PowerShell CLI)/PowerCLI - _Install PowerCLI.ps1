# ------------------------------------------------------------
#
# PowerShell - Install VMware's PowerCLI Module
#
# ------------------------------------------------------------

If ($True) {
	# Pre-Reqs: Check-for (and install if not found) the VMware PowerCLI PowerShell Module
	If ($null -eq (Get-Module -ListAvailable -Name ("VMware.PowerCLI") -ErrorAction "SilentlyContinue")) {
		# Pre-Reqs: Check-for (and install if not found) the NuGet PowerShell Module-Repository
		$PackageProvider = "NuGet";
		If ($null -eq (Get-PackageProvider -Name "${PackageProvider}" -ErrorAction "SilentlyContinue")) {
			$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol;
			[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12;
				Install-PackageProvider -Name ("${PackageProvider}") -Force -Confirm:$False; $InstallPackageProvider_ReturnCode = If($?){0}Else{1};  # Install-PackageProvider fails on default windows installs without at least TLS 1.1 as of 20200501T041624
			[System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
		}
		Install-Module -Name ("VMware.PowerCLI") -Scope CurrentUser -Force;
	}
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Install-Module (PowerShellGet) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/powershellget/install-module?view=powershell-5.1
#
#   docs.microsoft.com  |  "Install-PackageProvider (PackageManagement) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/packagemanagement/install-packageprovider?view=powershell-5.1
#
#   powercli-core.readthedocs.io  |  "Install and Set Up vSphere PowerCLI"  |  https://pubs.vmware.com/vsphere-50/index.jsp?topic=%2Fcom.vmware.vsphere.install.doc_50%2FGUID-F02D0C2D-B226-4908-9E5C-2E783D41FE2D.html
#
# ------------------------------------------------------------