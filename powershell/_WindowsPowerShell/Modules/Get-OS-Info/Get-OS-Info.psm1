# ------------------------------------------------------------
#
#	PowerShell - Get-OS-Info
#		|
#		|--> Description:  PowerShell script which shows the current Windows device's OS info, version, etc.
#		|
#		|--> Example(s):  Get-OS-Info
#
# ------------------------------------------------------------

function Get-OS-Info {
	Param(
	)
	Process {
		# ------------------------------------------------------------
		If ($False) { # RUN THIS SCRIPT:

			$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/Get-OS-Info/Get-OS-Info.psm1') ).Content) } Catch {}; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak; If (-Not (Get-Command -Name 'Get-OS-Info' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\Get-OS-Info\Get-OS-Info.psm1', ((Get-Variable -Name 'HOME').Value))); }; Get-OS-Info;

		}
		# ------------------------------------------------------------

		$Win32_OperatingSystem=(Get-CimInstance Win32_OperatingSystem);

		$OS_Info=@{
			IsDesktop=($Null);
			IsServer=($Null);
			Env_OSVersion_Platform=([Environment]::OSVersion.Platform);
			Env_OSVersion_ServicePack=([Environment]::OSVersion.ServicePack);
			Env_OSVersion_Version=([Environment]::OSVersion.Version);
			Env_OSVersion_VersionString=([Environment]::OSVersion.VersionString);
			OS_BuildName=($Null);
			OS_BuildNumber=(${Win32_OperatingSystem}.BuildNumber);
			OS_ProductType=($Null);
			OS_ProductSuite=($Null);
			OS_Organization=(${Win32_OperatingSystem}.Organization);
			OS_RegisteredUser=(${Win32_OperatingSystem}.RegisteredUser);
			OS_SerialNumber=(${Win32_OperatingSystem}.SerialNumber);
			OS_SystemDirectory=(${Win32_OperatingSystem}.SystemDirectory);
			OS_Version=(${Win32_OperatingSystem}.Version);
			URL_MicrosoftDocs=("https://docs.microsoft.com/en-us/windows/release-health/release-information");
		};

		# ------------------------------

		Switch ($Win32_OperatingSystem.ProductType) {
			1 { ${OS_Info}.OS_ProductType="Work Station"; }
			2 { ${OS_Info}.OS_ProductType="Domain Controller"; }
			3 { ${OS_Info}.OS_ProductType="Server"; }
		}

		# ------------------------------

		If (($Win32_OperatingSystem.ProductType) -NE 1) {
			<# Windows Server #>
			${OS_Info}.IsDesktop=$False;
			${OS_Info}.IsServer=$True;
			Switch ($Win32_OperatingSystem.BuildNumber) {
				6001 { ${OS_Info}.OS_BuildName="Windows Server 2008"; }
				7600 { ${OS_Info}.OS_BuildName="Windows Server 2008 R2"; }
				7601 { ${OS_Info}.OS_BuildName="Windows Server 2008 R2 Service Pack 1"; }
				9200 { ${OS_Info}.OS_BuildName="Windows Server 2012"; }
				9600 { ${OS_Info}.OS_BuildName="Windows Server 2012 R2"; }
				14393 { ${OS_Info}.OS_BuildName="Windows Server 2016 Version 1607"; }
				16229 { ${OS_Info}.OS_BuildName="Windows Server 2016 Version 1709"; }
			}
		} Else {
			<# Windows Desktop #>
			${OS_Info}.IsDesktop=$True;
			${OS_Info}.IsServer=$False;
			Switch ($Win32_OperatingSystem.BuildNumber) {
				10586 { ${OS_Info}.OS_BuildName="Windows 10 Version 1511"; }
				14393 { ${OS_Info}.OS_BuildName="Windows 10 Version 1607"; }
				15063 { ${OS_Info}.OS_BuildName="Windows 10 Version 1703"; }
				16299 { ${OS_Info}.OS_BuildName="Windows 10 Version 1709"; }
				17134 { ${OS_Info}.OS_BuildName="Windows 10 Version 1803"; }
				17763 { ${OS_Info}.OS_BuildName="Windows 10 Version 1809"; }
				18362 { ${OS_Info}.OS_BuildName="Windows 10 Version 1903"; }
				18363 { ${OS_Info}.OS_BuildName="Windows 10 Version 1909"; }
				19041 { ${OS_Info}.OS_BuildName="Windows 10 Version 2004"; }
				19042 { ${OS_Info}.OS_BuildName="Windows 10 Version 20H2"; }
				19043 { ${OS_Info}.OS_BuildName="Windows 10 Version 21H1"; }
			}
		}

		# ------------------------------

		Switch ($Win32_OperatingSystem.OSProductSuite) {
			1 { ${OS_Info}.OS_ProductSuite="Microsoft Small Business Server was once installed, but may have been upgraded to another version of Windows"; }
			2 { ${OS_Info}.OS_ProductSuite="Windows Server 2008 Enterprise is installed"; }
			4 { ${OS_Info}.OS_ProductSuite="Windows BackOffice components are installed"; }
			8 { ${OS_Info}.OS_ProductSuite="Communication Server is installed"; }
			16 { ${OS_Info}.OS_ProductSuite="Terminal Services is installed"; }
			32 { ${OS_Info}.OS_ProductSuite="Microsoft Small Business Server is installed with the restrictive client license"; }
			64 { ${OS_Info}.OS_ProductSuite="Windows Embedded is installed"; }
			128 { ${OS_Info}.OS_ProductSuite="A Datacenter edition is installed"; }
			256 { ${OS_Info}.OS_ProductSuite="Terminal Services is installed, but only one interactive session is supported"; }
			512 { ${OS_Info}.OS_ProductSuite="Windows Home Edition is installed"; }
			1024 { ${OS_Info}.OS_ProductSuite="Web Server Edition is installed"; }
			8192 { ${OS_Info}.OS_ProductSuite="Storage Server Edition is installed"; }
			16384 { ${OS_Info}.OS_ProductSuite="Compute Cluster Edition is installed"; }
		}

		# ------------------------------

		Return ${OS_Info};

	}

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "Get-OS-Info" -ErrorAction "SilentlyContinue";
}


# ------------------------------------------------------------
#
# Note: Registry Value Data-Types
#
#    REG_SZ         |  A null-terminated string
#    REG_BINARY     |  Binary data
#    REG_DWORD      |  A 32-bit number
#    REG_QWORD      |  A 64-bit number
#    REG_MULTI_SZ   |  A sequence of null-terminated strings, terminated by a null value
#    REG_EXPAND_SZ  |  A null-terminated string that contains unexpanded references to environment variables (like %PATH%)
#
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   devblogs.microsoft.com  |  "Introduction to CIM Cmdlets | PowerShell"  |  https://devblogs.microsoft.com/powershell/introduction-to-cim-cmdlets/
#
#   docs.microsoft.com  |  "Win32_OperatingSystem class - Win32 apps | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/win32-operatingsystem
#
#   docs.microsoft.com  |  "Get-CimInstance - Gets the CIM instances of a class from a CIM server"  |  https://docs.microsoft.com/en-us/powershell/module/cimcmdlets/get-ciminstance
#
#   stackoverflow.com  |  "How to find the Windows version from the PowerShell command line - Stack Overflow"  |  https://stackoverflow.com/a/59664454/7600236
#
#   docs.microsoft.com  |  "Windows 10 - release information | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/release-health/release-information
#
# ------------------------------------------------------------