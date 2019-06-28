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
		Write-Host "============================================================";
		Write-Host "`n`n --> Value (List):`n";
		$EachArg | Format-List;
		If ($ShowStructure -Eq $True) {
			Write-Host "`n`n --> Properties:`n";
			$Properties = (Get-Member -View ("All") -InputObject ($EachArg) | Where-Object { $_.MemberType -eq "Property"} | Select-Object { $_.Name };
			# $Properties | Format-List;
			$Properties | ForEach-Object { @{Key=$_;Value=$EachArg[$_]} };
			# Write-Host $EachArg[$_];
			# Get-Member -View ("All") -InputObject ($EachArg) | Where-Object { $_.MemberType -eq "Property"};
			Write-Host "`n`n --> Methods:`n";
			Get-Member -View ("All") -InputObject ($EachArg) | Where-Object { $_.MemberType -ne "Property"} | Write-Host;
			# $Methods = (Get-Member -View ("All") -InputObject ($EachArg) | Where-Object { $_.MemberType -eq "Property"} | Select-Object { $_.Name });
			# $Methods | Format-List;
			Get-Member -View ("All") -InputObject ($EachArg) | Where-Object { $_.MemberType -ne "Property"} | ForEach-Object { Write-Host $_ };
		}
		Write-Host "`n------------------------------------------------------------";
	}

	Return;

}
Export-ModuleMember -Function "Show";
# Install-Module -Name "Show"



#
#	Citation(s)
#
#		"Powershell: Everything you wanted to know about arrays"
#			|--> https://powershellexplained.com/2018-10-15-Powershell-arrays-Everything-you-wanted-to-know/#write-output--noenumerate
#			|--> by Kevin Marquette
#
#