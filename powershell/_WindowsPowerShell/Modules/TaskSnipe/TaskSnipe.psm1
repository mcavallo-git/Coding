#
#	PowerShell - TaskSnipe
#		Kill all processes whose name contains a given substring
#
function TaskSnipe {
	Param(

		[Parameter(Mandatory=$True)]
		[ValidateLength(2,255)]
		[String]$Name,

		[Parameter(Mandatory=$False)]
		[ValidateLength(2,255)]
		[String]$AndName,

		[Parameter(Mandatory=$False)]
		[ValidateLength(2,255)]
		[String]$AndAndName,

		[Switch]$CaseSensitive,

		[Switch]$CurrentUserMustOwn,

		[Switch]$MatchWholeName,

		[Switch]$Quiet

	)
	
	$SnipeList = @();

	# Case Insensitive searching (default mode)
	If ($PSBoundParameters.ContainsKey('CaseSensitive') -Eq $False) {
		$Name = $Name.ToLower();
		If ($PSBoundParameters.ContainsKey('AndName') -Eq $True) {
			$AndName = $AndName.ToLower();
		}
		If ($PSBoundParameters.ContainsKey('AndAndName') -Eq $True) {
			$AndAndName = $AndAndName.ToLower();
		}
	}

	# Process must be owned by runtime (current) user
	$FI_USERNAME = "";
	If ($PSBoundParameters.ContainsKey('CurrentUserMustOwn') -Eq $True) {
		$FI_USERNAME = " /FI `"USERNAME eq ${Env:USERDOMAIN}\${Env:USERNAME}`"";
	}

	# Image Name must be Exact
	$FI_IMAGENAME = "";
	If ($PSBoundParameters.ContainsKey('MatchWholeName') -Eq $True) {
		$FI_IMAGENAME += " /FI `"IMAGENAME eq ${Name}`"";
	}

	# Parse the list of returned, matching tasks
	(CMD /C "TASKLIST /NH${FI_USERNAME}${FI_IMAGENAME}") <# | Select-Object -Unique #> | ForEach-Object {
		$Haystack = $_;
		$RegexPattern = '^((?:[a-zA-Z\.]\ ?)+)(?<!\ )[\ \t]+([0-9]+)[\ \t]+([a-zA-Z]+)[\ \t]+([0-9]+)[\ \t]+([0-9\,]+\ [a-zA-Z])[\ \t]*$';
		$Needle = [Regex]::Match($Haystack, $RegexPattern);
		# Perform regular expression (Regex) capture-group matching to neatly recombine each line of space-delimited output into a workable form
		If ($Needle.Success -ne $False) {
			$Each_ImageName = $Needle.Groups[1].Value;
			# Case sensitive check
			If ($PSBoundParameters.ContainsKey('CaseSensitive') -Eq $False) {
				$Each_ImageName = $Each_ImageName.ToLower();
			}
			# Final checks for name-matching
			If ($Each_ImageName.Contains($Name) -Eq $True) {
				If (($PSBoundParameters.ContainsKey('AndName') -Eq $False) -Or ($Each_ImageName.Contains($AndName) -Eq $True)) {
					If (($PSBoundParameters.ContainsKey('AndAndName') -Eq $False) -Or ($Each_ImageName.Contains($AndAndName) -Eq $True)) {
						# Success - This item is determined to match all user-defined criteria
						$NewSnipe = @{};
						$NewSnipe.IMAGENAME   += $Needle.Groups[1].Value;
						$NewSnipe.PID         += $Needle.Groups[2].Value;
						$NewSnipe.SESSIONNAME += $Needle.Groups[3].Value;
						$NewSnipe.SESSION     += $Needle.Groups[4].Value;
						$NewSnipe.MEMUSAGE    += $Needle.Groups[5].Value;
						# Push the new object of values onto the final results array
						$SnipeList += $NewSnipe;
					} Else {
						# Skip - ImageName doesn't also match parameter 'AndAndName'
					}
				} Else {
					# Skip - ImageName doesn't also match parameter 'AndName'
				}
			}
		}
	}

	# Pipe the results through the snipe-handler
	If ($SnipeList.Count -ne 0) {
		# At least one matching process was found
		$SnipeList | Format-List;
		# CMD /C "TASKKILL /FI `"USERNAME eq ${Env:USERDOMAIN}\${Env:USERNAME}`" /FI `"IMAGENAME eq ${IMAGENAME_TO_KILL}`""


	} Else {
		# No results found
	}




	Return;
}
Export-ModuleMember -Function "TaskSnipe";
