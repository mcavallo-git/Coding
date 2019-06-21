#
#	PowerShell - TaskSnipe
#		Kill all processes whose name contains a given substring
#
function TaskSnipe {
	Param(

		[Parameter(Mandatory=$true)]
		[ValidateLength(4,255)]
		[String]$Name,

		[Switch]$CurrentUserMustOwn,

		[Switch]$ExactImageName,

		[Switch]$Quiet

	)
	
	$SnipeList_PIDs = @();

	$TASKLIST_FILTERS = " /NH";

	If ($PSBoundParameters.ContainsKey('CurrentUserMustOwn')) {
		$TASKLIST_FILTERS += " /FI `"USERNAME eq ${Env:USERDOMAIN}\${Env:USERNAME}`"";
	}
	If ($PSBoundParameters.ContainsKey('ExactImageName')) {
		$TASKLIST_FILTERS += " /FI `"IMAGENAME eq ${Name}`"";
	}

	# TaskList | Select-Object -Unique | Sort-Object
	(CMD /C "TASKLIST${TASKLIST_FILTERS}") | Select-Object -Unique | ForEach-Object {
		# $_.Split(" ")[0];
		$Haystack = $_; # "Haystack", aka the string to parse (may have newlines aplenty)
		$RegexPattern = '^((?:[a-zA-Z\.]\ ?)+)(?<!\ )[\ \t]+([0-9]+)[\ \t]+([a-zA-Z]+)[\ \t]+([0-9]+)[\ \t]+([0-9\,]+\ [a-zA-Z])[\ \t]*$'; # Regex pattern which defines the "Needle" to match while parsing the through the "Haystack"
		$Needle = [Regex]::Match($Haystack, $RegexPattern); # Parse through the "Haystack", looking for the "Needle"
		Write-Host "`$Needle = [Regex]::Match(`"${Haystack}`", `"${RegexPattern}`");";
		Write-Host (("`$Needle.Success = ")+($Needle.Success));
		If ($Needle.Success -ne $False) {
			$Each_ImageName = $Needle.Groups[1].Value; $Each_ImageName;
			$Each_PID = $Needle.Groups[2].Value; $Each_PID;
			$Each_SessionName = $Needle.Groups[3].Value; $Each_SessionName;
			$Each_SessionNumber = $Needle.Groups[4].Value; $Each_SessionNumber;
			$Each_MemoryUsage = $Needle.Groups[5].Value; $Each_MemoryUsage;
		}
		Write-Host "------------------------------------------------------------`n`n";
	}



	# CMD /C "TASKKILL /FI `"USERNAME eq ${Env:USERDOMAIN}\${Env:USERNAME}`" /FI `"IMAGENAME eq ${IMAGENAME_TO_KILL}`""



	Return;
}
Export-ModuleMember -Function "TaskSnipe";
