#
#	PowerShell - Show
#		|
#		|--> Description:  Shows extended variable information to user
#		|
#		|--> Example:     Show -Test1 -Test2 -Test3 "Value3";
#
Function Show() {
	Param(
		[Switch]$Detailed,
		[Switch]$Methods,
		[Switch]$ShowMethods,
		[Parameter(Position=0, ValueFromRemainingArguments)]$inline_args
	)

	$ShowStructure = $False;
	If ($PSBoundParameters.ContainsKey('Detailed') -Eq $True) {
		$ShowStructure = $True;
	} ElseIf ($PSBoundParameters.ContainsKey('Methods') -Eq $True) {
		$ShowStructure = $True;
	} ElseIf ($PSBoundParameters.ContainsKey('ShowMethods') -Eq $True) {
		$ShowStructure = $True;
	}

	ForEach ($EachArg in ($inline_args+$args)) {
		Write-Output "============================================================";
		Write-Output "`n`n  --> Value (List):`n";
		If ($EachArg -Eq $Null) {
			Write-Output "`$Null";
		} Else {
			$EachArg | Format-List;
			If ($ShowStructure -Eq $True) {
				#
				# PROPERTIES
				#
				$ListProperties = (`
					Get-Member -InputObject ($EachArg) -View ("All") `
						| Where-Object { ("$($_.MemberType)".Contains("Propert")) -Eq $True } ` <# Matches *Property* and *Properties* #>
				);
				Write-Output "`n`n  --> Properties:`n";
				If ($ListProperties -Ne $Null) {
					$MaxLen = 0;
					$ListProperties | ForEach-Object { $EachName="$($_.Name)"; If ($EachName.Length -Gt $MaxLen) { $MaxLen = $EachName.Length; } };
					$MaxLen;
					$ListProperties | ForEach-Object { Write-Output "    $($($_.Name).PadRight(($MaxLen-($($_.Name).Length)),' '))  $($_.Definition)"; };
					# $ListProperties | ForEach-Object { $EachName="$($_.Name)"; Write-Output (("    ")+($EachName.PadRight(($MaxLen-$EachName.Length)," "))+("  $($_.Definition)")); };
					# $ListProperties | ForEach-Object { Write-Output $_; };
					# $ListProperties | ForEach-Object { Write-Output "    $($_.Name)  $()"; };
				} Else {
					Write-Output "    (no properties found)";
				}
				#
				# METHODS
				#
				$ListMethods = (`
					Get-Member -InputObject ($EachArg) -View ("All") `
						| Where-Object { ("$($_.MemberType)".Contains("Method")) -Eq $True } `
				);
				$ListMethods
				Write-Output "`n`n  --> Methods:`n";
				If ($ListMethods -Ne $Null) {
					Write-Output "    (none)";
					$ListMethods | ForEach-Object { Write-Output $_; };
					# $ListMethods | ForEach-Object { Write-Output "    $($_.Name)"; };
				} Else {
					Write-Output "    (none)";
				}
				#
				# OTHER MEMBERTYPES
				#
				$ListOthers = (`
					Get-Member -InputObject ($EachArg) -View ("All") `
						| Where-Object { ("$($_.MemberType)".Contains("Propert")) -Eq $False } `
						| Where-Object { ("$($_.MemberType)".Contains("Method")) -Eq $False } `
				);
				If ($ListOthers -Ne $Null) {
					Write-Output "`n`n  --> Other Types:`n";
					$ListOthers | ForEach-Object { Write-Output $_; };
				}
			}
		}
		Write-Output "`n------------------------------------------------------------";
	}

	Return;

}
Export-ModuleMember -Function "Show";
# Install-Module -Name "Show"



#
#	Citation(s)
#
#
#		docs.microsoft.com
#			|--> "Get-Member"
#			|--> https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-member?view=powershell-6
#
#
#		powershellexplained.com
#			|--> "Powershell: Everything you wanted to know about arrays"
#			|--> https://powershellexplained.com/2018-10-15-Powershell-arrays-Everything-you-wanted-to-know/#write-output--noenumerate
#			|--> by Kevin Marquette
#
#