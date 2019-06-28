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
		If ($EachArg -eq $Null) {
			Write-Output "`$Null";
		} Else {
			$EachArg | Format-List;
			If ($ShowStructure -Eq $True) {
				#
				# PROPERTIES
				#
				$ListProperties = (`
					Get-Member -InputObject ($EachArg) -View ("All") `
						| Where-Object { ("$($_.MemberType)".Contains("Propert")) -eq $True } ` <# Matches *Property* and *Properties* #>
				);
				Write-Output "`n`n  --> Properties:`n";
				If ($ListProperties -ne $Null) {
					Write-Output "    (no properties found)";
				} Else {
					$ListProperties | ForEach-Object { Write-Output "    $($_)"; };
					# $ListProperties | ForEach-Object { Write-Output "    $($_.Name)"; };
				}
				#
				# METHODS
				#
				$ListMethods = (`
					Get-Member -InputObject ($EachArg) -View ("All") `
						| Where-Object { ("$($_.MemberType)".Contains("Method")) -eq $True } `
				);
				Write-Output "`n`n  --> Methods:`n";
				If ($ListMethods -ne $Null) {
					Write-Output "    (none)";
				} Else {
					$ListMethods | ForEach-Object { Write-Output "    $($_)"; };
					# $ListMethods | ForEach-Object { Write-Output "    $($_.Name)"; };
				}
				#
				# OTHER MEMBERTYPES
				#
				$ListOthers = (`
					Get-Member -InputObject ($EachArg) -View ("All") `
						| Where-Object { ("$($_.MemberType)".Contains("Propert")) -eq $False } `
						| Where-Object { ("$($_.MemberType)".Contains("Method")) -eq $False } `
				);
				Write-Output "`n`n  --> Other PSMemberTypes:`n";
				If ($ListOthers -ne $Null) {
					Write-Output "    (none)";
				} Else {
					$ListOthers | ForEach-Object { Write-Output "    $($_)"; };
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