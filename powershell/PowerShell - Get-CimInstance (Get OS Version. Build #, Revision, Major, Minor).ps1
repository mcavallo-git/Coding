# ------------------------------------------------------------
#
# PowerShell - Get build info regarcing current Windows OS
#
# ------------------------------------------------------------

# PowerShell-native method
$OS_Build = ([Environment]::OSVersion.Version).Build;
Write-Host "Build = ${$OS_Build}";

# Alternate method
$OS_Build = (Get-CimInstance Win32_OperatingSystem).Version;
Write-Host "Build = ${$OS_Build}";


# ------------------------------------------------------------
#
# PowerShell - Get verbose info regarcing current Windows OS
#
# ------------------------------------------------------------

$Win32_OperatingSystem = (Get-CimInstance Win32_OperatingSystem);

Switch ($Win32_OperatingSystem.ProductType) {
	1 { $WindowsType = "Work Station"; }
	2 { $WindowsType = "Domain Controller"; }
	3 { $WindowsType = "Server"; }
	Default { $WindowsType = "Not Listed"}
}
Write-Host "`$WindowsType = [ ${WindowsType} ]";

If (($Win32_OperatingSystem.ProductType) -NE 1) {
	Switch ($Win32_OperatingSystem.BuildNumber) {
		6001 { $Servertype = "Windows Server 2008"; $IsServer=$True; }
		7600 { $Servertype = "Windows Server 2008 R2"; $IsServer=$True; }
		7601 { $Servertype = "Windows Server 2008 R2 Service Pack 1"; $IsServer=$True; }
		9200 { $Servertype = "Windows Server 2012"; $IsServer=$True; }
		9600 { $Servertype = "Windows Server 2012 R2"; $IsServer=$True; }
		14393 { $Servertype = "Windows Server 2016 Version 1607"; $IsServer=$True; }
		16229 { $Servertype = "Windows Server 2016 Version 1709"; $IsServer=$True; }
		Default { $Servertype = "Not Listed"}
	}
	Write-Host "`$Servertype = [ ${Servertype} ]";
}

Switch ($Win32_OperatingSystem.OSProductSuite) {
	1 { $Win_OSProductSuite = "Microsoft Small Business Server was once installed, but may have been upgraded to another version of Windows"; }
	2 { $Win_OSProductSuite = "Windows Server 2008 Enterprise is installed"; }
	4 { $Win_OSProductSuite = "Windows BackOffice components are installed"; }
	8 { $Win_OSProductSuite = "Communication Server is installed"; }
	16 { $Win_OSProductSuite = "Terminal Services is installed"; }
	32 { $Win_OSProductSuite = "Microsoft Small Business Server is installed with the restrictive client license"; }
	64 { $Win_OSProductSuite = "Windows Embedded is installed"; }
	128 { $Win_OSProductSuite = "A Datacenter edition is installed"; }
	256 { $Win_OSProductSuite = "Terminal Services is installed, but only one interactive session is supported"; }
	512 { $Win_OSProductSuite = "Windows Home Edition is installed"; }
	1024 { $Win_OSProductSuite = "Web Server Edition is installed"; }
	8192 { $Win_OSProductSuite = "Storage Server Edition is installed"; }
	16384 { $Win_OSProductSuite = "Compute Cluster Edition is installed"; }
}
Write-Host "`$Win_OSProductSuite = [ ${Win_OSProductSuite} ]";


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
# ------------------------------------------------------------