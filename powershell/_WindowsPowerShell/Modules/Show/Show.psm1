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

	$Dashes = "`n`n------------------------------------------------------------`n";

	$ShowVar = $MyInvocation.MyCommand;
	Write-Host "`$MyInvocation.MyCommand	: ";
	Write-Host "${Dashes}";
	If ($PSBoundParameters.ContainsKey('Enumerate') -Eq $False) {
		Write-Output -NoEnumerate $ShowVar | Get-Member;
	} Else {
		Write-Output $ShowVar | Get-Member;
	}

	$ShowVar = $PSScriptRoot;
	Write-Host "`$PSScriptRoot	: ";
	Write-Host "${Dashes}";
	If ($PSBoundParameters.ContainsKey('Enumerate') -Eq $False) {
		Write-Output -NoEnumerate $ShowVar | Get-Member;
	} Else {
		Write-Output $ShowVar | Get-Member;
	}

	$ShowVar = $args;
	Write-Host "`$args	: ";
	Write-Host "${Dashes}";
	If ($PSBoundParameters.ContainsKey('Enumerate') -Eq $False) {
		Write-Output -NoEnumerate $ShowVar | Get-Member;
	} Else {
		Write-Output $ShowVar | Get-Member;
	}

	$ShowVar = $PsBoundParameters.Values;
	Write-Host "`$PsBoundParameters.Values	: ";
	Write-Host "${Dashes}";
	If ($PSBoundParameters.ContainsKey('Enumerate') -Eq $False) {
		Write-Output -NoEnumerate $ShowVar | Get-Member;
	} Else {
		Write-Output $ShowVar | Get-Member;
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