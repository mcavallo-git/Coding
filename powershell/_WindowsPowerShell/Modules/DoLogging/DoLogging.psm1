# ------------------------------------------------------------
#
# @ DoLogging
#   |--> Quickly log a message along with a timestamp to target logfile
#
# ------------------------------------------------------------
Function DoLogging {
	Param(

		[Parameter(Mandatory=$True)]
		[String]$LogFile="",   <# Path to logfile to log-to #>

		[String]$Text="",      <# Text to log to logfile #>

		[String]$Level="INFO", <# Output in-line with each logfile line #>

		[Switch]$Quiet
	);

	# ------------------------------------------------------------
	If ($False) { # RUN THIS SCRIPT:

		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/DoLogging/DoLogging.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'DoLogging' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\DoLogging\DoLogging.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;

	}

	<# Get the current datetime as a string #>
	$GetTimestamp = $(Get-Date -Format 'yyyyMMddTHHmmss.fffzz');

	If ($False) {
		<# Define the logging filepath & Ensure that the logging directory exists #>
		$LogDir = "${env:SystemDrive}\ISO\Logs";
		$LogFile = "${LogDir}\Logfile_$(GetTimestamp).log";
		If ((Test-Path -Path (${LogDir})) -Eq ($False)) {
			New-Item -ItemType "Directory" -Path (${FullPath_LoggingDir}) | Out-Null;
		}
		Set-Location -Path (${LogDir});
	}

	$OutString = "[$(${GetTimestamp}) INFO $($MyInvocation.MyCommand.Name)] ${Text}";

	<# Write the output to target logfile #>
	Write-Output "${OutString}" | Out-File -Width 16384 -Append "${LogFile}";

	<# Duplicate the output to the console (if not disabled) #>
	If (-Not $PSBoundParameters.ContainsKey('Quiet')) {
		Write-Host "${OutString}";
	}


	Return;
}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "DoLogging";
}


# ------------------------------------------------------------