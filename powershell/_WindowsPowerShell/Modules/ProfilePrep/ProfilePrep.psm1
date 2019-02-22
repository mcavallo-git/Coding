
function ProfilePrep {
	Param(
		[String]$MessageOnSuccess = 'Pass - Startup scripts configured (see $Profile)',
		[Switch]$Echo
	)

	# Ensure that the profile excript exists before attempting to write to it
	$ProfileExists = Test-Path -PathType "Leaf" -Path ($Profile);
	If ($ProfileExists -eq $false) {
		# Create the profile script (necessary action per-user), if not found to exist
		New-Item -ItemType "File" -Path ($Profile) -Value (("### Created on [ ")+(Get-Date -UFormat "%Y%m%d%H%M%S")+(" ] `n"))
		$ProfileExists = Test-Path -PathType "Leaf" -Path ($Profile);
		If ($ProfileExists -eq $false) {
			# Fail - Unable to Create [Powershell Profile Script]
			Write-Host (("Fail - Unable to Create [Powershell Profile Script]: ") + ($file.BaseName));
			Start-Sleep -Seconds 60;
			Exit 1;
		} Else {
			# Pass - Created Powershell Profile Script
			Write-Host (("Pass - Created Powershell Profile Script: ") + ($file.BaseName));
		}
	}


	# User-Specific set of commands to run whenever they open a PowerShell terminal
	$Pro = @{};
	$Pro.Which = "New-Alias which Get-Command;";
	$Pro.ImportModules_Build = "New-Alias ImportModules `"~\Documents\WindowsPowerShell\Modules\ImportModules.ps1`";";
	$Pro.ImportModules_Call = "ImportModules;";


	# Format each string-statement for Regex
	Foreach ($k In ($Pro.Keys)) { If (!(Get-Content $Profile | Select-String $Pro[$k].Replace("\", "\\"))) { (("`n")+($Pro[$k])) | Add-Content $Profile; } }
	

	If ($PSBoundParameters.ContainsKey('Echo')) {
		# $EchoFormatted = (('---  ')+($MessageOnSuccess)+('   ---'));
		$EchoFormatted = $MessageOnSuccess;
		$EchoDashes = "-" * ($EchoFormatted.length);
		Write-Host (("`n`n") + ($EchoDashes) + ("`n") + ($EchoFormatted) + ("`n") + ($EchoDashes) + ("`n`n"));
	}

}

Export-ModuleMember -Function "ProfilePrep";
