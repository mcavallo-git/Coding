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

		[Switch]$Quiet,

		[Switch]$SkipConfirm


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
	$TASK_FILTERS = "${FI_USERNAME}${FI_IMAGENAME}";
	(CMD /C "TASKLIST /NH${TASK_FILTERS}") <# | Select-Object -Unique #> | ForEach-Object {
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
		#
		# At least one matching process was found
		#
		Write-Host (("`n`nFound ")+($SnipeList.Count)+(" PID(s) matching search criteria:`n")) -ForegroundColor "Green";
		$SnipeList | ForEach-Object {
			$EachIMAGENAME = $_.IMAGENAME;
			$EachPID = $_.PID;
			# $FI_PID  = " /FI `"PID eq ${EachPID}`"";
			# CMD /C "TASKLIST ${TASK_FILTERS}${FI_PID}";
			Write-Host "  PID ${EachPID} - ${EachIMAGENAME}";
		}

		#
		# Make the user confirm before killing tasks (default, or call with -SkipConfirm to kill straight-away)
		#
		If ($PSBoundParameters.ContainsKey('SkipConfirm') -Eq $True) {
			#
			# Skip Confirm
			#
			$FirstConfirm = $True;
		} Else {
			#
			# First Confirmation step "Are you sure ... ?"
			#
			$ConfirmKeyList = "abcdefghijklmopqrstuvwxyz"; # removed 'n'
			$FirstConfKey = (Get-Random -InputObject ([char[]]$ConfirmKeyList));
			Write-Host -NoNewLine ("Are you sure you want to kill these PID(s)?") -BackgroundColor "Black" -ForegroundColor "Yellow";
			Write-Host -NoNewLine ("`n`n");
			Write-Host -NoNewLine ("  Press the `"") -ForegroundColor "Yellow;"
			Write-Host -NoNewLine ($FirstConfKey) -ForegroundColor "Green";
			Write-Host -NoNewLine ("`" key to confirm:  ") -ForegroundColor "Yellow";
			$UserKeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'); Write-Host (($UserKeyPress.Character)+("`n"));
			$FirstConfirm = (($UserKeyPress.Character) -eq ($FirstConfKey));
		}
		#
		# Check First Confirm
		#
		If ($FirstConfirm -Eq $True) {
			If ($PSBoundParameters.ContainsKey('SkipConfirm') -Eq $True) {
				#
				# Skip Confirm
				#
				$SecondConfirm = $True;
			} Else {
				#
				# Second Confirmation step "Really really sure?" 
				#
				$SecondConfKey = (Get-Random -InputObject ([char[]]$ConfirmKeyList.Replace([string]$FirstConfKey,"")));
				Write-Host -NoNewLine ("Really really sure?") -BackgroundColor Black -ForegroundColor Yellow;
				Write-Host -NoNewLine ("  Press the `"") -ForegroundColor Yellow;
				Write-Host -NoNewLine ($SecondConfKey) -ForegroundColor Green;
				Write-Host -NoNewLine ("`" key to lock-in your decision and send the kill command(s):  ") -ForegroundColor Yellow;
				$UserKeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
				$SecondConfirm = (($UserKeyPress.Character) -eq ($SecondConfKey));
			}
			#
			# Check Second Confirm
			#
			If ($SecondConfirm -Eq $True) {
				# !!! CONFIRMED - KILL TASKS BY-PID
				Write-Host "  Confirmed. Killing associated processes...";
				$SnipeList | ForEach-Object {
					$EachPID = $_.PID;
					$FI_PID  = " /FI `"PID eq ${EachPID}`"";
					CMD /C "TASKKILL /V ${TASK_FILTERS}${FI_PID}";
				}
			} Else {
				#
				# User bailed-out of the confirmation, cancelling the kill PID(s) action
				#
				Write-Host "Bail-Out @ Second confirmation - No Action(s) performed" -ForegroundColor "Red" -BackgroundColor "Black";
			}
		} Else {
			#
			# User bailed-out of the FIRST confirmation, cancelling the kill PID(s) action
			#
			Write-Host "Bail-Out @ First confirmation - No Action(s) performed" -ForegroundColor "Red" -BackgroundColor "Black";
		}

	} Else {
		# No results found
	}




	Return;
}
Export-ModuleMember -Function "TaskSnipe";
