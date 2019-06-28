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
		Write-Output "`n`n --> Value (List):`n";
		$EachArg | Format-List;
		If ($ShowStructure -Eq $True) {
			#
			# PROPERTIES
			#
			$ListProperties = (`
				Get-Member -InputObject ($EachArg) -View ("All") `
					| Where-Object { $_.MemberType -contains "Propert" <# Matches *Property* and *Properties* #> } `
			);
			If ($ListProperties -ne $Null) {
				Write-Output "`n`n --> Properties:`n";
				$ListProperties | ForEach-Object { Write-Output $_.Name; };
			}
			#
			# METHODS
			#
			$ListMethods = (`
				Get-Member -InputObject ($EachArg) -View ("All") `
					| Where-Object { $_.MemberType -contains "Method" } `
			);
			If ($ListMethods -ne $Null) {
				Write-Output "`n`n --> Methods:`n";
				$ListMethods | ForEach-Object { Write-Output $_.Name; };
			}
			#
			# OTHER MEMBERTYPES
			#
			$ListOthers = (`
				Get-Member -InputObject ($EachArg) -View ("All") `
					| Where-Object { $_.MemberType -NotContains "Propert" } `
					| Where-Object { $_.MemberType -NotContains "Method" } `
			);
			If ($ListOthers -ne $Null) {
				Write-Output "`n`n --> Other PSMemberTypes:`n";
				$ListOthers | ForEach-Object { Write-Output $_.Name; };
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