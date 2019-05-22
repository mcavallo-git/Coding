
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
		$ping = New-Object system.net.networkinformation.ping;

		Try {
			$reply = $ping.Send($ComputerName,$timeout,$buffer,$options)	
		} Catch {
			$ErrorMessage = $_.Exception.Message
		}
		
		If ($reply.status -eq "Success") {
			$props = @{ComputerName=$ComputerName
						Online=$True
			}
		} Else {
			$props = @{ComputerName=$ComputerName
						Online=$False			
			}
		}
		New-Object -TypeName PSObject -Property $props
	}
	End{};
}

$LogFile_IPv4Addresses = ("${HOME}/Desktop/NetworkDevice.IPv4Addresses.$(Get-Date -UFormat '%Y-%m-%d (%a)').log");
$LogFile_Hostnames = ("${HOME}/Desktop/NetworkDevice.Hostnames.$(Get-Date -UFormat '%Y-%m-%d (%a)').log");

Set-Content -Path ("${LogFile_IPv4Addresses}") -Value ("");
Set-Content -Path ("${LogFile_Hostnames}") -Value ("");

# For ($i=0; $i -le 20; $i++) {

	$EachIPv4 = "192.168.10.1";

	# $Measure_TestConn = Measure-Command { $TestConn = (Test-Connection -Quiet -Count (1) -ComputerName ("${EachIPv4}")); };
	# $Measure_TestConn = Measure-Command { $TestConn = (Test-Connection -Quiet -Ping -Count (1) -ComputerName ("${EachIPv4}") -ErrorAction ("SilentlyContinue") 6> $null); };
	$Measure_TestConn = Measure-Command { $TestConn = (Test-Connection -Quiet -Ping -Count (1) -ComputerName ("${EachIPv4}") -ErrorAction ("SilentlyContinue") -InformationAction ("Ignore")); };
	Write-Host "TestConn: " -NoNewLine; $TestConn;
	Write-Host "Measure_TestConn.TotalMilliseconds: " -NoNewLine; $Measure_TestConn.TotalMilliseconds;
	Write-Host "";

	$Measure_TestComputerConn = Measure-Command { $TestComputerConn = (Test-ComputerConnection -ComputerName ("${EachIPv4}")); };
	Write-Host "TestComputerConn: " -NoNewLine; $TestComputerConn | Format-List;
	Write-Host "Measure_TestComputerConn.TotalMilliseconds: " -NoNewLine; $Measure_TestComputerConn.TotalMilliseconds;
	Write-Host "";

	If ($TestConn -Eq $True) {
		
		Add-Content -Path ("${LogFile_IPv4Addresses}") -Value ("$EachIPv4}");

		$Measure_TestNetConn = Measure-Command { $TestNetConn = (Test-NetConnection -InformationLevel ("Detailed") -ComputerName ("${EachIPv4}")); };
		Write-Host "TestNetConn: " -NoNewLine; $TestNetConn | Format-List;
		Write-Host "Measure_TestNetConn.TotalMilliseconds: " -NoNewLine; $Measure_TestNetConn.TotalMilliseconds;
		Write-Host "";

		$Revertable_ErrorActionPreference = $ErrorActionPreference; $ErrorActionPreference = ("SilentlyContinue");
		$Measure_DnsLookupHostname = Measure-Command { $DnsLookupHostname = ([System.Net.Dns]::GetHostByAddress("${EachIPv4}")); $DnsLookupSuccess = $?; };
		$ErrorActionPreference = $Revertable_ErrorActionPreference;

		Write-Host "DnsLookupHostname: " -NoNewLine; $DnsLookupHostname | Format-List;
		Write-Host "Measure_DnsLookupHostname.TotalMilliseconds: " -NoNewLine; $Measure_DnsLookupHostname.TotalMilliseconds;
		Write-Host "";

	}

# }

#
#	Citation(s)
#
#		Test-ComputerConnection
#				|--> Original code provided by Reddit user [ Kreloc ] on forum [ https://www.reddit.com/r/PowerShell/comments/3rnrj9 ]
#