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

	$VariablesToShow = @{
		MyInvocation_MyCommand = ($MyInvocation.MyCommand);
		PSScriptRoot = ($PSScriptRoot);
		PsBoundParameters_Values = ($PsBoundParameters.Values);
		args = ($args);
	};

	$Dashes = "`n------------------------------------------------------------`n";
	ForEach ($VarName in $VariablesToShow.Keys) {
		$VarValue = $VariablesToShow[$VarName];
		Write-Output "${Dashes}`$$(${VarName})	: ";
		Write-Output "";
		If ($PSBoundParameters.ContainsKey('Enumerate') -Eq $False) {
			Get-Variable -Name ($VarValue) | Write-Output -NoEnumerate | Get-Member;
		} Else {
			Get-Variable -Name ($VarValue) | Write-Output | Get-Member;
		}
		Write-Output "${Dashes}";
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