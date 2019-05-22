
# $ErrorActionPreference = ("SilentlyContinue");

$LogFile_IPv4Addresses = ("${HOME}/Desktop/NetworkDevice.IPv4Addresses.$(Get-Date -UFormat '%Y-%m-%d (%a)').log");
$LogFile_Hostnames = ("${HOME}/Desktop/NetworkDevice.Hostnames.$(Get-Date -UFormat '%Y-%m-%d (%a)').log");

# For ($i=0; $i -le 20; $i++) {

	$EachIPv4 = "192.168.10.1";

	$TestConn = (Test-Connection -Quiet -ErrorAction ("SilentlyContinue") -Count (1) -ComputerName ("${EachIPv4}"));
	Write-Host "TestConn: " -NoNewLine; $TestConn;

	$TestComputerConn = (Test-ComputerConnection -ComputerName ("${EachIPv4}"));
	Write-Host "TestComputerConn: " -NoNewLine; $TestComputerConn | Format-List;
	
	If ($TestConn -Eq $True) {
		
		Add-Content -Path ("${LogFile_IPv4Addresses}") -Value ("$EachIPv4}");

		$TestNetConn = (Test-NetConnection -InformationLevel ("Quiet") -ErrorAction ("SilentlyContinue") -ComputerName ("${EachIPv4}"));
		Write-Host "TestNetConn: " -NoNewLine; $TestNetConn | Format-List;

		$DnsLookupHostname = ([System.Net.Dns]::GetHostByAddress("${EachIPv4}")); $DnsLookupSuccess = $?;
		Write-Host "DnsLookupHostname: " -NoNewLine; $DnsLookupHostname | Format-List;

	}

# }


Function Test-ComputerConnection
{
	# FUNCTION REQUIREMENTS --> POWERSHELL v6+
	<#	
		.SYNOPSIS
			Test-ComputerConnection sends a ping to the specified computer or IP Address specified in the ComputerName parameter.
		
		.DESCRIPTION
			Test-ComputerConnection sends a ping to the specified computer or IP Address specified in the ComputerName parameter. Leverages the System.Net object for ping
			and measures out multiple seconds faster than Test-Connection -Count 1 -Quiet.
		
		.PARAMETER ComputerName
			The name or IP Address of the computer to ping.

		.EXAMPLE
			Test-ComputerConnection -ComputerName "THATPC"
			
			Tests if THATPC is online and returns a custom object to the pipeline.
			
		.EXAMPLE
			$MachineState = Import-CSV .\computers.csv | Test-ComputerConnection -Verbose
		
			Test each computer listed under a header of ComputerName, MachineName, CN, or Device Name in computers.csv and
			and stores the results in the $MachineState variable.
			
	#>
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory=$True,
		ValueFromPipeline=$True, ValueFromPipelinebyPropertyName=$true)]
		[alias("CN","MachineName","Device Name")]
		[string]$ComputerName	
	)
	Begin
	{
		[int]$timeout = 20
		[switch]$resolve = $true
		[int]$TTL = 128
		[switch]$DontFragment = $false
		[int]$buffersize = 32
		$options = new-object system.net.networkinformation.pingoptions
		$options.TTL = $TTL
		$options.DontFragment = $DontFragment
		$buffer=([system.text.encoding]::ASCII).getbytes("a"*$buffersize)	
	}
	Process
	{
		$ping = new-object system.net.networkinformation.ping
		try
		{
			$reply = $ping.Send($ComputerName,$timeout,$buffer,$options)	
		}
		catch
		{
			$ErrorMessage = $_.Exception.Message
		}
		if ($reply.status -eq "Success")
		{
			$props = @{ComputerName=$ComputerName
						Online=$True
			}
		}
		else
		{
			$props = @{ComputerName=$ComputerName
						Online=$False			
			}
		}
		New-Object -TypeName PSObject -Property $props
	}
	End{};
}

#
#	Citation(s)
#
#		Test-ComputerConnection
#				|--> Original code provided by Reddit user [ Kreloc ] on forum [ https://www.reddit.com/r/PowerShell/comments/3rnrj9 ]
#