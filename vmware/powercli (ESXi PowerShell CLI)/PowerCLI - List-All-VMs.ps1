# ------------------------------------------------------------
#
# VMware PowerCLI - Install NuGet Repo & VMware PowerCLI PowerShell Module, then connect to a target VMware vSphere Hypervisor (ESXi) Server/Host
#

If ($True) {

	$ESXi_LoginPass = $Null;
	$ESXi_LoginUser = $Null;
	$ESXi_Server = $Null;
	$ESXi_ServerPort = "443";
	$ESXi_ServerProtocol = "https";
	$ESXi_IgnoreInvalidSslCertificates = $False;

	If ($args -NE $Null) {
		If ($args.Contains('-LoginPass')) {
			If (($LoginPass.GetType().Name) -Eq ("SecureString")) {
				$ESXi_LoginPass = $LoginPass;
			} Else {
				$ESXi_LoginPass = ConvertTo-SecureString -String ("${LoginPass}") -AsPlainText -Force;
			}
		}
		If ($args.Contains('-LoginUser')) {
			$ESXi_LoginUser = $LoginUser;
		}
		If ($args.Contains('-Server')) {
			$ESXi_Server = $Server;
		}
		If ($args.Contains('-ServerPort')) {
			$ESXi_ServerPort = $ServerPort;
		}
		If ($args.Contains('-ServerProtocol')) {
			$ESXi_ServerProtocol = $ServerProtocol;
		}
		If ($args.Contains('-IgnoreInvalidSslCertificates')) {
			$ESXi_IgnoreInvalidSslCertificates = $True;
		}
	}

	Write-Output "`$ESXi_Server = [ $(${ESXi_Server}) ]";
	Write-Output "`$ESXi_ServerPort = [ $(${ESXi_ServerPort}) ]";
	Write-Output "`$ESXi_ServerProtocol = [ $(${ESXi_ServerProtocol}) ]";
	Write-Output "`$ESXi_IgnoreInvalidSslCertificates = [ $(${ESXi_IgnoreInvalidSslCertificates}) ]";
	Write-Output "`$ESXi_LoginUser = [ $(${ESXi_LoginUser}) ]";
	Write-Output "`$ESXi_LoginPass = [ $(${ESXi_LoginPass}) ]";

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

	# Ignore Invalid HTTPS Certs (for LAN servers, etc.)
	If ($ESXi_IgnoreInvalidSslCertificates -Eq $True) {
		Set-PowerCLIConfiguration -InvalidCertificateAction "Ignore" -Confirm:$False;
	}

	If ($null -eq $ESXi_Server) {
		$ESXi_Server = (Read-Host -Prompt ("`nEnter FQDN/IP of vSphere Server"));
	}
	If ($null -eq $ESXi_LoginUser) {
		$ESXi_LoginUser = (Read-Host -Prompt ("`nEnter Username"));
	}
	If ($null -eq $ESXi_LoginPass) {
		$ESXi_LoginPass = (Read-Host -AsSecureString -Prompt ("`nEnter Password"));
	}

	$vSphere_ConnectionStream = (
		Connect-VIServer `
			-Password ([System.Runtime.InteropServices.Marshal]::PtrToStringUni([System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode(${ESXi_LoginPass}))) `
			-Port ("${ESXi_ServerPort}") `
			-Protocol ("${ESXi_ServerProtocol}") `
			-User ("${ESXi_LoginUser}") `
			-Server ("${ESXi_Server}") `
			-SaveCredentials `
	);

	If ($vSphere_ConnectionStream -NE $Null) {

		# Do some action with the now-connected vSphere Hypervisor (ESXi Server) 

		Get-VM | Sort-Object -Property Name | Format-Table -Autosize

	}

	Disconnect-VIServer "*" -Confirm:$False;

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   powercli-core.readthedocs.io  |  "Connect-VIServer"  |  https://powercli-core.readthedocs.io/en/latest/cmd_connect.html#connect-viserver
#
#   powercli-core.readthedocs.io  |  "Disconnect-VIServer"  |  https://powercli-core.readthedocs.io/en/latest/cmd_disconnect.html#disconnect-viserver
#
#   pubs.vmware.com  |  "Connect-VIServer - vSphere PowerCLI Cmdlets Reference"  |  https://pubs.vmware.com/vsphere-51/index.jsp?topic=%2Fcom.vmware.powercli.cmdletref.doc%2FConnect-VIServer.html
#
#   pubs.vmware.com  |  "Disconnect-VIServer - vSphere PowerCLI Cmdlets Reference"  |  https://pubs.vmware.com/vsphere-51/index.jsp?topic=%2Fcom.vmware.powercli.cmdletref.doc%2FDisconnect-VIServer.html
#
#   pubs.vmware.com  |  "Get-VM - vSphere PowerCLI Cmdlets Reference"  |  https://pubs.vmware.com/vsphere-51/index.jsp?topic=%2Fcom.vmware.powercli.cmdletref.doc%2FGet-VM.html
#
#   pubs.vmware.com  |  "Get-VMHost - vSphere PowerCLI Cmdlets Reference"  |  https://pubs.vmware.com/vsphere-51/index.jsp?topic=%2Fcom.vmware.powercli.cmdletref.doc%2FGet-VMHost.html
#
# ------------------------------------------------------------