
function BombOut {
	Param(

		[Parameter(Mandatory=$true)]
		[Int]$ExitCode,

		[String]$MessageOnError,

		$MessageOnErrorJSON,

		[String]$MessageOnSuccess,
		
		$MessageOnSuccessJSON,

		[Int]$ExitAfterSeconds = 600,

		[Switch]$NoAzLogout,
		
		[Switch]$AzLogoutOnErrors,
		
		[Switch]$Quiet

	)

	If ($ExitCode -eq 0) {

		# Pass - No errors found

		If ($PSBoundParameters.ContainsKey('MessageOnSuccessJSON')) {
			If (!($PSBoundParameters.ContainsKey('Quiet'))) {
				$SuccessStringFromJSON = [PSCustomObject]$MessageOnSuccessJSON | Format-List | Out-String;
				Write-Host ($SuccessStringFromJSON) -BackgroundColor Black -ForegroundColor green;
			}
		}

		If ($PSBoundParameters.ContainsKey('MessageOnSuccess')) {
			If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host ($MessageOnSuccess) -BackgroundColor Black -ForegroundColor green; }
		}

	} Else {

		# Fail - Errors exist, bomb-out

		If ($PSBoundParameters.ContainsKey('MessageOnErrorJSON')) {
			$ErrorStringFromJSON = [PSCustomObject]$MessageOnErrorJSON | Format-List | Out-String;
			Write-Host ($ErrorStringFromJSON) -BackgroundColor Black -ForegroundColor red;
		}
		
		If ($PSBoundParameters.ContainsKey('MessageOnError')) {
			Write-Host ($MessageOnError) -BackgroundColor Black -ForegroundColor red;
		}

		# On Error - Logout from Azure
		If ($PSBoundParameters.ContainsKey('AzLogoutOnErrors')) {

			Write-Host (("`n`nFail - Clearing azure session via [ az account clear --verbose ]..."));
			az account clear --verbose;
			
		} Else {

			Write-Host (("`n`nSkip - Clearing azure session (called with -NoAzLogout)"));

		}

		Write-Host (("`n`nFail - Exiting after ")+($ExitAfterSeconds)+(" seconds..."));
		Start-Sleep -Seconds ($ExitAfterSeconds);
		Exit;

	}

}

Export-ModuleMember -Function "BombOut";
