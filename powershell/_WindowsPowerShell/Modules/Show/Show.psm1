#
#	PowerShell - Show
#		|
#		|--> Description:  Shows extended variable information to user
#		|
#		|--> Example:     Show -Test1 -Test2 -Test3 "Value3";
#
Function Show() {

	# $VarsObj = @{};
	# $VarsObj["MyInvocation"] = ($MyInvocation); # MyInvocation.MyCommand
	# $VarsObj["PSScriptRoot"] = ($PSScriptRoot);
	# $VarsObj["PsBoundParameters"] = ($PsBoundParameters); # PsBoundParameters.Values
	# $VarsObj["args"] = ($args);

	ForEach ($EachVarValue in $args) {
		Write-Output "============================================================";
		# Write-Output "`n`n--> Variable Name:`n";
		# Write-Output "`$($EachVarValue.Name)";
		Write-Output "`n`n--> Value (List):`n";
		$EachVarValue | Format-List;
		Write-Output "`n`n--> Methods:`n";
		Get-Member -View ("All") -InputObject ($EachVarValue) ;
		Write-Output "`n------------------------------------------------------------";
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