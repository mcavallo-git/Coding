# ------------------------------------------------------------
#
# PowerShell - Get-Timestamp
#   |
#   |--> Description:  Get the current datetime as a string
#   |
#   |--> Example:      Get-Timestamp
#                      Get-Timestamp -Filename
#
# ------------------------------------------------------------

Function Get-Timestamp {
	Param(
		[String]$Format="yyyy-MM-ddThh:mm:ss.fffzzz",
		[Switch]$Filename
	);
	# ------------------------------------------------------------
	If ($False) { # RUN THIS SCRIPT:

		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/Get-Timestamp/Get-Timestamp.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'Get-Timestamp' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\Get-Timestamp\Get-Timestamp.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;

	}
	# ------------------------------------------------------------

	$ReturnVal="";

	If ($PSBoundParameters.ContainsKey('Filename')) {
		$ReturnVal=$([String](Get-Date -Format "yyyyMMddTHHmmsszz"));
	} Else {
		$ReturnVal=$([String](Get-Date -Format "${Format}"));
	}

	Return ${ReturnVal};

	# ------------------------------------------------------------
	
}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "Get-Timestamp";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#		docs.microsoft.com  |  "Custom date and time format strings | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/standard/base-types/custom-date-and-time-format-strings?view=netframework-4.8
#
#		docs.microsoft.com  |  "Get-Date - Gets the current date and time"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date
#
# ------------------------------------------------------------