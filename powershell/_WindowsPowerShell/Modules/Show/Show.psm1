#
#	PowerShell - Show
#		|--> Writes a input variable(s) to output
#
Function Show() {
	#Param(
	#
	#	[Parameter(Mandatory=$False)]
	#	[ValidateLength(2,255)]
	#	[String]$AndAndName,
	#
	#	[Switch]$SkipConfirmation,
	#	[Switch]$Yes
	#	
	#)

	$Dashes = "`n`n------------------------------------------------------------`n";

	Write-Host "${Dashes}`n	`$MyInvocation.MyCommand	: ";
	Write-Output -NoEnumerate $MyInvocation.MyCommand | Get-Member;

	Write-Host "${Dashes}`n	`$PSScriptRoot	: ";
	Write-Output -NoEnumerate $PSScriptRoot | Get-Member;

	Write-Host "${Dashes}`n	`$args	:";
	Write-Output -NoEnumerate $args | Get-Member;

	Write-Host "${Dashes}`n	`$PsBoundParameters.Values	:";
	Write-Output -NoEnumerate $PsBoundParameters.Values | Get-Member;
	
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