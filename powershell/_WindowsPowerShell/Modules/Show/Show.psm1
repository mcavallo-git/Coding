#
#	PowerShell - Show
#		|
#		|--> Description:  Shows extended variable information to user
#		|
#		|--> Example:     PowerShell -Command ("Show `$MyInvocation -Methods")
#
Function Show() {
	Param(
		[Switch]$NoProperties,
		[Switch]$NoMethods,
		[Switch]$NoOther,
		[Switch]$NoEtc,
		[Parameter(Position=0, ValueFromRemainingArguments)]$inline_args
	)

	$ShowProperties = (-Not $PSBoundParameters.ContainsKey('NoProperties'));

	$ShowMethods = (-Not $PSBoundParameters.ContainsKey('NoMethods'));

	$ShowEtc = (-Not ($PSBoundParameters.ContainsKey('NoEtc') -Or $PSBoundParameters.ContainsKey('NoOther')));

	ForEach ($EachArg in ($inline_args+$args)) {
		Write-Output "============================================================";
		Write-Output "`n`n  --> Value (as a list):`n";
		If ($EachArg -Eq $Null) {
			Write-Output "`$Null";
		} Else {
			$EachArg | Format-List;
			If ($ShowProperties -Eq $True) {
				#
				# PROPERTIES
				#
				$ListProperties = (`
					Get-Member -InputObject ($EachArg) -View ("All") `
						| Where-Object { ("$($_.MemberType)".Contains("Propert")) -Eq $True } ` <# Matches *Property* and *Properties* #>
				);
				Write-Output "`n`n  --> Properties (hide with -NoProperties):`n";
				If ($ListProperties -Ne $Null) {
					$ListProperties | ForEach-Object {
						$EachVal = If ($EachArg.($($_.Name)) -eq $Null) { "`$NULL" } Else { $EachArg.($($_.Name)) };
						Write-Output "    $($_.Name) = $($EachVal)";
					};
				} Else {
					Write-Output "    (no properties found)";
				}
			}
			If ($ShowMethods -Eq $True) {
				#
				# METHODS
				#
				$ListMethods = (`
					Get-Member -InputObject ($EachArg) -View ("All") `
						| Where-Object { ("$($_.MemberType)".Contains("Method")) -Eq $True } `
				);
				Write-Output "`n`n  --> Methods (hide with -NoMethods):`n";
				If ($ListMethods -Ne $Null) {
					Write-Output "    (none)";
					$ListMethods | ForEach-Object { Write-Output "    $($_.Name)"; };
				} Else {
					Write-Output "    (none)";
				}
			}
			If ($ShowEtc -Eq $True) {
				#
				# OTHER MEMBERTYPES
				#
				$ListOthers = (`
					Get-Member -InputObject ($EachArg) -View ("All") `
						| Where-Object { ("$($_.MemberType)".Contains("Propert")) -Eq $False } `
						| Where-Object { ("$($_.MemberType)".Contains("Method")) -Eq $False } `
				);
				If ($ListOthers -Ne $Null) {
					Write-Output "`n`n  --> Other Types (hide with -NoOther or -NoEtc):`n";
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