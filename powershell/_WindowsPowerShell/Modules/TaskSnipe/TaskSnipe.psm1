#
#	PowerShell - TaskSnipe
#		Kill all processes whose name contains a given substring
#
function TaskSnipe {
	Param(

		[Parameter(Mandatory=$true)]
		[ValidateLength(4,255)]
		[String]$SnipeTarget,

		[Switch]$CurrentUserMustOwn,

		[Switch]$ExactImageName,

		[Switch]$Quiet

	)
	
	$ProcessSnipeList = @();

	$TASKLIST_FILTERS = " /NH";

	If ($PSBoundParameters.ContainsKey('CurrentUserMustOwn')) {
		$TASKLIST_FILTERS += " /FI `"USERNAME eq ${Env:USERDOMAIN}\${Env:USERNAME}`"";
	}
	If ($PSBoundParameters.ContainsKey('ExactImageName')) {
		$TASKLIST_FILTERS += " /FI `"IMAGENAME eq ${SnipeTarget}`"";
	}

	# TaskList | Select-Object -Unique | Sort-Object
	(CMD /C "TASKLIST${TASKLIST_FILTERS}") | Select-Object -Unique | ForEach-Object {
		# $_.Split(" ")[0];
		$Haystack = $_; # "Haystack", aka the string to parse (may have newlines aplenty)
		$RegexPattern = '^(\S+)\s+(\S+)\s+(\S+)\s+(\S+\ [a-zA-Z])\s*$'; # Regex pattern which defines the "Needle" to match while parsing the through the "Haystack"
		$Needle = [Regex]::Match($Haystack, $RegexPattern); # Parse through the "Haystack", looking for the "Needle"
		Write-Host (("`$Needle.Success = ")+($Needle.Success));
		If ($Needle.Success -ne $False) {
			$Needle.Groups[0].Value; 
			$Needle.Groups[1].Value; 
			$Needle.Groups[2].Value; 
			$Needle.Groups[3].Value; 
		}
		Write-Host "------------------------------------------------------------`n`n";
	}



	# CMD /C "TASKKILL /FI `"USERNAME eq ${Env:USERDOMAIN}\${Env:USERNAME}`" /FI `"IMAGENAME eq ${IMAGENAME_TO_KILL}`""



	Return;
}
Export-ModuleMember -Function "TaskSnipe";
