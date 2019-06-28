#
#	PowerShell - Show
#		|--> Writes a input variable(s) to output
#
Function Show() {
	Param(
	
		# [Parameter(Mandatory=$False)]
		# [ValidateLength(2,255)]
		# [String]$AndAndName,
	
		[Switch]$Enumerate
		
	)

	$VariablesToShow = @{};
	$VariablesToShow["MyInvocation.MyCommand"] = ($MyInvocation.MyCommand);
	$VariablesToShow["PSScriptRoot"] = ($PSScriptRoot);
	$VariablesToShow["PsBoundParameters.Values"] = ($PsBoundParameters.Values);
	$VariablesToShow["args"] = ($args);

	ForEach ($VarName in $VariablesToShow.Keys) {
		$VarValue = $VariablesToShow[$VarName];
		Write-Output "------------------------------------------------------------";
		Write-Output "`n`nVariable Name";
		Write-Output "	`$$(${VarName})";
		Write-Output "`n`nVariable Value";
		$VarValue | Format-List;
		Write-Output "`n`nVariable Info";
		If ($PSBoundParameters.ContainsKey('Enumerate') -Eq $False) {
			Write-Output -NoEnumerate $VarValue | Get-Member;
		} Else {
			Write-Output $VarValue | Get-Member;
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
#		"Powershell: Everything you wanted to know about arrays"
#			|--> https://powershellexplained.com/2018-10-15-Powershell-arrays-Everything-you-wanted-to-know/#write-output--noenumerate
#			|--> by Kevin Marquette
#
#