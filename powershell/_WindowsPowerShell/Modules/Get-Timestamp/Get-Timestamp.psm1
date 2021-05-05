# ------------------------------------------------------------
#
# @ Get-Timestamp
#   |--> Get the current datetime as a string
#
# ------------------------------------------------------------
Function Get-Timestamp {

	Param(
		[String]$DateFormat="%Y-%m-%dT%H:%M:%S%Z",
	);
	# ------------------------------------------------------------
	If ($False) { # RUN THIS SCRIPT:

		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/Get-Timestamp/Get-Timestamp.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'Get-Timestamp' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\Get-Timestamp\Get-Timestamp.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;

	}
	# ------------------------------------------------------------
	$Add_TZ=$False;
	If (${DateFormat} -contains "%Z") {
		$Add_TZ=$True;
	}
	$ReturnVal = "";
	<# Avoid determining GMT (Daylight Savings Time) offset by pulling the UTC hours-offset from the "Get-Date" cmdlet (which is automatically updated with respect to GMT) and the UTC minutes-offset from the "Get-TimeZone" cmdlet #>
	$TZ_Offset=((Get-Date -UFormat ('%Z'))+(([String](Get-TimeZone).BaseUtcOffset) -replace "^([-+]?)(\d+):(\d+):(\d+)$",':$3'));
	Return (([String](Get-Date -Date ((New-Object -Type DateTime -ArgumentList 1970,1,1,0,0,0,0).AddSeconds([Math]::Floor($([Decimal](Get-Date -UFormat ("%s")))))) -UFormat (${DateFormat})))+(([String](($([Decimal](Get-Date -UFormat ("%s")))%1))).Substring(1).PadRight(6,"0"))+(Get-Date -UFormat ("%Z")));


	Return $(
		([String](Get-Date -Date ((New-Object -Type DateTime -ArgumentList 1970,1,1,0,0,0,0).AddSeconds([Math]::Floor($([Decimal](Get-Date -UFormat ('%s')))))) -UFormat ('%Y-%m-%dT%H:%M:%S')))
		+
		(([String](($([Decimal](Get-Date -UFormat ('%s')))%1))).Substring(1).PadRight(6,'0'))
		+
		(Get-Date -UFormat ('%Z'))+(([String](Get-TimeZone).BaseUtcOffset) -replace "^([-+]?)(\d+):(\d+):(\d+)$",':$3')
	);

	# ------------------------------------------------------------
}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "Get-Timestamp";
}


# ------------------------------------------------------------