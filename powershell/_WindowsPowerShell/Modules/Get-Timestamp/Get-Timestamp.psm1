# ------------------------------------------------------------
#
# @ Get-Timestamp
#   |--> Get the current datetime as a string
#
# ------------------------------------------------------------
Function Get-Timestamp {
	Param()
	# ------------------------------------------------------------
	If ($False) { # RUN THIS SCRIPT:

		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/Get-Timestamp/Get-Timestamp.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'Get-Timestamp' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\Get-Timestamp\Get-Timestamp.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;

	}
	# ------------------------------------------------------------

	Return (([String](Get-Date -Date ((New-Object -Type DateTime -ArgumentList 1970,1,1,0,0,0,0).AddSeconds([Math]::Floor($([Decimal](Get-Date -UFormat ("%s")))))) -UFormat ("%Y-%m-%dT%H:%M:%S")))+(([String](($([Decimal](Get-Date -UFormat ("%s")))%1))).Substring(1).PadRight(6,"0"))+(Get-Date -UFormat ("%Z")));

	# ------------------------------------------------------------
}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "Get-Timestamp";
}


# ------------------------------------------------------------