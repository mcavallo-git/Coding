# ------------------------------------------------------------
#
# VMware PowerCLI - Install NuGet Repo & VMware PowerCLI PowerShell Module
#

If ($True) {
	# Pre-Reqs: Check-for (and install if not found) the VMware PowerCLI PowerShell Module
	If ((Get-Module -ListAvailable -Name ("VMware.PowerCLI") -ErrorAction "SilentlyContinue") -Eq $Null) {
		# Pre-Reqs: Check-for (and install if not found) the NuGet PowerShell Module-Repository
		$PackageProvider = "NuGet";
		If ((Get-PackageProvider -Name "${PackageProvider}" -ErrorAction "SilentlyContinue") -Eq $Null) {
			$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol;
			[System.Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12;
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
#
#   powercli-core.readthedocs.io  |  "Install and Set Up vSphere PowerCLI"  |  https://pubs.vmware.com/vsphere-50/index.jsp?topic=%2Fcom.vmware.vsphere.install.doc_50%2FGUID-F02D0C2D-B226-4908-9E5C-2E783D41FE2D.html
#
# ------------------------------------------------------------