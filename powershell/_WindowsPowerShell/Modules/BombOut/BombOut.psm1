
function BombOut {
	Param(

		[Parameter(Mandatory=$true)]
		[Int]$ExitCode,

		[String]$MessageOnError,

		$MessageOnErrorJSON,

		[String]$MessageOnSuccess,
		
		$MessageOnSuccessJSON,

		[Int]$ExitAfterSeconds = 600,

		[switch]$NoAzLogout,
		
		[switch]$Echo

	)

	If ($ExitCode -ne 0) {
		# Errors Exist - Bomb-out
		If ($PSBoundParameters.ContainsKey('MessageOnError')) { Write-Host (("`n`n ")+($MessageOnError)); }
		If ($PSBoundParameters.ContainsKey('MessageOnErrorJSON')) { [PSCustomObject]$MessageOnErrorJSON; }

		# On Error - Logout from Azure
		If (!($PSBoundParameters.ContainsKey('NoAzLogout'))) { 
			Write-Host (("`n`n Clearing azure session via [ az account clear --verbose ]..."));
			az account clear --verbose;
		}

		Write-Host (("`n`n Exiting after ")+($ExitAfterSeconds)+(" seconds..."));
		Start-Sleep -Seconds ($ExitAfterSeconds);
		Exit;

	} Else {
		# Success! No errors found
		If ($PSBoundParameters.ContainsKey('MessageOnSuccess')) { Write-Host ((" ")+($MessageOnSuccess)); }
		If ($PSBoundParameters.ContainsKey('MessageOnSuccessJSON')) { [PSCustomObject]$MessageOnSuccessJSON; }

	}

}

Export-ModuleMember -Function "BombOut";
